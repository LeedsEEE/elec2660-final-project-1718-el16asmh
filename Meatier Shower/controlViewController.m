//
//  controlViewController.m
//  Meatier Shower
//
//  Created by Ahmed Samir on 12/8/17.
//  Copyright © 2017 University of leeds. All rights reserved.
//
//
//  https://mrdude42.deviantart.com

#import "controlViewController.h"

@interface controlViewController ()

@end

@implementation controlViewController
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
