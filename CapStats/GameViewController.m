//
//  GameViewController.m
//  CapStats
//
//  Created by Alex Cohen on 8/17/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import "GameViewController.h"
#import "CapsGame.h"
#import "PastGamesTVC.h"
#import <Realm/Realm.h>
#import "FinalGameStats.h"
#import <PureLayout/PureLayout.h>

@interface GameViewController () <UINavigationControllerDelegate>

@property (strong, nonatomic) CapsGame* game;

@property (strong, nonatomic) UIButton* hitButton;
@property (strong, nonatomic) UIButton* missButton;
@property (strong, nonatomic) UIButton* glassMissButton;
@property (strong, nonatomic) UIButton* endGameButton;
@property (strong, nonatomic) UIButton* redoButton;
@property (strong, nonatomic) UIBarButtonItem* historyButton;

@property (strong, nonatomic) UILabel* hitPercentage;
@property (strong, nonatomic) UILabel* missPercentage;
@property (strong, nonatomic) UILabel* glassPercentage;
@property (strong, nonatomic) NSString* date;


@end

@implementation GameViewController

#pragma mark - Set Up

-(void)loadView
{
    [super loadView];
    
    
    
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    UIView *contentView = [[UIView alloc] initWithFrame:applicationFrame];
    contentView.backgroundColor = [UIColor whiteColor];
    //contentView.alpha = 2.2;
    
    self.view = contentView;
    self.title = @"Caps Game";
    
    
    [self makeHitButtonAndLabel];
    [self makeMissButtonAndLabel];
    [self makeGlassButtonAndLabel];
    [self makeEndGameButton];
    [self makeRedoRect];
    [self makeHistoryBarButtonItem];
    
    
    
    
}
-(void)viewDidLoad
{
    [self updateViewConstraints];
}

#pragma mark - Set Up Helper Functions

-(void)makeHistoryBarButtonItem
{
    self.historyButton = [[UIBarButtonItem alloc] initWithTitle:@"History" style:UIBarButtonItemStylePlain target:self action:@selector(presentHistory)];
    self.navigationItem.leftBarButtonItem = self.historyButton;
}

-(void)makeGlassButtonAndLabel
{
    self.glassMissButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.glassMissButton.backgroundColor = [UIColor blueColor];
    [self.glassMissButton setTitle:@"GLASS" forState:UIControlStateNormal];
    [self.glassMissButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [self.glassMissButton addTarget:self action:@selector(missGlass) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.glassMissButton];
    
    self.glassPercentage = [[UILabel alloc] init];
    self.glassPercentage.text = [NSString stringWithFormat:@"%.2f", [self.game glassPercentage]];
    [self.glassPercentage sizeToFit];
    self.glassPercentage.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.glassPercentage];
    
}
-(void)makeMissButtonAndLabel
{
    
    
    self.missButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.missButton.backgroundColor = [UIColor redColor];
    [self.missButton setTitle:@"MISS" forState:UIControlStateNormal];
    [self.missButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    
    [self.missButton addTarget:self action:@selector(missRegular) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.missButton];
    
    self.missPercentage = [[UILabel alloc] init];
    self.missPercentage.text = [NSString stringWithFormat:@"%.2f", [self.game missPercentage]];
    [self.missPercentage sizeToFit];
    self.missPercentage.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.missPercentage];
}
-(void)makeHitButtonAndLabel
{
    self.hitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.hitButton setTitle:@"HIT" forState:UIControlStateNormal];
    self.hitButton.backgroundColor = [UIColor colorWithRed:0 green:179.0f/255.0f blue:89.0f/255.0f alpha:1];
    [self.hitButton addTarget:self action:@selector(makeShot) forControlEvents:UIControlEventTouchUpInside];
    [self.hitButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    
    [self.view addSubview:self.hitButton];
    
    self.hitPercentage = [[UILabel alloc] init];
    self.hitPercentage.text = [NSString stringWithFormat:@"%.2f", [self.game hitPercentage]];
    [self.hitPercentage sizeToFit];
    self.hitPercentage.opaque = NO;
    self.hitPercentage.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.hitPercentage];
}
-(void)makeEndGameButton
{
    
    self.endGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.endGameButton setTitle:@"End Game" forState:UIControlStateNormal];
    self.endGameButton.backgroundColor = [UIColor blackColor];
    [self.endGameButton addTarget:self action:@selector(endGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.endGameButton];
}

-(void)makeRedoRect
{
    
    self.redoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.redoButton setTitle:@"Redo" forState:UIControlStateNormal];
    self.redoButton.titleLabel.numberOfLines = 1;
    
    self.redoButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    self.redoButton.backgroundColor = [UIColor blackColor];
    [self.redoButton addTarget:self action:@selector(redoShot) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.redoButton];
}

#pragma mark - Transition Functions


-(void)presentHistory
{
    PastGamesTVC *historyTVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Table"];
    historyTVC.title = @"History";
    [self.navigationController pushViewController:historyTVC animated:YES];
}


-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self updateViewConstraints];
    
}

-(NSString*)date
{
    if (!_date)
    {
        _date = [[NSString alloc] init];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        
        NSInteger day = [components day];
        NSInteger week = [components month];
        NSInteger year = [components year];
        
        _date = [NSString stringWithFormat:@"%ld/%ld/%ld", (long)day, (long)week, (long)year];
    }
    return _date;
}




-(CapsGame*)game
{
    if (!_game)
    {
        _game = [[CapsGame alloc] init];
    }
    return _game;
}

