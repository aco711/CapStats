//
//  GameViewController.m
//  CapStats
//
//  Created by Alex Cohen on 8/17/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import "GameViewController.h"
#import "CapsGame.h"
#import "StartScreen.h"

@interface GameViewController ()

@property (strong, nonatomic) CapsGame* game;

@property (strong, nonatomic) UIButton* hitButton;
@property (strong, nonatomic) UIButton* missButton;
@property (strong, nonatomic) UIButton* glassMissButton;
@property (strong, nonatomic) UIButton* endGameButton;

@property (strong, nonatomic) UILabel* hitPercentage;
@property (strong, nonatomic) UILabel* missPercentage;
@property (strong, nonatomic) UILabel* glassPercentage;


@end

@implementation GameViewController

static const int MIDDLE_OFFSET = 50;
static const int BUTTON_SIZE = 50;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)loadView
{
    [super loadView];
    
    [self makeHitButtonAndLabel];
    [self makeMissButtonAndLabel];
    [self makeGlassButtonAndLabel];
    [self makeEndGameButton];
    
    
    
    
    

    
    self.view.backgroundColor = [UIColor whiteColor];
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
-(void)makeGlassButtonAndLabel
{
    CGRect glassButtonRect = CGRectMake( 3 * self.view.bounds.size.width/4 - BUTTON_SIZE/2,
                                        self.view.bounds.size.height/2 + MIDDLE_OFFSET - BUTTON_SIZE/2,
                                        BUTTON_SIZE, BUTTON_SIZE);
    
    self.glassMissButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.glassMissButton.frame = glassButtonRect;
    self.glassMissButton.backgroundColor = [UIColor blueColor];
    [self.glassMissButton setTitle:@"GLASS" forState:UIControlStateNormal];
    [self.glassMissButton addTarget:self action:@selector(missGlass) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.glassMissButton];
    
    CGRect glassLabelRect = CGRectMake(3 * self.view.bounds.size.width/4 - BUTTON_SIZE/2,
                                        (self.view.bounds.size.height/2 + MIDDLE_OFFSET - BUTTON_SIZE/2)/2,
                                       BUTTON_SIZE, BUTTON_SIZE);
    self.glassPercentage = [[UILabel alloc] initWithFrame:glassLabelRect];
    self.glassPercentage.text = [NSString stringWithFormat:@"%.2f", [self.game glassPercentage]];
    [self.glassPercentage sizeToFit];
    [self.view addSubview:self.glassPercentage];
    
}
-(void)makeMissButtonAndLabel
{
    CGRect missButtonRect = CGRectMake( self.view.bounds.size.width/2 - BUTTON_SIZE/2,
                                       self.view.bounds.size.height/2 + MIDDLE_OFFSET - BUTTON_SIZE/2,
                                       BUTTON_SIZE, BUTTON_SIZE);
    
    self.missButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.missButton.frame = missButtonRect;
    self.missButton.backgroundColor = [UIColor redColor];
    [self.missButton setTitle:@"MISS" forState:UIControlStateNormal];
    [self.missButton addTarget:self action:@selector(missRegular) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.missButton];
    
    CGRect missLabelRect = CGRectMake(self.view.bounds.size.width/2 - BUTTON_SIZE/2,
                                       ((self.view.bounds.size.height/2 + MIDDLE_OFFSET - BUTTON_SIZE/2)/2),
                                       BUTTON_SIZE, BUTTON_SIZE);
    self.missPercentage = [[UILabel alloc] initWithFrame:missLabelRect];
    self.missPercentage.text = [NSString stringWithFormat:@"%.2f", [self.game missPercentage]];
    [self.missPercentage sizeToFit];
    [self.view addSubview:self.missPercentage];
}
-(void)makeHitButtonAndLabel
{
    CGRect hitButtonRect = CGRectMake(self.view.bounds.size.width/4 - BUTTON_SIZE/2,
                                      self.view.bounds.size.height/2 + MIDDLE_OFFSET - BUTTON_SIZE/2,
                                      BUTTON_SIZE,
                                      BUTTON_SIZE);
    self.hitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.hitButton.frame = hitButtonRect;
    [self.hitButton setTitle:@"HIT" forState:UIControlStateNormal];
    self.hitButton.backgroundColor = [UIColor greenColor];
    [self.hitButton addTarget:self action:@selector(makeShot) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.hitButton];
    
    CGRect hitLabelRect = CGRectMake(self.view.bounds.size.width/4 - BUTTON_SIZE/2,
                                      ((self.view.bounds.size.height/2 + MIDDLE_OFFSET - BUTTON_SIZE/2)/2),
                                      BUTTON_SIZE, BUTTON_SIZE);
    self.hitPercentage = [[UILabel alloc] initWithFrame:hitLabelRect];
    self.hitPercentage.text = [NSString stringWithFormat:@"%.2f", [self.game hitPercentage]];
    [self.hitPercentage sizeToFit];
    [self.view addSubview:self.hitPercentage];
}
-(void)makeEndGameButton
{
    CGRect endGameRect = CGRectMake(self.view.bounds.size.width/2 - BUTTON_SIZE/2,
                                      self.view.bounds.size.height - 2 * MIDDLE_OFFSET,
                                      BUTTON_SIZE,
                                      BUTTON_SIZE);
    self.endGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.endGameButton.frame = endGameRect;
    [self.endGameButton setTitle:@"End Game" forState:UIControlStateNormal];
    [self.endGameButton sizeToFit];
    self.endGameButton.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.endGameButton];
}
-(void)updateUI
{
    self.hitPercentage.text = [NSString stringWithFormat:@"%.2f", [self.game hitPercentage]];
    self.missPercentage.text = [NSString stringWithFormat:@"%.2f", [self.game missPercentage]];
    self.glassPercentage.text = [NSString stringWithFormat:@"%.2f", [self.game glassPercentage]];
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
