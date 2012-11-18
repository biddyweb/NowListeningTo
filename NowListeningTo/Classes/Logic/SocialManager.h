//
//  SocialManager.h
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/13/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "Song.h"

#define kAccountTwitter @"kAccountTwitter"
#define kAccountFacebook @"kAccountFacebook"
#define kAccountListeningTo @"kAccountListeningTo"
#define kDisplaySignInNotification @"kDisplaySignInNotification"
#define kHideSignInNotification @"kHideSignInNotification"

@interface SocialManager : NSObject{
    NSInteger pendingTasks;
    ACAccountStore *accountStore;
    NSMutableDictionary *accountsSettings;
}

@property (strong) ACAccountStore *accountStore;
@property (readonly) NSMutableDictionary *accountsSettings;
@property (readwrite) NSInteger pendingTasks;

-(BOOL)isAccountEnabledForShare:(NSString *)anAccountId;
-(void)setAccount:(NSString *)anAccountId enabled:(BOOL)isEnabled;
-(void)shareSong:(Song *)aSong;
-(void)signInUserWithParams:(NSDictionary *)aDictionary;
-(void)signUpUserWithParams:(NSDictionary *)aDictionary;
-(void)saveToDisk;
+(SocialManager *)sharedInstance;

@end
