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

@interface GameViewController ()

@property (strong, nonatomic) CapsGame* game;

@property (strong, nonatomic) UIButton* hitButton;
@property (strong, nonatomic) UIButton* missButton;
@property (strong, nonatomic) UIButton* glassMissButton;
@property (strong, nonatomic) UIButton* endGameButton;
@property (strong, nonatomic) UIButton* redoButton;

@property (strong, nonatomic) UILabel* hitPercentage;
@property (strong, nonatomic) UILabel* missPercentage;
@property (strong, nonatomic) UILabel* glassPercentage;
@property (strong, nonatomic) NSString* date;


@end

@implementation GameViewController

static const int MIDDLE_OFFSET = 50;
static const int BUTTON_SIZE = 50;

-(void)loadView
{
    [super loadView];
    
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    UIView *contentView = [[UIView alloc] initWithFrame:applicationFrame];
    contentView.backgroundColor = [UIColor blueColor];
    contentView.alpha = 2.2;

    self.view = contentView;

    
    [self makeHitButtonAndLabel];
    [self makeMissButtonAndLabel];
    [self makeGlassButtonAndLabel];
    [self makeEndGameButton];
    [self makeRedoRect];
    [self addConstraintsToButtons];
    
    
    
    


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
        
        _date = [NSString stringWithFormat:@"%ld.%ld.%ld", (long)day, (long)week, (long)year];
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
-(void)makeGlassButtonAndLabel
{
    self.glassMissButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.glassMissButton.backgroundColor = [UIColor grayColor];
    [self.glassMissButton setTitle:@"GLASS" forState:UIControlStateNormal];
    [self.glassMissButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [self.glassMissButton addTarget:self action:@selector(missGlass) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.glassMissButton];
    
    self.glassPercentage = [[UILabel alloc] init];
    self.glassPercentage.text = [NSString stringWithFormat:@"%.2f", [self.game glassPercentage]];
    [self.glassPercentage sizeToFit];
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
    [self.view addSubview:self.missPercentage];
}
-(void)makeHitButtonAndLabel
{
    self.hitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.hitButton setTitle:@"HIT" forState:UIControlStateNormal];
    self.hitButton.backgroundColor = [UIColor greenColor];
    [self.hitButton addTarget:self action:@selector(makeShot) forControlEvents:UIControlEventTouchUpInside];
    [self.hitButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];

    [self.view addSubview:self.hitButton];
    
    self.hitPercentage = [[UILabel alloc] init];
    self.hitPercentage.text = [NSString stringWithFormat:@"%.2f", [self.game hitPercentage]];
    [self.hitPercentage sizeToFit];
    [self.view addSubview:self.hitPercentage];
}
-(void)makeEndGameButton
{
    CGRect endGameRect = CGRectMake(self.view.bounds.size.width/4 + BUTTON_SIZE/2,
                                      self.view.bounds.size.height - 2 * MIDDLE_OFFSET,
                                      BUTTON_SIZE,
                                      BUTTON_SIZE);
    self.endGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.endGameButton.frame = endGameRect;
    [self.endGameButton setTitle:@"End Game" forState:UIControlStateNormal];
    self.endGameButton.titleLabel.numberOfLines = 2;
    self.endGameButton.titleLabel.minimumScaleFactor = 8./self.endGameButton.titleLabel.font.pointSize;
    self.endGameButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    //[self.endGameButton sizeToFit];
    self.endGameButton.backgroundColor = [UIColor blackColor];
    [self.endGameButton addTarget:self action:@selector(endGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.endGameButton];
}

-(void)makeRedoRect
{
    CGRect redoRect = CGRectMake(3 * self.view.bounds.size.width/4 - 3 * BUTTON_SIZE/2,
                                    self.view.bounds.size.height - 2 * MIDDLE_OFFSET,
                                    BUTTON_SIZE,
                                    BUTTON_SIZE);
    self.redoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.redoButton.frame = redoRect;
    [self.redoButton setTitle:@"Redo" forState:UIControlStateNormal];
    self.redoButton.titleLabel.numberOfLines = 1;
    self.redoButton.titleLabel.minimumScaleFactor = 8./self.redoButton.titleLabel.font.pointSize;
    self.redoButton.titleLabel.adjustsFontSizeToFitWidth = YES;
   
    self.redoButton.backgroundColor = [UIColor blackColor];
    [self.redoButton addTarget:self action:@selector(redoShot) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.redoButton];
}
-(void)endGame
{
    
    
     RLMRealm * realm = [RLMRealm defaultRealm];

    FinalGameStats* finalGameStats = [[FinalGameStats alloc] init];
    finalGameStats.regularMisses = self.game.numberOfRegularMisses;
    finalGameStats.glassMisses = self.game.numberOfGlassMisses;
    finalGameStats.numberOfHits = self.game.numberOfHits;
    finalGameStats.missPercentage = self.game.missPercentage;
    finalGameStats.glassPercentage = self.game.glassPercentage;
    finalGameStats.hitPercentage = self.game.hitPercentage;
    finalGameStats.date = [NSDate date];
    
   // return finalGameStats;
   
    
    [realm beginWriteTransaction];
    [realm addObject:finalGameStats];
    [realm commitWriteTransaction];

    [self.game endGame];
    [self updateUI];
    PastGamesTVC *historyTVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Table"];
    historyTVC.title = @"History";
    [self showViewController:historyTVC sender:self];
}
-(void)updateUI
{
    self.hitPercentage.text = [NSString stringWithFormat:@"%.2f", [self.game hitPercentage]];
    self.missPercentage.text = [NSString stringWithFormat:@"%.2f", [self.game missPercentage]];
    self.glassPercentage.text = [NSString stringWithFormat:@"%.2f", [self.game glassPercentage]];
}
-(void)addConstraintsToButtons
{
    [self.hitButton setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.missButton setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.glassMissButton setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.hitPercentage setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.missPercentage setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.glassPercentage setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.redoButton setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.endGameButton setTranslatesAutoresizingMaskIntoConstraints: NO];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.hitButton
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.missButton
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.missButton
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.glassMissButton
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.hitButton
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.missButton
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.missButton
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.glassMissButton
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.hitButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.5
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.missButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.5
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.glassMissButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.5
                                                           constant:0.0]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.hitButton
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:.5
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.missButton
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.glassMissButton
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.5
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.hitPercentage
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:.5
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.missPercentage
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:.5
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.glassPercentage
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:.5
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.hitPercentage
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.hitButton                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.glassPercentage
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.glassMissButton
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.missPercentage
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.missButton
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.redoButton
                                                          attribute:NSLayoutAttributeLeftMargin
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeftMargin
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.endGameButton
                                                          attribute:NSLayoutAttributeRightMargin                                                         relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRightMargin
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.redoButton
                                                          attribute:NSLayoutAttributeBottomMargin
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottomMargin
                                                         multiplier:1
                                                           constant:0 - 20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.endGameButton
                                                          attribute:NSLayoutAttributeBottomMargin
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottomMargin
                                                         multiplier:1
                                                           constant:0 - 20]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.redoButton
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.endGameButton
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.endGameButton
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.redoButton
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1
                                                           constant:0]];

    

   

}


#pragma mark - Navigation
 /*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
