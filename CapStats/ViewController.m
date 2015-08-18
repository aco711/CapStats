//
//  ViewController.m
//  CapStats
//
//  Created by Alex Cohen on 8/16/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import "ViewController.h"
#import "CapsGame.h"
#import "StartScreen.h"
#import "GameViewController.h"

@interface ViewController ()
@property (strong, nonatomic) CapsGame* game;
//@property (weak, nonatomic) IBOutlet UILabel *missPercentageLabel;
//@property (weak, nonatomic) IBOutlet UILabel *hitPercentageLabel;

//@property (weak, nonatomic) IBOutlet UILabel *glassPercentageLabel;
@property (strong, nonatomic) UIView* topView;
@property (strong, nonatomic) UIView* bottomView;
@property (strong, nonatomic) UIButton* aNewGameButton;

@end


@implementation ViewController

-(void)presentNewGame
{
    GameViewController* gameVC = [[GameViewController alloc] init];
    gameVC.title = @"Caps Game";
    [self showViewController:gameVC sender:self];
    // [self performSegueWithIdentifier:@"test" sender:self];
     }

-(void)loadView
{
    [super loadView];
    
    CGRect topRect = CGRectMake(self.view.bounds.origin.x,
                                self.view.bounds.origin.y, self.view.bounds.size.width,
                                self.view.bounds.size.height/2);
    CGRect bottomRect = CGRectMake(self.view.bounds.origin.x,
                                   self.view.bounds.size.height/2,
                                   self.view.bounds.size.width, self.view.bounds.size.height/2);
    self.topView = [[UIView alloc] initWithFrame:topRect];
    self.topView.backgroundColor = [UIColor blackColor];
    
    self.bottomView = [[UIView alloc]initWithFrame:bottomRect];
    self.bottomView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.topView];

    self.aNewGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.aNewGameButton setTitle:@"New Game" forState:UIControlStateNormal];
    [self.aNewGameButton addTarget:self action:@selector(presentNewGame) forControlEvents:UIControlEventTouchUpInside];
    [self.aNewGameButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.aNewGameButton.frame = CGRectMake(self.view.bounds.size.width/2-80, 210.0, 160.0, 40.0);
    [self.bottomView addSubview:self.aNewGameButton];
    
    
    
}

-(BOOL)isPoint:(CGPoint)point InView:(UIView*)view
{
    if (point.x >= view.bounds.origin.x &&
        point.x <= view.bounds.size.width)
    {
        if (point.y >= view.bounds.origin.y &&
            point.y <= view.bounds.size.height)
        {
            return YES;
        }
    }
    return NO;
}
-(CapsGame*)game
{
    if (!_game)
    {
        _game = [[CapsGame alloc] init];
    }
    return _game;
}





@end
