//
//  ViewController.h
//  Meatier Shower
//
//  Created by Ahmed Samir on 11/15/17.
//  Copyright © 2017 University of leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "AudioToolbox/AudioToolbox.h"
#import <AVFoundation/AVFoundation.h>



double currentMaxAccelX;
double currentMaxRotX;

@interface ViewController : UIViewController{
    
    IBOutlet UIImageView *spaceship;
    IBOutlet UIImageView *rock;
    IBOutlet UIImageView *fire;
    IBOutlet UIImageView *explod;
    IBOutlet UILabel *gameover;
    IBOutlet UILabel *liveslabel;
    IBOutlet UILabel *scorelabel;
    IBOutlet UIButton*startbutton;
    
    
   
    //touch screen
    UITouch *touch;
    
    NSString *livestring;
    NSString *scorestring;
    
    NSTimer *rockMovemntTimer;
    NSTimer *fireMovmentTimer;
    
    
}

-(IBAction)startGame:(id)sender;
@property (strong, nonatomic) CMMotionManager *motionManager;
@end

