//
//  ViewController.m
//  CapStats
//
//  Created by Alex Cohen on 8/16/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import "ViewController.h"
#import "CapsGame.h"
#import "GameViewController.h"
#import "PastGamesTVC.h"

@interface ViewController ()
@property (strong, nonatomic) CapsGame* game;
//@property (weak, nonatomic) IBOutlet UILabel *missPercentageLabel;
//@property (weak, nonatomic) IBOutlet UILabel *hitPercentageLabel;

//@property (weak, nonatomic) IBOutlet UILabel *glassPercentageLabel;
@property (strong, nonatomic) UIView* topView;
@property (strong, nonatomic) UIView* bottomView;
@property (strong, nonatomic) UIButton* aNewGameButton;
@property (strong, nonatomic) UIButton* historyButton;

@end


@implementation ViewController

-(void)presentNewGame
{
    GameViewController* gameVC = [[GameViewController alloc] init];
    gameVC.title = @"Caps Game";
    [self showViewController:gameVC sender:self];
    // [self performSegueWithIdentifier:@"test" sender:self];
}

-(void)presentHistory
{
  PastGamesTVC *historyTVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Table"];
    historyTVC.title = @"History";
    [self showViewController:historyTVC sender:self];
}

-(void)loadView
{
    [super loadView];
    
//    CGRect topRect = CGRectMake(self.view.bounds.origin.x,
//                                self.view.bounds.origin.y, self.view.bounds.size.width,
//                                self.view.bounds.size.height/2);
//    CGRect bottomRect = CGRectMake(self.view.bounds.origin.x,
//                                   self.view.bounds.size.height/2,
//                                   self.view.bounds.size.width, self.view.bounds.size.height/2);
//    self.topView = [[UIView alloc] initWithFrame:topRect];
//    self.topView.backgroundColor = [UIColor cyanColor];
//    self.topView.alpha = -3;
//    
//    self.bottomView = [[UIView alloc]initWithFrame:bottomRect];
//    self.bottomView.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:self.bottomView];
//    [self.view addSubview:self.topView];
    
    self.view.backgroundColor = [UIColor cyanColor];
    self.view.alpha = .5;

    self.aNewGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.aNewGameButton setTitle:@"New Game" forState:UIControlStateNormal];
    [self.aNewGameButton addTarget:self action:@selector(presentNewGame) forControlEvents:UIControlEventTouchUpInside];
    [self.aNewGameButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.aNewGameButton sizeToFit];
    self.aNewGameButton.frame = CGRectMake(self.view.bounds.size.width/2 - self.aNewGameButton.bounds.size.width/2,
                                           4 * self.view.bounds.size.height/5, self.aNewGameButton.bounds.size.width, self.aNewGameButton.bounds.size.height);
    [self.view addSubview:self.aNewGameButton];
    
    
    self.historyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.historyButton setTitle:@"History" forState:UIControlStateNormal];
    [self.historyButton addTarget:self action:@selector(presentHistory) forControlEvents:UIControlEventTouchUpInside];
    [self.historyButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.historyButton sizeToFit];
    self.historyButton.frame = CGRectMake(self.view.bounds.size.width/2 - self.aNewGameButton.bounds.size.width/2,
                                           2 * self.view.bounds.size.height/5, self.aNewGameButton.bounds.size.width, self.aNewGameButton.bounds.size.height);
    [self.view addSubview:self.historyButton];
    
    
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
