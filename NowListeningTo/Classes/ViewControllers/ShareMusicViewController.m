//
//  ViewController.m
//  NowListeningTo
//
//  Created by Ezequiel A Becerra on 10/12/12.
//  Copyright (c) 2012 Betzerra. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ShareMusicViewController.h"
#import "SocialManager.h"
#import "MusicHelper.h"
#import "LoadingView.h"
#import "SignUpViewController.h"

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

-(void)removeLoadingView:(NSNotification *)aNotification{
    [loadingView stopAnimating];
}

-(void)performSignUpSegue:(NSNotification *)aNotification{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SocialManager sharedInstance].pendingTasks--;        
        [self performSegueWithIdentifier:@"SignUpSegue" sender:self];
    });
}

#pragma mark - Public

- (void)viewDidLoad{
    [super viewDidLoad];
    
    songLabelContainer.layer.cornerRadius = 10;
    
    statusView = [[StatusView alloc] initWithView:self.view];
    [self.view addSubview:statusView];
    
    [self refreshSong];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self autoResizeUILabelFont:songLabel];    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.userInteractionEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeLoadingView:)
                                                 name:kHideLoadingViewNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(performSignUpSegue:)
                                                 name:kDisplaySignUpNotification
                                               object:nil];
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
    loadingView = [[LoadingView alloc] initWithSuperView:self.view];
    [self.view addSubview:loadingView];
    
    [[SocialManager sharedInstance] shareSong:[MusicHelper currentSong]];
}
@end
