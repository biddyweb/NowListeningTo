//
//  StatusView.h
//  NowListeningTo
//
//  Created by Ezequiel Becerra on 10/20/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kStatusViewAnnounce @"kStatusViewAnnounce"

@interface StatusView : UIView{
    NSMutableArray *messages;
    UILabel *titleLabel;
}

-(id)initWithView:(UIView *)aView;

@end
