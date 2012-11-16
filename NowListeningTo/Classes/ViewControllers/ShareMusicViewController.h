//
//  ViewController.h
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/12/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusView.h"
#import "LoadingView.h"

@interface ShareMusicViewController : UIViewController{    
    __weak IBOutlet UILabel *songLabel;
    __weak IBOutlet UIView *songLabelContainer;
    
    StatusView *statusView;
    LoadingView *loadingView;
    NSTimer *refreshTimer;
}

- (IBAction)refreshButtonTapped:(id)sender;
- (IBAction)shareButtonTapped:(id)sender;

@end
