//
//  RegistrationViewController.m
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 11/18/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import "RegistrationViewController.h"
#import "SocialManager.h"

@implementation RegistrationViewController

#pragma mark - Notifications

-(void)dismiss:(NSNotification *)aNotification{
    if (![self isBeingDismissed]){
        [self dismissViewControllerAnimated:YES completion:nil];        
    }
}

#pragma mark - Public

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dismiss:)
                                                 name:kHideSignInNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)areTextFieldsComplete{
    BOOL retVal = YES;
    
    if ([emailTextfield.text isEqualToString:@""] ||
        [passwordTextfield.text isEqualToString:@""]){
        
        retVal = NO;
    }
    
    return retVal;
}

- (IBAction)closeButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
