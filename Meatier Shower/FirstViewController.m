//
//  FirstViewController.m
//  Meatier Shower
//
//  Created by Ahmed Samir on 12/1/17.
//  Copyright © 2017 University of leeds. All rights reserved.
//
//  https://www.youtube.com/watch?v=zILpSTIy6Fw

#import "FirstViewController.h"
@import MediaPlayer;

@interface FirstViewController ()
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
@end
AVAudioPlayer *backgroundmusic;
@implementation FirstViewController
// hide statues bar
//https://stackoverflow.com/questions/33541525/prefersstatusbarhidden-not-called
- (BOOL)prefersStatusBarHidden{return YES;}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Load the video from the app bundle.
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"backgroundmainmenu" withExtension:@"mov"];
    
    // Create and configure the movie player.
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    self.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
    
    self.moviePlayer.view.frame = self.view.frame;
    [self.view insertSubview:self.moviePlayer.view atIndex:0];
    
    [self.moviePlayer play];
    
    // Loop video.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loopVideo) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];

   NSURL *bgURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/MyVeryOwnDeadShip.wav", [[NSBundle mainBundle] resourcePath]]];
   
    backgroundmusic = [[AVAudioPlayer alloc] initWithContentsOfURL:bgURL error:nil];
     [backgroundmusic play];
}
- (void)loopVideo {
    [self.moviePlayer play];
     [backgroundmusic play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated {
   // meteor.center = CGPointMake(120, 60);
    
    //animation for the meteor
    _meteor.animationImages = [NSArray arrayWithObjects :
     [UIImage imageNamed:@"1_meteor.png"],
     [UIImage imageNamed:@"2_meteor.png"],
     [UIImage imageNamed:@"3_meteor.png"],
     [UIImage imageNamed:@"4_meteor.png"],
     [UIImage imageNamed:@"5_meteor.png"],
     [UIImage imageNamed:@"6_meteor.png"],
     [UIImage imageNamed:@"7_meteor.png"],
     [UIImage imageNamed:@"8_meteor.png"],
     [UIImage imageNamed:@"9_meteor.png"],
     [UIImage imageNamed:@"10_meteor.png"],
     [UIImage imageNamed:@"11_meteor.png"],
     [UIImage imageNamed:@"12_meteor.png"],
     nil]; //'nil' clears the imageView at the end of the animation??
     
    _meteor.animationDuration = 0.80;
    [_meteor setAnimationRepeatCount:1000];
    [_meteor startAnimating]; // start the animation/*/
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
