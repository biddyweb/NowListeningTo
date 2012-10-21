//
//  ViewController.h
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/12/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "StatusView.h"

@interface ShareMusicViewController : UIViewController <MBProgressHUDDelegate>{
    MBProgressHUD *progressHUD;
    
    __weak IBOutlet UILabel *songLabel;
    __weak IBOutlet UIView *songLabelContainer;
    
    StatusView *statusView;
}

- (IBAction)refreshButtonTapped:(id)sender;
- (IBAction)shareButtonTapped:(id)sender;

@end
