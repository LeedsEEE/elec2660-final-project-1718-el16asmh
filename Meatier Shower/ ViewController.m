//
//  ViewController.m
//  Meatier Shower
//
//  Created by Ahmed Samir on 11/15/17.
//  Copyright © 2017 University of leeds. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end
int score;
int lives;
int rockAttack;
int rockposition;
int randomspeed;
float speedOfRock;

@implementation ViewController
// hide statues bar
- (BOOL)prefersStatusBarHidden{return YES;}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    //Hidden Images
    spaceship.hidden = YES;
    rock.hidden= YES;
    fire.hidden= YES;
    explod.hidden= YES;
    gameover.hidden= YES;
    
    //Hidden lavel
    liveslabel.hidden = YES;
    scorelabel.hidden = YES;
    
    // set score and lives
    score = 0;
    lives = 3;
    
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
    //hide start
    startbutton.hidden = YES;
    explod.hidden = YES;
    //show images
    spaceship.hidden = NO;
    rock.hidden = NO;
    gameover.hidden= YES;
    
    //display label
    scorelabel.hidden = NO;
    liveslabel.hidden = NO;
  
    [self positionrock]; // lock for another way 
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    touch = [touches anyObject];
    //user touch the screen
    CGPoint point = [touch locationInView:self.view];
    
    //spaceship movment side to side
    spaceship.center = CGPointMake(point.x, spaceship.center.y);
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    // vibrate
   //lam AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    // when the user lift the finger = fire
    fire.hidden = NO;
    fire.center = CGPointMake(spaceship.center.x, spaceship.center.y);
    // fire timer
    fireMovmentTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(fireMovement) userInfo:nil repeats:YES];
    
}

-(void)positionrock {
    
    //random "arc4random" to random between diffrent cases
    rockposition = arc4random()% 240;
    rockposition = rockposition +20; // more random
    
    // set rock location
    rock.center = CGPointMake(rockposition,-40);
    
    //set rock speed
    randomspeed = arc4random() % 2;
    switch (randomspeed) {
       // three diffrent cases
        case 0:
            speedOfRock= 0.006;
            break;
        case 1:
            speedOfRock= 0.008;
            break;
        case 2:
            speedOfRock= 0.01;
            
        default:
            break;
    }
    //random accurence of rock
    rockAttack = arc4random() %5;
    [self performSelector:@selector(rockMovementTimerMethid) withObject:nil afterDelay:rockAttack];
    }

- (void)rockMovementTimerMethid { //???
    rockMovemntTimer = [NSTimer scheduledTimerWithTimeInterval:speedOfRock target:self selector:@selector(rockMovemnet) userInfo:nil repeats:YES];

}

-(void)rockMovemnet {
    
    rock.center = CGPointMake(rock.center.x, rock.center.y+2);
    
        //detect if two images colide
    if (CGRectIntersectsRect(rock.frame, spaceship.frame)) {
       
        // vibrate
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
   
        //lives - 1
        lives = lives -1;
        
        //update nsstring
        livestring = [NSString stringWithFormat:@"Lives: %i",lives];
        
        //update label
        liveslabel.text = livestring;
      
        // stop rock from movment
        [rockMovemntTimer invalidate];
    
        // stop rock movment
        if (lives > 0) {
            [self positionrock];
            }
        if (lives == 0) {
            [self gameOver];
            }
    }
}

-(void)fireMovement {
    fire.hidden = NO ;
    fire.center = CGPointMake(fire.center.x, fire.center.y -2);
    
        //detect if two images colide
    if (CGRectIntersectsRect(fire.frame, rock.frame)) {
      
        // give location
        explod.center = CGPointMake(rock.center.x, rock.center.y);
        
        // Animation
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
        
       // [explod performSelector:@selector(setImage:) withObject:transparent afterDelay:[explod animationDuration]];
        
    
        // add + 5 to score
        score = score + 5;
        
        //update string
        scorestring = [NSString stringWithFormat:@"score: %i",score];
       
        
        //update label
        scorelabel.text = scorestring;
        
        // stop fire
        [fireMovmentTimer invalidate];
       
        //position fire to the center of ship
        fire.center = CGPointMake(spaceship.center.x, spaceship.center.y);
        fire.hidden = YES;
   
        //stop rock movement
        explod.hidden = NO;
        [rockMovemntTimer invalidate];
        [self positionrock];
    }
        
}
    
 - (void)gameOver{
    //stop all movement
     [rockMovemntTimer invalidate];
     [fireMovmentTimer invalidate];
      gameover.hidden= NO;
    
     //reload the game after 3 sec
     [self performSelector:@selector(replayGame) withObject:nil afterDelay:3];
     // with object change .
     
}
    
-(void)replayGame{
    
    //Hidden Images
    spaceship.hidden = YES;
    rock.hidden= YES;
    fire.hidden= YES;
    
    //Hidden lavel
    liveslabel.hidden = YES;
    scorelabel.hidden = YES;
    
    // set score and lives
    score = 0;
    lives = 3;
    
    //strings
    scorestring =[NSString stringWithFormat:@"Score: 0"];
    livestring = [NSString stringWithFormat:@"Lives: 3"];
    
    //intial text label
    scorelabel.text = scorestring;
    liveslabel.text = livestring;
    
    //starting position of images
    spaceship.center = CGPointMake(140, 650);
    rock.center = CGPointMake(140, -40);
    fire.center =CGPointMake(spaceship.center.x, spaceship.center.y);
    
    
}


@end
