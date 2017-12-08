//
//  AccelerometerViewController.m
//  Meatier Shower
//
//  Created by Ahmed Samir on 12/8/17.
//  Copyright © 2017 University of leeds. All rights reserved.
//

#import "AccelerometerViewController.h"
#import "ResultViewController.h"


#define kUpdateInterval (1.0f / 60.0f)
@import MediaPlayer;
@interface AccelerometerViewController ()
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
@end

int scoree;
int livess;
int rockAttackk;
int rockpositionn;
int randomspeedd;
float speedOfRockk;
int scoree;

UILabel *scoreeLabel;

AVAudioPlayer *hittSound;
AVAudioPlayer *bullettSound;

@implementation AccelerometerViewController


// hide statues bar
//https://stackoverflow.com/questions/33541525/prefersstatusbarhidden-not-called
- (BOOL)prefersStatusBarHidden{return YES;}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Accelerometer
    
    currentMaxAccelX = 0;
    ;
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = kUpdateInterval;
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [self outputAccelertionData:accelerometerData.acceleration];
                                                 if(error){
                                                     
                                                     NSLog(@"%@", error);
                                                 }
                                             }];
    
    
    // Load the video from the app bundle.
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"background" withExtension:@"mov"];
    
    // Create and configure the movie player.
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    self.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
    
    self.moviePlayer.view.frame = self.view.frame;
    [self.view insertSubview:self.moviePlayer.view atIndex:0];
    
    [self.moviePlayer play];
    
    // Loop video.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loopVideo) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    
    // Preparing Sounds
    
    NSURL *okURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/hit.wav", [[NSBundle mainBundle] resourcePath]]];
    NSURL *ngURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/over.wav", [[NSBundle mainBundle] resourcePath]]];
    
    
    
    hittSound = [[AVAudioPlayer alloc] initWithContentsOfURL:okURL error:nil];
    bullettSound = [[AVAudioPlayer alloc] initWithContentsOfURL:ngURL error:nil];
    
}
- (void)loopVideo {
    [self.moviePlayer play];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated {
    //Hidden Images
    spaceship.hidden = YES;
    rock.hidden= YES;
    fire.hidden= YES;
    explod.hidden= YES;
    gameover.hidden= YES;
    
    //Hidden label
    liveslabel.hidden = YES;
    scorelabel.hidden = YES;
    
    // set score and lives
    scoree = 0;
    livess = 3;
    
    //strings
    scorestring =[NSString stringWithFormat:@"Score: 0"];
    livestring = [NSString stringWithFormat:@"Lives: 3"];
    
    //intial text label
    scorelabel.text = scorestring;
    liveslabel.text = livestring;
    
    //starting position of images
    spaceship.center = CGPointMake(140, 600);
    rock.center = CGPointMake(140, -40);
    explod.center = CGPointMake(rock.center.x, rock.center.y);
    fire.center =CGPointMake(spaceship.center.x, spaceship.center.y);
    
}

-(IBAction)startGame:(id)sender {
    
    //hide start and explosion
    startbutton.hidden = YES;
    explod.hidden = YES;
    
    //show images
    spaceship.hidden = NO;
    rock.hidden = NO;
    gameover.hidden= YES;
    
    //display label
    scorelabel.hidden = NO;
    liveslabel.hidden = NO;
    
    [self positionrock]; //send it to the void  positionrock to get updates about the rock position
    
}
// Accelemtoer
-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    NSLog(@"%f, %f", acceleration.x , acceleration.y );
    spaceship.center = CGPointMake( ((acceleration.x/100)*34000)+147, spaceship.center.y);
    //Equation calculated
    NSLog(@"%f", ((acceleration.x/100)*34000)+147);
}


// Touch Screen


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    // vibrate
    //  AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    // sound effect
    [bullettSound play];
    // when the user lift the finger = fire
    fire.hidden = NO;
    fire.center = CGPointMake(spaceship.center.x, spaceship.center.y);
    // fire timer
    //https://developer.apple.com/documentation/foundation/nstimer/1412416-scheduledtimerwithtimeinterval?language=objc
    fireMovmentTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(fireMovement) userInfo:nil repeats:YES];
}




