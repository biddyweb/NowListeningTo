//
//  LogManager.h
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/19/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogManager : NSObject{
    NSMutableArray *logs;
}

@property (readonly) NSMutableArray *logs;

-(void)addLog:(NSString *)aLog;

+(LogManager *)sharedInstance;

@end
