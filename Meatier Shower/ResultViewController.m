//
//  ResultViewController.m
//  Meatier Shower
//
//  Created by Ahmed Samir on 11/29/17.
//  Copyright © 2017 University of leeds. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController
@synthesize scoreLabel,highscoreLabel,score;
- (void)viewDidLoad {
    [super viewDidLoad];
 
    [scoreLabel setText:[NSString stringWithFormat:@"%d", score]];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger highScore = [userDefaults integerForKey:@"HIGH_SCORE"];
    
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



@end
