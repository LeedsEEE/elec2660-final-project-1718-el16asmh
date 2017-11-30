//
//  ResultViewController.h
//  Meatier Shower
//
//  Created by Ahmed Samir on 11/29/17.
//  Copyright © 2017 University of leeds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController
@property (nonatomic) int score;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highscoreLabel;

@end
