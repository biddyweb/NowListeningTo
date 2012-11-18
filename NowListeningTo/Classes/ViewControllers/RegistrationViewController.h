//
//  RegistrationViewController.h
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 11/18/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UITableViewController{
    __weak IBOutlet UITextField *emailTextfield;
    __weak IBOutlet UITextField *passwordTextfield;    
}

- (IBAction)closeButtonTapped:(id)sender;
- (BOOL)areTextFieldsComplete;
- (void)dismiss:(NSNotification *)aNotification;
@end