-(void)makeShot
{
    [self.game makeShot];
    [self updateUI];
}
-(void)missGlass
{
    [self.game missGlass];
    [self updateUI];
}
-(void)missRegular
{
    [self.game missRegular];
    [self updateUI];
}
-(void)redoShot
{
    [self.game redoShot];
    [self updateUI];
}
-(void)endGame
{
    
    [self presentEndGameAlert];
}

-(void)presentEndGameAlert
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Game Over"
                                                                   message:@"Are you sure you want to end the game?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             
                                                         }];
    
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              RLMRealm * realm = [RLMRealm defaultRealm];
                                                              
                                                              
                                                              FinalGameStats* finalGameStats = [[FinalGameStats alloc] init];
                                                              finalGameStats.regularMisses = self.game.numberOfRegularMisses;
                                                              finalGameStats.glassMisses = self.game.numberOfGlassMisses;
                                                              finalGameStats.numberOfHits = self.game.numberOfHits;
                                                              finalGameStats.missPercentage = self.game.missPercentage;
                                                              finalGameStats.glassPercentage = self.game.glassPercentage;
                                                              finalGameStats.hitPercentage = self.game.hitPercentage;
                                                              finalGameStats.date = [NSDate date];
                                                              
                                                              [realm beginWriteTransaction];
                                                              [realm addObject:finalGameStats];
                                                              [realm commitWriteTransaction];
                                                              
                                                              
                                                              
                                                              [self.game endGame];
                                                              [self updateUI];
                                                              PastGamesTVC *historyTVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Table"];
                                                              historyTVC.title = @"History";
                                                              [self.navigationController pushViewController:historyTVC animated:YES];
                                                              
                                                          }];
    
    [alert addAction:cancelAction];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)updateUI
{
    self.hitPercentage.text = [NSString stringWithFormat:@"%.2f", [self.game hitPercentage]];
    self.missPercentage.text = [NSString stringWithFormat:@"%.2f", [self.game missPercentage]];
    self.glassPercentage.text = [NSString stringWithFormat:@"%.2f", [self.game glassPercentage]];
}

-(void)updateViewConstraints
{
    CGFloat height = self.navigationController.navigationBar.bounds.size.height;
    
    if (height == 0)
    {
        height = 44;
    }
    
    
    [self.hitButton autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.hitButton autoConstrainAttribute:ALAttributeLeft toAttribute:ALAttributeVertical ofView:self.view];
    [self.hitButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:height];
    
    [self.missButton autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.missButton autoConstrainAttribute:ALAttributeLeft toAttribute:ALAttributeVertical ofView:self.view];
    [self.missButton autoConstrainAttribute:ALAttributeTop toAttribute:ALAttributeBottom ofView:self.hitButton];
    
    [self.glassMissButton autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.glassMissButton autoConstrainAttribute:ALAttributeLeft toAttribute:ALAttributeVertical ofView:self.view];
    [self.glassMissButton autoConstrainAttribute:ALAttributeBottom toAttribute:ALAttributeTop ofView:self.endGameButton];
    [self.glassMissButton autoConstrainAttribute:ALAttributeTop toAttribute:ALAttributeBottom ofView:self.missButton];
    
    [@[self.glassMissButton, self.missButton, self.hitButton] autoMatchViewsDimension:ALDimensionHeight];
    [@[self.glassMissButton, self.missButton, self.hitButton] autoMatchViewsDimension:ALDimensionWidth];
    
    
    
    [self.hitPercentage autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.hitPercentage autoConstrainAttribute:ALAttributeRight toAttribute:ALAttributeVertical ofView:self.view];
    [self.hitPercentage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:height];
    
    [self.missPercentage autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.missPercentage autoConstrainAttribute:ALAttributeRight toAttribute:ALAttributeVertical ofView:self.view];
    [self.missPercentage autoConstrainAttribute:ALAttributeTop toAttribute:ALAttributeBottom ofView:self.hitPercentage];
    
    [self.glassPercentage autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.glassPercentage autoConstrainAttribute:ALAttributeRight toAttribute:ALAttributeVertical ofView:self.view];
    [self.glassPercentage autoConstrainAttribute:ALAttributeBottom toAttribute:ALAttributeTop ofView:self.redoButton];
    [self.glassPercentage autoConstrainAttribute:ALAttributeTop toAttribute:ALAttributeBottom ofView:self.missPercentage];
    
    [@[self.glassPercentage, self.missPercentage, self.hitPercentage] autoMatchViewsDimension:ALDimensionHeight];
    [@[self.glassPercentage, self.missPercentage, self.hitPercentage] autoMatchViewsDimension:ALDimensionWidth];
    
    
    
    [self.redoButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.redoButton autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.redoButton autoConstrainAttribute:ALAttributeRight toAttribute:ALAttributeVertical ofView:self.view];
    [self.redoButton autoSetDimension:ALDimensionHeight toSize:height];
    
    
    [self.endGameButton autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.endGameButton autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.endGameButton autoConstrainAttribute:ALAttributeLeft toAttribute:ALAttributeVertical ofView:self.view];
    [self.endGameButton autoSetDimension:ALDimensionHeight toSize:height];
    
    //[self.redoButton autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.endGameButton];
    //[self.redoButton autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.endGameButton];
    
    
    
    
    [super updateViewConstraints];
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    [self updateViewConstraints];
}





@end
