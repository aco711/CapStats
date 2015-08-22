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

@interface GameStatsVC ()

@property (strong, nonatomic) UILabel * hitPercentageLabel;
@property (strong, nonatomic) UILabel * missPercentageLabel;
@property (strong, nonatomic) UILabel * glassPercentageLabel;

@end

@implementation GameStatsVC

-(void)loadView
{
    
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.hitPercentageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 100, 100)];
    self.missPercentageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 100, 100)];
    self.glassPercentageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, 100, 100)];

    
    self.hitPercentageLabel.text = [NSString stringWithFormat:@"Hit Percentage: %.3f", self.finalGameStats.hitPercentage];
    self.missPercentageLabel.text = [NSString stringWithFormat:@"Miss Percentage: %.3f", self.finalGameStats.missPercentage];
    self.glassPercentageLabel.text = [NSString stringWithFormat:@"Glass Percentage: %.3f", self.finalGameStats.glassPercentage];
    [self.hitPercentageLabel sizeToFit];
    [self.missPercentageLabel sizeToFit];
    [self.glassPercentageLabel sizeToFit];
    [self.view addSubview:self.hitPercentageLabel];
    [self.view addSubview:self.missPercentageLabel];
    [self.view addSubview:self.glassPercentageLabel];
    
    [self.hitPercentageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.missPercentageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.glassPercentageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.hitPercentageLabel
                                                          attribute:NSLayoutAttributeLeftMargin
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeftMargin
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.missPercentageLabel
                                                          attribute:NSLayoutAttributeLeftMargin
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeftMargin
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.glassPercentageLabel
                                                          attribute:NSLayoutAttributeLeftMargin
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeftMargin
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.hitPercentageLabel
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.missPercentageLabel
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.missPercentageLabel
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.glassPercentageLabel
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.hitPercentageLabel
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];

    
    
    
    
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
