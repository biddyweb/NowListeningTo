//
//  LoadingView.m
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/28/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import "LoadingView.h"
#import <QuartzCore/QuartzCore.h>

#define DEFAULT_WIDTH 50
#define DEFAULT_HEIGHT 50

@implementation LoadingView

#pragma mark - Private

#pragma mark - Public

- (id)initWithSuperView:(UIView *)aView{
    
    //  Center it on its superView
    CGRect aRect = CGRectMake(roundf((aView.frame.size.width - DEFAULT_WIDTH)/2),
                                roundf((aView.frame.size.height - DEFAULT_HEIGHT)/2),
                                DEFAULT_WIDTH,
                                DEFAULT_HEIGHT);

    self = [self initWithFrame:aRect];
    if (self){
        [aView setUserInteractionEnabled:NO];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        //  Set activity view
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];

        //  Set activity view frame
        CGRect newActivityViewFrame = activityView.frame;
        newActivityViewFrame.origin.x = roundf((frame.size.width - activityView.frame.size.width)/2.0);
        newActivityViewFrame.origin.y = roundf((frame.size.height - activityView.frame.size.height)/2.0);
        activityView.frame = newActivityViewFrame;
        
        //  Setup activity view
        activityView.hidesWhenStopped = YES;

        //  Start animating
        [activityView startAnimating];

        //  Add it to main view
        [self addSubview:activityView];
        
        //  Set round corners and background color
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.85];
        self.layer.cornerRadius = 10;
    }
    return self;
}

-(void)stopAnimating{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.alpha = 0;
                         }
                         completion:^(BOOL completed){
                             if (completed){
                                 [self.superview setUserInteractionEnabled:YES];
                                 [self removeFromSuperview];
                             }
                         }];        
    });
}

@end
