//
//  SettingsViewController.h
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/13/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UITableViewController{
    
    __weak IBOutlet UISwitch *twitterSwitch;
    __weak IBOutlet UISwitch *facebookSwitch;
    __weak IBOutlet UISwitch *nltSwitch;
}
- (IBAction)twitterSwitchValueChanged:(id)sender;
- (IBAction)facebookSwitchValueChanged:(id)sender;
- (IBAction)nltSwitchValueChanged:(id)sender;

@end
