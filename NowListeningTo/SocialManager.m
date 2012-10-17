//
//  SocialManager.m
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/13/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import "SocialManager.h"
#import "MusicHelper.h"

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
    NSDictionary *options = @{ACFacebookAppIdKey : @"359882274105102", ACFacebookAudienceKey : ACFacebookAudienceEveryone, ACFacebookPermissionsKey: @[@"publish_stream"]};
    
    ACAccountType *facebookAccountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    [self.accountStore requestAccessToAccountsWithType:facebookAccountType
                        options:options
                        completion:^(BOOL granted, NSError *error) {
                        
                            if (granted){
                                //  Success
                                NSArray *accounts = [self.accountStore accountsWithAccountType:facebookAccountType];
                                
                                //  On facebook there's only one account
                                ACAccount *anAccount = [accounts lastObject];
                                
                                NSString *songString = [MusicHelper songStringWithSong:aSong];
                                
                                NSDictionary *parameters = @{@"message": songString};
                                NSURL *feedURL = [NSURL URLWithString:@"https://graph.facebook.com/me/feed"];
                                
                                SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                                                        requestMethod:SLRequestMethodPOST
                                                                                  URL:feedURL
                                                                           parameters:parameters];
                                request.account = anAccount;
                                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                    //  Handle errors
                                    NSLog(@"#DEBUG ERROR: %@", [error debugDescription]);                                    
                                }];
                                
                            }else{
                                //  Fail
                                if (error){
                                    NSLog(@"#DEBUG ERROR: %@", [error debugDescription]);
                                }
                            }
    }];
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
