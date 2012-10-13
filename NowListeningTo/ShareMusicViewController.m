//
//  ViewController.m
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/12/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import "ShareMusicViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MusicHelper.h"

@implementation ShareMusicViewController

#pragma mark - Private

-(void)autoResizeUILabelFont:(UILabel *)aLabel{    
    CGSize constraintSize = CGSizeMake(aLabel.frame.size.width, MAXFLOAT);
    
    CGFloat sizeFont = aLabel.font.pointSize;
    CGSize sizeWithFont = [aLabel.text sizeWithFont:aLabel.font
                                  constrainedToSize:constraintSize
                                      lineBreakMode:aLabel.lineBreakMode];
    
    while (sizeFont > 8 && sizeWithFont.height > aLabel.frame.size.height){
        sizeFont--;
        aLabel.font = [UIFont fontWithName:aLabel.font.fontName size:sizeFont];
        sizeWithFont = [aLabel.text sizeWithFont:aLabel.font
                               constrainedToSize:constraintSize
                                   lineBreakMode:aLabel.lineBreakMode];
    }
}

-(void) refreshSong{
    Song *currentSong = [MusicHelper currentSong];

    NSString *songText = nil;
    if (currentSong){
        songText = [NSString stringWithFormat:@"%@ by %@", currentSong.title, currentSong.artist];
    }else{
        songText = @"... Nothing?";
    }
    
    songLabel.text = songText;
}

#pragma mark - Public

- (void)viewDidLoad{
    [super viewDidLoad];
    songLabelContainer.layer.cornerRadius = 10;
    [self refreshSong];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self autoResizeUILabelFont:songLabel];    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)refreshButtonTapped:(id)sender {
    [self refreshSong];
    [self autoResizeUILabelFont:songLabel];
}
@end
