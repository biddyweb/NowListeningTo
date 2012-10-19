//
//  LogViewController.h
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/19/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    __weak IBOutlet UITableView *tableVIew;
}

- (IBAction)doneButtonTapped:(id)sender;

@end
