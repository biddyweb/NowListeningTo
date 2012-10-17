//
//  AppDelegate.h
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/12/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

extern NSString *const FBSessionStateChangedNotification;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;

@end
