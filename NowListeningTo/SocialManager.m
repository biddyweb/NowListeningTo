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

@implementation SocialManager
@synthesize accountStore;

#pragma mark - Private

-(void)shareSongWithTwitterAccount: (Song *)aSong{
    ACAccountType *twitterAccountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [self.accountStore requestAccessToAccountsWithType:twitterAccountType
                                               options:nil
                                            completion:^(BOOL granted, NSError *error) {
                                                
                                                if (granted){
                                                    //  Success
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
                                                        
                                                        if (error){
                                                            NSLog(@"#DEBUG ERROR: %@", [error debugDescription]);
                                                        }
                                                    }];
                                                    
                                                }else{
                                                    //  Fail
                                                    if (error){
                                                        NSLog(@"#DEBUG ERROR: %@", [error debugDescription]);
                                                    }
                                                }
                                            }];
}

-(void)shareSongWithFacebookAccount: (Song *)aSong{
    if (FBSession.activeSession.isOpen){
        
        NSMutableDictionary *paramsDict = [@{ @"name" : @"bla", @"caption" : @"Share music usign NowListeningTo" } mutableCopy];
        
        [FBRequestConnection startWithGraphPath:@"me/feed"
                                     parameters:paramsDict
                                     HTTPMethod:@"POST"
                              completionHandler:^(FBRequestConnection *connection,
                                                  id result,
                                                  NSError *error) {
             
                                  NSString *alertText;

                                  if (error) {
                                      alertText = [NSString stringWithFormat:@"error: domain = %@, code = %d", error.domain, error.code];
                                      
                                  } else {
                                      alertText = [NSString stringWithFormat:@"Posted action, id: %@",                              [result objectForKey:@"id"]];
                                  }

                                  // Show the result in an alert

                                  [[[UIAlertView alloc] initWithTitle:@"Result"
                                                              message:alertText
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK!"
                                                    otherButtonTitles:nil]
                                   show];
         }];
        
    }else{
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate openSessionWithAllowLoginUI:YES];
    }
}

#pragma mark - Public

-(id)init{
    self = [super init];
    if (self){
        self.accountStore = [[[ACAccountStore alloc] init] autorelease];
    }
    return self;
}

-(void)dealloc{
    [accountStore release];
    [super dealloc];
}

-(void)shareSong:(Song *)aSong withAccountType:(SMAccountType)anAccountType{
    
    if (anAccountType == SMAccountTypeAll){
        [self shareSongWithFacebookAccount:aSong];
        [self shareSongWithTwitterAccount:aSong];
    }
}

//  Singleton method proposed in WWDC 2012
+ (id)sharedInstance {
	static SocialManager *sharedInstance;
	if (sharedInstance == nil)
		sharedInstance = [SocialManager new];
	return sharedInstance;
}

@end
