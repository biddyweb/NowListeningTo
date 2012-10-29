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

//  Found on http://stackoverflow.com/questions/2690775/creating-a-pop-animation-similar-to-the-presentation-of-uialertview
- (void) attachPopUpAnimation{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .2;
    
    [self.layer addAnimation:animation forKey:@"popup"];
}

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
        [self attachPopUpAnimation];
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
