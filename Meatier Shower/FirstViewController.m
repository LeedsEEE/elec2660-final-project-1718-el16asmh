//
//  FirstViewController.m
//  Meatier Shower
//
//  Created by Ahmed Samir on 12/1/17.
//  Copyright © 2017 University of leeds. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
// hide statues bar
//https://stackoverflow.com/questions/33541525/prefersstatusbarhidden-not-called
- (BOOL)prefersStatusBarHidden{return YES;}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated {
   // meteor.center = CGPointMake(120, 60);
    
    //animation for the meteor
     meteor.animationImages = [NSArray arrayWithObjects :
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
     
     meteor.animationDuration = 0.80;
     [meteor setAnimationRepeatCount:1000];
     [meteor startAnimating]; // start the animation/*/
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
