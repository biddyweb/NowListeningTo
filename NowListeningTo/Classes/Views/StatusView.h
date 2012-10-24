//
//  StatusView.h
//  NowListeningTo
//
//  Created by Ezequiel Becerra on 10/20/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kStatusViewAnnounce @"kStatusViewAnnounce"

#define kMessageTypeError @"kMessageTypeError"
#define kMessageTypeDefault @"kMessageTypeDefault"
#define kMessageTypeSuccess @"kMessageTypeSuccess"
#define kMessageTypeInfo @"kMessageTypeInfo"

@interface StatusView : UIView{
    NSMutableArray *messages;
    UILabel *titleLabel;
}

-(id)initWithView:(UIView *)aView;

+(void)displayStatusMessage:(NSString *)aMessage withType:(NSString *)aType;

@end
