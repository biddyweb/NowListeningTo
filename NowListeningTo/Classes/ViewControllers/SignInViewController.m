//
//  SignInViewController.m
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 11/18/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import "SignInViewController.h"
#import "SocialManager.h"

@implementation SignInViewController

#pragma mark - Public

- (IBAction)signInButtonTapped:(id)sender {
    if ([self areTextFieldsComplete]){
        NSDictionary *params = @{
                                @"email" : emailTextfield.text,
                                @"password" : passwordTextfield.text
                                };
        
        [[SocialManager sharedInstance] signInUserWithParams:params];
        
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Please complete email and password textfields"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}
@end
