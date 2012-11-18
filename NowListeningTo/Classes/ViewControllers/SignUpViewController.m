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

#pragma mark - Private

- (BOOL)areTextFieldsComplete{
    BOOL retVal = YES;

    if ([emailTextfield.text isEqualToString:@""] ||
        [passwordTextfield.text isEqualToString:@""]){
        
        retVal = NO;
    }
    
    return retVal;
}

#pragma mark - Notifications

-(void)dismiss:(NSNotification *)aNotification{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Public

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dismiss:)
                                                 name:kHideSignUpNotification
                                               object:nil];
}

- (IBAction)closeButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signUpButtonTapped:(id)sender {
    
    if ([self areTextFieldsComplete]){
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
