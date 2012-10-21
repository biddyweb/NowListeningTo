//
//  StatusView.m
//  NowListeningTo
//
//  Created by Ezequiel Becerra on 10/20/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import "StatusView.h"

#define STATUSVIEW_LEFTMARGIN 10
#define STATUSVIEW_HEIGHT 25
#define STATUSVIEW_OPACITY 0.75

@implementation StatusView

#pragma mark - Private

-(void)updateStatusView{
    NSLog(@"#DEBUG Update");
    
    if ([messages count] > 0){

        //  Update message
        NSString *announce = messages[0];
        titleLabel.text = announce;
        [messages removeObject:announce];
        
        [self performSelector:@selector(updateStatusView) withObject:nil afterDelay:5];
        
    }else{
        
        //  Hide
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0;
        }];
    }
}

#pragma mark - Notifications

-(void)showStatusView:(NSNotification *)aNotification{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *aMessage = [aNotification.userInfo objectForKey:@"message"];
        [messages addObject:aMessage];
        
        if ([messages count] > 1){

        }else{
            
            NSLog(@"#DEBUG Show");
            
            titleLabel.text = aMessage;
            
            //  Setup begin and end frames
            CGRect statusViewEndFrame = self.frame;
            
            CGRect statusViewBeginFrame = self.frame;
            statusViewBeginFrame.origin.y -= statusViewBeginFrame.size.height;
            self.frame = statusViewBeginFrame;
            
            [UIView animateWithDuration:0.5 animations:^{
                self.frame = statusViewEndFrame;
                self.alpha = 1;
            } completion:^(BOOL finished) {
                [self performSelector:@selector(updateStatusView) withObject:nil afterDelay:5];
            }];
        }
    });
}

#pragma mark - Public

-(id)initWithView:(UIView *)aView{
    CGRect viewFrame = CGRectMake(0, 0, aView.frame.size.width, STATUSVIEW_HEIGHT);
    self = [super initWithFrame:viewFrame];

    if (self){
        messages = [[NSMutableArray alloc] init];

        self.alpha = 0;
        self.opaque = NO;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:STATUSVIEW_OPACITY];
        
        //  Label setup (frame, color, text)
        CGRect titleFrame = viewFrame;
        titleFrame.origin.x = STATUSVIEW_LEFTMARGIN;
        titleFrame.size.width = titleFrame.size.width - STATUSVIEW_LEFTMARGIN;
        titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
        titleLabel.textColor = [UIColor colorWithWhite:0.95 alpha:1];
        titleLabel.shadowColor = [UIColor colorWithWhite:0 alpha:1];
        titleLabel.shadowOffset = CGSizeMake(0, 1);
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"Lorem Ipsum";
        [self addSubview:titleLabel];
        
        //  Subscribe and change status text
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showStatusView:) name:kStatusViewAnnounce object:nil];
    }
    return self;
}

@end
