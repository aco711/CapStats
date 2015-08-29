//
//  GameStatsVC.m
//  CapStats
//
//  Created by Alex Cohen on 8/19/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import "GameStatsVC.h"
#import <Realm/Realm.h>
#import "FinalGameStats.h"
#import <PureLayout/PureLayout.h>

@interface GameStatsVC ()

@property (strong, nonatomic) UILabel * hitPercentageLabel;
@property (strong, nonatomic) UILabel * missPercentageLabel;
@property (strong, nonatomic) UILabel * glassPercentageLabel;

@end

@implementation GameStatsVC

-(void)loadView
{
    
    [super loadView];
    if (self.finalGameStats.hitPercentage > .10)
    {
        self.view.backgroundColor = [UIColor colorWithRed:0 green:179.0f/255.0f blue:89.0f/255.0f alpha:1];
    }
    else
    {
        self.view.backgroundColor = [UIColor redColor];
    }
    self.hitPercentageLabel = [[UILabel alloc]init];
    self.missPercentageLabel = [[UILabel alloc]init];
    self.glassPercentageLabel = [[UILabel alloc]init];

    
    self.hitPercentageLabel.text = [NSString stringWithFormat:@"Hit Percentage: %.3f", self.finalGameStats.hitPercentage];
    self.missPercentageLabel.text = [NSString stringWithFormat:@"Miss Percentage: %.3f", self.finalGameStats.missPercentage];
    self.glassPercentageLabel.text = [NSString stringWithFormat:@"Glass Percentage: %.3f", self.finalGameStats.glassPercentage];
    self.hitPercentageLabel.font=[UIFont systemFontOfSize:40];
    self.missPercentageLabel.font=[UIFont systemFontOfSize:40];
    self.glassPercentageLabel.font=[UIFont systemFontOfSize:40];
    self.hitPercentageLabel.adjustsFontSizeToFitWidth = YES;
    self.missPercentageLabel.adjustsFontSizeToFitWidth = YES;
    self.glassPercentageLabel.adjustsFontSizeToFitWidth = YES;
    self.hitPercentageLabel.textAlignment = NSTextAlignmentCenter;
    self.missPercentageLabel.textAlignment = NSTextAlignmentCenter;
    self.glassPercentageLabel.textAlignment = NSTextAlignmentCenter;

    [self.view addSubview:self.hitPercentageLabel];
    [self.view addSubview:self.missPercentageLabel];
    [self.view addSubview:self.glassPercentageLabel];

    
    
    [self updateViewConstraints];
    
   
}


-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self updateViewConstraints];
    
}

-(void)updateViewConstraints
{
    
    CGFloat height = self.navigationController.navigationBar.bounds.size.height;

    
    if (height == 0)
    {
        height = 44;
    }
    
    [self.hitPercentageLabel autoPinEdgeToSuperviewMargin:ALEdgeLeft];
    [self.hitPercentageLabel autoPinEdgeToSuperviewMargin:ALEdgeRight];
    [self.hitPercentageLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.hitPercentageLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:height];
    
    
    [self.missPercentageLabel autoPinEdgeToSuperviewMargin:ALEdgeRight];
    [self.missPercentageLabel autoPinEdgeToSuperviewMargin:ALEdgeLeft];
    [self.missPercentageLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.missPercentageLabel autoConstrainAttribute:ALAttributeTop toAttribute:ALAttributeBottom ofView:self.hitPercentageLabel];
    
    [self.glassPercentageLabel autoPinEdgeToSuperviewMargin:ALEdgeRight];
    [self.glassPercentageLabel autoPinEdgeToSuperviewMargin:ALEdgeLeft];
    [self.glassPercentageLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.glassPercentageLabel autoConstrainAttribute:ALAttributeTop toAttribute:ALAttributeBottom ofView:self.missPercentageLabel];
    [self.glassPercentageLabel autoPinEdgeToSuperviewMargin:ALEdgeBottom];
    
    [@[self.hitPercentageLabel, self.glassPercentageLabel, self.missPercentageLabel] autoMatchViewsDimension:ALDimensionHeight];
    [@[self.hitPercentageLabel, self.missPercentageLabel, self.glassPercentageLabel] autoMatchViewsDimension:ALDimensionWidth];
    
    
    
    [super updateViewConstraints];
    
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