-(void)positionrock {
    //https://stackoverflow.com/questions/27066668/arc4random-positive-negative-numbers
    //random "arc4random" to random between diffrent cases
    rockpositionn = arc4random() %240;
    rockpositionn = rockpositionn +20; // more random
    
    //animation for the rock
    rock.animationImages = [NSArray arrayWithObjects :
                            [UIImage imageNamed:@"1_rock.png"],
                            [UIImage imageNamed:@"2_rock.png"],
                            [UIImage imageNamed:@"3_rock.png"],
                            [UIImage imageNamed:@"4_rock.png"],
                            [UIImage imageNamed:@"5_rock.png"],
                            [UIImage imageNamed:@"6_rock.png"],
                            [UIImage imageNamed:@"7_rock.png"],
                            [UIImage imageNamed:@"8_rock.png"],
                            [UIImage imageNamed:@"9_rock.png"],
                            [UIImage imageNamed:@"10_rock.png"],
                            
                            nil]; 
    
    rock.animationDuration = 0.80;
    [rock setAnimationRepeatCount:4];
    [rock startAnimating]; // start the animation
    
    // set rock lunching location
    rock.center = CGPointMake(rockpositionn,-40);
    
    //set rock speed ///////////
    randomspeedd = arc4random() % 2;
    
    switch (randomspeedd) {
            // three diffrent cases
        case 0:
            speedOfRockk= 0.006;
            break;
        case 1:
            speedOfRockk= 0.008;
            break;
        case 2:
            speedOfRockk= 0.01;
            
        default:
            break;
    }
    
    //random accurence of rock
    rockAttackk = arc4random() %20;
    
    [self performSelector:@selector(rockMovementTimerMethid) withObject:nil afterDelay:rockAttackk];
    
}

- (void)rockMovementTimerMethid {
    //https://developer.apple.com/documentation/foundation/nstimer/1412416-scheduledtimerwithtimeinterval?language=objc
    
    rockMovemntTimer = [NSTimer scheduledTimerWithTimeInterval:speedOfRockk target:self selector:@selector(rockMovemnet) userInfo:nil repeats:YES];
    
}

-(void)rockMovemnet {
    rock.center = CGPointMake(rock.center.x, rock.center.y+2); //(y+2) move by 2
    
    
    //detect if two images colide
    //https://stackoverflow.com/questions/19233582/detecting-if-two-images-collide-in-objective-c-and-print-message
    
    if (CGRectIntersectsRect(rock.frame, spaceship.frame)) {
        
        // vibrate
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        // lives - 1
        livess = livess -1;
        
        // update nsstring
        livestring = [NSString stringWithFormat:@"Lives: %i",livess];
        
        // update label
        liveslabel.text = livestring;
        
        // stop rock from movment
        [rockMovemntTimer invalidate];
        
        // stop rock movment
        
        if (livess > 0) {
            [self positionrock]; //keep sending rocks if u r still a life
        }
        if (livess == 0) {
            [self gameOver];
        }
    }
}

-(void)fireMovement {
    fire.hidden = NO ;
    fire.center = CGPointMake(fire.center.x, fire.center.y -2);
    
    
    // detect if two images colide
    if (CGRectIntersectsRect(fire.frame, rock.frame)) {
        // give location
        explod.center = CGPointMake(rock.center.x, rock.center.y);
        // sound effect
        [hittSound play];
        // Animation
        //https://stackoverflow.com/questions/6515948/how-would-i-make-an-explosion-animation-on-ios
        explod.animationImages = [NSArray arrayWithObjects :
                                  [UIImage imageNamed:@"1.png"],
                                  [UIImage imageNamed:@"2.png"],
                                  [UIImage imageNamed:@"3.png"],
                                  [UIImage imageNamed:@"4.png"],
                                  [UIImage imageNamed:@"5.png"],
                                  [UIImage imageNamed:@"6.png"],
                                  [UIImage imageNamed:@"7.png"],
                                  
                                  nil]; //'nil' clears the imageView at the end of the animation??
        
        explod.animationDuration = 0.50;
        [explod setAnimationRepeatCount:1];
        [explod startAnimating]; // start the animation
        
        // show the animation view
        explod.hidden = YES;
        
        
        
        // add + 5 to score
        scoree = scoree + 5;
        
        // update string
        scorestring = [NSString stringWithFormat:@"score: %i",scoree];
        
        // update label
        scorelabel.text = scorestring;
        
        // stop fire
        [fireMovmentTimer invalidate];
        
        // position fire to the center of ship
        fire.center = CGPointMake(spaceship.center.x, spaceship.center.y);
        fire.hidden = YES;
        
        // stop rock movement
        explod.hidden = NO;
        [rockMovemntTimer invalidate];
        [self positionrock];
    }
    
}

- (void)gameOver {
    
    // stop all movement
    [rockMovemntTimer invalidate];
    [fireMovmentTimer invalidate];
    gameover.hidden= NO;
    
    // Hide Images
    spaceship.hidden = YES;
    rock.hidden= YES;
    fire.hidden= YES;
    
    // Hide label
    liveslabel.hidden = YES;
    scorelabel.hidden = YES;
    
    // pause sound effect
    [hittSound stop];
    [bullettSound stop];
    
    // show result
    [self performSelector:@selector(showResult)withObject:nil afterDelay:1.0];
    
    
    
}

-(void)showResult {
    
    
    
    ResultViewController *viewController;
    viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    [viewController setScore:scoree];
    
    
    
    
    [self presentViewController:viewController animated:YES completion:nil];
    
}


@end

