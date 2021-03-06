//
//  MusicHelper.m
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/13/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import "MusicHelper.h"
#import <MediaPlayer/MediaPlayer.h>
@implementation MusicHelper

+(Song *) currentSong {
    Song *retVal = nil;
    
    MPMusicPlayerController* iPodMusicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    MPMediaItem *mediaItem = [iPodMusicPlayer nowPlayingItem];
    if (mediaItem) {
        retVal = [[Song alloc] init];
        retVal.artist = [mediaItem valueForProperty: MPMediaItemPropertyArtist];
        retVal.title = [mediaItem valueForProperty: MPMediaItemPropertyTitle];
    }
    
    return retVal;
}

+(NSString *)songStringWithSong:(Song *)aSong{
    NSString *retVal = nil;

    if (aSong){
        retVal = [NSString stringWithFormat:@"NLT: %@ by %@ #NLTApp", aSong.title, aSong.artist];
    }else{
        //  #TODO Remove this
        retVal = @"No song being played :-(";
    }
    
    return retVal;
}


@end
