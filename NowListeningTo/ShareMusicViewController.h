//
//  ViewController.h
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/12/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareMusicViewController : UIViewController{
    __weak IBOutlet UILabel *songLabel;
    __weak IBOutlet UIView *songLabelContainer;
}

- (IBAction)refreshButtonTapped:(id)sender;
- (IBAction)shareButtonTapped:(id)sender;

@end
