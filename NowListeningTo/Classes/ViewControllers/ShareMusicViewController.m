//
//  ViewController.m
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/12/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import "ShareMusicViewController.h"
#import "SocialManager.h"
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

#pragma mark - Notifications

-(void)showProgress:(NSNotification *)aNotification{
    progressHUD.mode = MBProgressHUDModeIndeterminate;
    progressHUD.labelText = @"Loading";
    progressHUD.progress = [SocialManager sharedInstance].progressShareTasks;
    progressHUD.dimBackground = YES;
    [progressHUD show:YES];
    [self.view addSubview:progressHUD];
}

-(void)updateProgress:(NSNotification *)aNotification{
    progressHUD.progress = [SocialManager sharedInstance].progressShareTasks;
    if ([SocialManager sharedInstance].progressShareTasks > 0.99){
        progressHUD.labelText = @"Done!";
        [progressHUD hide:YES afterDelay:1.5];
    }
}

#pragma mark - Public

- (void)viewDidLoad{
    [super viewDidLoad];
    
    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    progressHUD.delegate = self;
    
    songLabelContainer.layer.cornerRadius = 10;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showProgress:) name:@"kShareSongBegin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateProgress:) name:@"kShareSongStepFinished" object:nil];
    
    [self refreshSong];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self autoResizeUILabelFont:songLabel];    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)refreshButtonTapped:(id)sender {
    [self refreshSong];
    [self autoResizeUILabelFont:songLabel];
}

- (IBAction)shareButtonTapped:(id)sender {
    [[SocialManager sharedInstance] shareSong:[MusicHelper currentSong]];
}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[progressHUD removeFromSuperview];
}
@end
