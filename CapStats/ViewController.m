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
#import <BFPaperButton/BFPaperButton.h>
#import "UIColor+BFPaperColors.h"


@interface ViewController ()
@property (strong, nonatomic) CapsGame* game;
//@property (weak, nonatomic) IBOutlet UILabel *missPercentageLabel;
//@property (weak, nonatomic) IBOutlet UILabel *hitPercentageLabel;

//@property (weak, nonatomic) IBOutlet UILabel *glassPercentageLabel;
@property (strong, nonatomic) UIView* topView;
@property (strong, nonatomic) UIView* bottomView;
@property (strong, nonatomic) UIButton* aNewGameButton;
@property (strong, nonatomic) BFPaperButton* historyButton;
@property (strong, nonatomic) BFPaperButton* startGameButton;

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
    
    self.startGameButton = [[BFPaperButton alloc] initWithFrame:CGRectMake(20, 20, 280, 43) raised:YES];
    [self.startGameButton setTitle:@"Start Game" forState:UIControlStateNormal];
    self.startGameButton.backgroundColor = [UIColor paperColorRed200];  // This is from the included cocoapod "UIColor+BFPaperColors".
    [self.startGameButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [self.startGameButton setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    self.startGameButton.cornerRadius = 50;
    [self.startGameButton addTarget:self action:@selector(presentNewGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startGameButton];

    
    
    self.historyButton = [[BFPaperButton alloc] initWithFrame:CGRectMake(20, 20, 280, 43) raised:YES];
    [self.historyButton setTitle:@"History" forState:UIControlStateNormal];
    self.historyButton.backgroundColor = [UIColor paperColorRed200];  // This is from the included cocoapod "UIColor+BFPaperColors".
    [self.historyButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [self.historyButton setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    self.historyButton.cornerRadius = 50;
    [self.historyButton addTarget:self action:@selector(presentHistory) forControlEvents:UIControlEventTouchUpInside];
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
    [self.startGameButton setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.historyButton setTranslatesAutoresizingMaskIntoConstraints: NO];
    
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.startGameButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.startGameButton
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.5
                                                           constant:0.0]];
    
    [self.startGameButton autoSetDimension:ALDimensionHeight toSize:100];
    [self.startGameButton autoSetDimension:ALDimensionWidth toSize:100];

    
    
    
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
    
    [self.historyButton  autoSetDimension:ALDimensionWidth toSize:100];
    [self.historyButton autoSetDimension:ALDimensionHeight toSize:100];
    
    
    [super updateViewConstraints];
}








@end
