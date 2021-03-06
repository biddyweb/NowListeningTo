//
//  SignUpViewController.m
//  NowListeningTo
//
//  Created by Ezequiel Becerra on 11/16/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import "SignUpViewController.h"
#import "SocialManager.h"

@implementation SignUpViewController

#pragma mark - Public

-(BOOL)areTextfieldsComplete{
    BOOL retVal = [super areTextFieldsComplete];
    
    if (retVal && ![usernameTextfield.text isEqualToString:@""]){
        retVal = YES;
    }
    
    return retVal;
}

- (IBAction)signUpButtonTapped:(id)sender {
    
    if ([self areTextfieldsComplete]){
        NSDictionary *params = @{
                                @"email" : emailTextfield.text,
                                @"username" : usernameTextfield.text,
                                @"password" : passwordTextfield.text
                                };
        
        [[SocialManager sharedInstance] signUpUserWithParams:params];
        
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
