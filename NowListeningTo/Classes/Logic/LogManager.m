//
//  LogManager.m
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/19/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import "LogManager.h"
#import "StatusView.h"

@implementation LogManager
@synthesize logs;

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
}

+(LogManager *)sharedInstance{
    static LogManager *sharedInstance;
	if (sharedInstance == nil)
		sharedInstance = [LogManager new];
	return sharedInstance;
}

@end
