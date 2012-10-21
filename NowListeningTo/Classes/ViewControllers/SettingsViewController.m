//
//  SettingsViewController.m
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/13/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import "SettingsViewController.h"
#import "SocialManager.h"

@implementation SettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    BOOL isTwitterEnabled = [[SocialManager sharedInstance] isAccountEnabledForShare:kAccountTwitter];
    [twitterSwitch setOn:isTwitterEnabled];
    
    BOOL isFacebookEnabled = [[SocialManager sharedInstance] isAccountEnabledForShare:kAccountFacebook];
    [facebookSwitch setOn:isFacebookEnabled];
    
    BOOL isListeningToEnabled = [[SocialManager sharedInstance] isAccountEnabledForShare:kAccountListeningTo];
    [nltSwitch setOn:isListeningToEnabled];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

//  #DEV Uncomment this code if you want to avoid selection on cells
//- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)path{
//    // Determine if row is selectable based on the NSIndexPath.
//    return nil;
//}

- (IBAction)twitterSwitchValueChanged:(id)sender {
    BOOL newValue = [(UISwitch *)sender isOn];
    [[SocialManager sharedInstance] setAccount:kAccountTwitter enabled:newValue];
}

- (IBAction)facebookSwitchValueChanged:(id)sender {
    BOOL newValue = [(UISwitch *)sender isOn];
    [[SocialManager sharedInstance] setAccount:kAccountFacebook enabled:newValue];
}

- (IBAction)nltSwitchValueChanged:(id)sender {
    BOOL newValue = [(UISwitch *)sender isOn];
    [[SocialManager sharedInstance] setAccount:kAccountListeningTo enabled:newValue];
}
@end
