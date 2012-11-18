//
//  SignUpViewController.h
//  NowListeningTo
//
//  Created by Ezequiel Becerra on 11/16/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistrationViewController.h"
@interface SignUpViewController : RegistrationViewController{
    __weak IBOutlet UITextField *usernameTextfield;
}

- (IBAction)signUpButtonTapped:(id)sender;

@end
