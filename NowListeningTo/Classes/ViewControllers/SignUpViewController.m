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

- (IBAction)closeButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
