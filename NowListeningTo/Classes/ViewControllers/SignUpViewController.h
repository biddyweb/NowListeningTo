//
//  SignUpViewController.h
//  NowListeningTo
//
//  Created by Ezequiel Becerra on 11/16/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UITableViewController{
    __weak IBOutlet UITextField *passwordTextfield;
    __weak IBOutlet UITextField *usernameTextfield;
    __weak IBOutlet UITextField *emailTextfield;
}

- (IBAction)closeButtonTapped:(id)sender;
- (IBAction)signUpButtonTapped:(id)sender;

@end
