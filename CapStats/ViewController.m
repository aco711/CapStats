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
#import <PureLayout/PureLayout.h>


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
    [self.navigationController pushViewController:gameVC animated:YES];
    //[self showViewController:gameVC sender:self];
    }

-(void)presentHistory
{
  PastGamesTVC *historyTVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Table"];
    historyTVC.title = @"History";
    [self.navigationController pushViewController:historyTVC animated:YES];
}

-(void)loadView
{
    [super loadView];
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    UIView *contentView = [[UIView alloc] initWithFrame:applicationFrame];
    self.view = contentView;
    
    self.view.backgroundColor = [UIColor cyanColor];
    self.view.alpha = .5;

    self.aNewGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.aNewGameButton setTitle:@"New Game" forState:UIControlStateNormal];
    [self.aNewGameButton addTarget:self action:@selector(presentNewGame) forControlEvents:UIControlEventTouchUpInside];
    [self.aNewGameButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.aNewGameButton sizeToFit];
    [self.view addSubview:self.aNewGameButton];
    
    
    self.historyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.historyButton setTitle:@"History" forState:UIControlStateNormal];
    [self.historyButton addTarget:self action:@selector(presentHistory) forControlEvents:UIControlEventTouchUpInside];
    [self.historyButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.historyButton sizeToFit];
    [self.view addSubview:self.historyButton];
    
    [self updateViewConstraints];
    

    
    
    
}

-(CapsGame*)game
{
    if (!_game)
    {
        _game = [[CapsGame alloc] init];
    }
    return _game;
}
-(void)updateViewConstraints
{
    [self.aNewGameButton setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.historyButton setTranslatesAutoresizingMaskIntoConstraints: NO];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.aNewGameButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.aNewGameButton
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.5
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.historyButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.historyButton
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:.5
                                                           constant:0.0]];
    
    [self.aNewGameButton autoSetDimension:ALDimensionWidth toSize:100];
    [self.aNewGameButton autoSetDimension:ALDimensionHeight toSize:100];
    [self.historyButton  autoSetDimension:ALDimensionWidth toSize:100];
    [self.historyButton autoSetDimension:ALDimensionHeight toSize:100];
    
    
    [super updateViewConstraints];
}








@end
