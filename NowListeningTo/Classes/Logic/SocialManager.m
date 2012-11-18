//
//  SocialManager.m
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/13/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import "SocialManager.h"
#import "MusicHelper.h"
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "LogManager.h"
#import "StatusView.h"
#import "AFNetworking.h"
#import "OpenUDID.h"
#import "LoadingView.h"

#define kAccountsDictionary @"kAccountsDictionary"
// #define kServerBaseUrl @"http://cryptic-meadow-8748.herokuapp.com/"
#define kServerBaseUrl @"http://127.0.0.1"

@implementation SocialManager
@synthesize accountStore, accountsSettings;

#pragma mark - Private

-(void)shareSongWithTwitterAccount: (Song *)aSong{
    ACAccountType *twitterAccountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [self.accountStore requestAccessToAccountsWithType:twitterAccountType
                                               options:nil
                                            completion:^(BOOL granted, NSError *error) {
                                                
                                                if (granted){
                                                    //  SUCCESS: Access granted
                                                    NSArray *accounts = [self.accountStore accountsWithAccountType:twitterAccountType];
                                                    
                                                    //  #TODO this should be customizable on settings
                                                    ACAccount *anAccount = [accounts lastObject];
                                                    
                                                    NSString *songString = [MusicHelper songStringWithSong:aSong];
                                                    
                                                    NSDictionary *parameters = @{@"status": songString};
                                                    NSURL *feedURL = [NSURL URLWithString:@"https://api.twitter.com/1/statuses/update.json"];
                                                    
                                                    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                                                            requestMethod:SLRequestMethodPOST
                                                                                                      URL:feedURL
                                                                                               parameters:parameters];
                                                    request.account = anAccount;
                                                    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                                        //  Handle errors
                                                        
                                                        NSString *logString = nil;
                                                        NSString *messageType = nil;
//                                                        NSString *response = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                                                        
                                                        if (error){
                                                            logString = [NSString stringWithFormat:@"ERROR on Twitter: %@", [error debugDescription]];
                                                            messageType = kMessageTypeError;
                                                        }else{
                                                            logString = @"Succesfully posted on Twitter";
                                                            messageType = kMessageTypeSuccess;
                                                        }
                                                        
                                                        [StatusView displayStatusMessage:logString withType:messageType];
                                                        [[LogManager sharedInstance] addLog:logString];
                                                        self.pendingTasks--;
                                                    }];
                                                    
                                                }else{
                                                    //  FAIL: Access NOT grantes
                                                    if (error){
                                                        NSString *anErrorString = @"ERROR on Twitter";
                                                        [StatusView displayStatusMessage:anErrorString withType:kMessageTypeError];
                                                        [[LogManager sharedInstance] addLog:anErrorString];
                                                    }
                                                    self.pendingTasks--;
                                                }                                                
                                            }
     ];
}

-(void)publishFacebookStory{
        
    NSMutableDictionary *paramsDict = [@{
                                        @"message" : [MusicHelper songStringWithSong:[MusicHelper currentSong]],
                                        @"link" : @"https://github.com/betzerra/NowListeningTo",
                                        @"picture" : @"http://asandbox.com.ar/nowlisteningto/icon_facebook.png",
                                        @"name" : @"NowListeningToApp",
                                        @"caption" : @"By @betzerra",
                                        @"description" : @"NowListeningTo is an open-source iOS app that let you share the music you're listening to into your favorite social networks"
                                       } mutableCopy];
    
    [FBRequestConnection startWithGraphPath:@"me/feed"
                                 parameters:paramsDict
                                 HTTPMethod:@"POST"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error) {
                              
                              NSString *logText = nil;
                              NSString *messageType = nil;
                              if (error) {
                                  logText = @"ERROR on Facebook";
                                  messageType = kMessageTypeError;
                              } else {
                                  logText = @"Succesfully posted on Facebook";
                                  messageType = kMessageTypeSuccess;
                              }
                              [StatusView displayStatusMessage:logText withType:messageType];
                              [[LogManager sharedInstance] addLog:logText];
                              self.pendingTasks--;
                          }];
}

-(void)shareSongWithFacebookAccount: (Song *)aSong{
    if (FBSession.activeSession.isOpen){
        // Ask for publish_actions permissions in context
        if ([FBSession.activeSession.permissions
             indexOfObject:@"publish_actions"] == NSNotFound) {
            
            // No permissions found in session, ask for it
            [FBSession.activeSession reauthorizeWithPublishPermissions: @[@"publish_actions"]
                                                       defaultAudience:FBSessionDefaultAudienceEveryone
                                                     completionHandler:^(FBSession *session, NSError *error) {
                                                         
                                                         if (!error) {
                                                             // If permissions granted, publish the story
                                                             [self publishFacebookStory];
                                                         }
                                                     }];
            
        } else {
            // If permissions present, publish the story
            [self publishFacebookStory];
        }
    }else{
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate openSessionWithAllowLoginUI:YES withCompletionBlock:^(BOOL success) {

            if (success){
                [self publishFacebookStory];
            }else{
                NSString *logText = @"ERROR on Facebook openSessionWithAllowLoginUI";
                [[LogManager sharedInstance] addLog:logText];
                [StatusView displayStatusMessage:logText withType:kMessageTypeError];
                self.pendingTasks--;
            }
            
        }];
    }
}

#pragma mark - Properties

-(void)setPendingTasks:(NSInteger)newValue{
    if (pendingTasks != newValue){
        pendingTasks = newValue;
        if (pendingTasks <= 0){
            [[NSNotificationCenter defaultCenter] postNotificationName:kHideLoadingViewNotification object:nil];
        }        
    }
}

