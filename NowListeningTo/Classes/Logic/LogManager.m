//
//  LogManager.m
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/19/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import "LogManager.h"

@implementation LogManager
@synthesize logs;

#pragma mark - Private

-(void)announceWithTextMessage:(NSString *)aMessage{
    NSDictionary *aDict = @{@"message" : aMessage};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kStatusAnnounce" object:nil userInfo:aDict];
}

#pragma mark - Public

-(id)init{
    self = [super init];
    if (self){
        logs = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addLog:(NSString *)aLog{
    [logs addObject:aLog];
    [self announceWithTextMessage:aLog];
}

+(LogManager *)sharedInstance{
    static LogManager *sharedInstance;
	if (sharedInstance == nil)
		sharedInstance = [LogManager new];
	return sharedInstance;
}

@end
