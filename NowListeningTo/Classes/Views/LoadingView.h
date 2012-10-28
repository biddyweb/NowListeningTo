//
//  LoadingView.h
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/28/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kHideLoadingViewNotification @"kHideLoadingViewNotification"

@interface LoadingView : UIView{
    UIActivityIndicatorView *activityView;
}

- (id)initWithSuperView:(UIView *)aView;
- (void)stopAnimating;
@end
