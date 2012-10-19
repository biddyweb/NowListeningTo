//
//  Song.h
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/13/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject{
    NSString *title;
    NSString *artist;
}

@property (strong) NSString *title;
@property (strong) NSString *artist;

@end
