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

typedef enum {
    SMAccountTypeFacebook,
    SMAccountTypeTwitter,
    SMAccountTypeAll
} SMAccountType;

@interface SocialManager : NSObject{
    ACAccountStore *accountStore;
}

@property (retain) ACAccountStore *accountStore;

-(void)shareSong:(Song *)aSong withAccountType:(SMAccountType)anAccountType;
+(id)sharedInstance;

@end
