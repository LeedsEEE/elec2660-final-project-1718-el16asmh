//
//  ResultViewController.m
//  Meatier Shower
//
//  Created by Ahmed Samir on 11/29/17.
//  Copyright © 2017 University of leeds. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()
@property (nonatomic, retain) NSString *data;

@end
int highscorepath;
@implementation ResultViewController
@synthesize scoreLabel,highscoreLabel,score;
// hide statues bar
//https://stackoverflow.com/questions/33541525/prefersstatusbarhidden-not-called
- (BOOL)prefersStatusBarHidden{return YES;}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [scoreLabel setText:[NSString stringWithFormat:@"%d", score]];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger highScore = [userDefaults integerForKey:@"HIGH_SCORE"];
    highscorepath = score;
    
    // Update HighScore
    if (score > highScore) {
        [userDefaults setInteger:score forKey:@"HIGH_SCORE"];
        [highscoreLabel setText:[NSString stringWithFormat:@"High Score : %d", score]];
        
    } else {
        [highscoreLabel setText:[NSString stringWithFormat:@"High Score : %ld", highScore]];
    }
  
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated {
    // meteor.center = CGPointMake(120, 60);
    
    //animation for the meteor
    _rock.animationImages = [NSArray arrayWithObjects :
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
                             
                               nil]; //'nil' clears the imageView at the end of the animation??
    
    _rock.animationDuration = 0.80;
    [_rock setAnimationRepeatCount:1000];
    [_rock startAnimating]; // start the animation/*/
}


@end