-(NSInteger)pendingTasks{
    return pendingTasks;
}

#pragma mark - Public

-(id)init{
    self = [super init];
    if (self){
        self.pendingTasks = 0;
        self.accountStore = [[ACAccountStore alloc] init];
        accountsSettings = [[NSMutableDictionary alloc] init];
        
        NSDictionary *socialAccounts = [[NSUserDefaults standardUserDefaults] objectForKey:kAccountsDictionary];
        if (socialAccounts){
            [accountsSettings addEntriesFromDictionary:socialAccounts];
        }
    }
    return self;
}

-(void)shareSongWithNLTServer:(Song *)aSong{
    
    [self checkUserWithCompletionBlock:^{
        //  Get base URL, we'll specify the path later
        NSURL *baseUrl = [NSURL URLWithString:kServerBaseUrl];
        
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseUrl];
        
        Song *song = aSong;
        
        if (song == nil){
            song = [[Song alloc] init];
            song.title = @"Lorem Ipsum";
            song.artist = @"The Lipsums";
        }
        
        //  Get the parameters that are going to be posted
        NSDictionary *params = @{
                                @"song" : song.title,
                                @"artist" : song.artist,
                                @"udid" : [OpenUDID value],
                                @"format" : @"json"
                                };
        
        NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/posts" parameters:params];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.completionBlock = ^{
            NSError *anError = nil;
            //        NSLog(@"LOG: %@", operation.responseString);
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                                         options:NSJSONReadingAllowFragments
                                                                           error:&anError];
            NSString *messageString = nil;
            NSString *messageType = kMessageTypeDefault;
            
            if (anError){
                messageString = anError.debugDescription;
                messageType = kMessageTypeError;
                NSLog(@"#DEBUG Error: %@", messageString);
                
            }else{
                NSString *errorMessage = [responseDict objectForKey:@"error"];
                NSString *responseString = [responseDict objectForKey:@"message"];
                
                if (errorMessage){
                    messageType = kMessageTypeError;
                    messageString = errorMessage;
                    NSLog(@"#DEBUG Error: %@", messageString);
                    
                }else if (responseString){
                    messageType = kMessageTypeSuccess;
                    messageString = responseString;
                }else{
                    messageString = @"Unknown response from #NLTApp";
                }
            }
            
            self.pendingTasks--;
            [StatusView displayStatusMessage:messageString withType:messageType];
        };
        
        [operation start];
    }];
}

-(void)saveToDisk{
    [[NSUserDefaults standardUserDefaults] setObject:accountsSettings forKey:kAccountsDictionary];
}

-(void)shareSong:(Song *)aSong{

    if ([self isAccountEnabledForShare:kAccountTwitter]){
        [self shareSongWithTwitterAccount:aSong];
        self.pendingTasks++;
    }
    
    if ([self isAccountEnabledForShare:kAccountFacebook]){
        [self shareSongWithFacebookAccount:aSong];
        self.pendingTasks++;
    }
    
    if ([self isAccountEnabledForShare:kAccountListeningTo]){
        [self shareSongWithNLTServer:aSong];
        self.pendingTasks++;
    }
}

-(void)checkUserWithCompletionBlock:(void (^)(void))aBlock{
    //  Get base URL, we'll specify the path later
    NSURL *baseUrl = [NSURL URLWithString:kServerBaseUrl];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseUrl];

    //  Get the parameters that are going to be posted
    NSDictionary *params = @{
                            @"udid" : [OpenUDID value],
                            @"format" : @"json"
                            };
    
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"users/exists" parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.completionBlock = ^{
        NSError *anError = nil;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                                     options:NSJSONReadingAllowFragments
                                                                       error:&anError];
        
        BOOL exists = [[responseDict objectForKey:@"response"] boolValue];
        if (!anError && exists){
            aBlock();
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:kDisplaySignUpNotification object:nil];
        }
    };
    
    [operation start];
}

-(void)signUpUserWithParams:(NSDictionary *)aDictionary{
    //  Get base URL, we'll specify the path later
    NSURL *baseUrl = [NSURL URLWithString:kServerBaseUrl];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseUrl];
    
    //  Get the parameters that are going to be posted
    NSDictionary *params = @{
                            @"udid" : [OpenUDID value],
                            @"email" : [aDictionary objectForKey:@"email"],
                            @"username" : [aDictionary objectForKey:@"username"],
                            @"password" : [aDictionary objectForKey:@"password"],
                            @"format" : @"json"
                            };
    
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"users/create" parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.completionBlock = ^{
        NSError *anError = nil;
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                                     options:NSJSONReadingAllowFragments
                                                                       error:&anError];
        NSLog(@"#DEBUG response: %@", operation.responseString);
    };
    
    [operation start];
}

-(BOOL)isAccountEnabledForShare:(NSString *)anAccountId{
    BOOL retVal = NO;
    
    NSNumber *anAccountSetting = [accountsSettings objectForKey:anAccountId];
    if (anAccountSetting == nil){
        anAccountSetting = @YES;
        [self setAccount:anAccountId enabled:YES];
    }
    
    retVal = [anAccountSetting boolValue];
    return retVal;
}

-(void)setAccount:(NSString *)anAccountId enabled:(BOOL)isEnabled{
    NSNumber *aValue = [NSNumber numberWithBool:isEnabled];
    [accountsSettings setObject:aValue forKey:anAccountId];
}

//  Singleton method proposed in WWDC 2012
+ (SocialManager *)sharedInstance {
	static SocialManager *sharedInstance;
	if (sharedInstance == nil)
		sharedInstance = [SocialManager new];
	return sharedInstance;
}

@end
