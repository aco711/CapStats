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

@property (strong, nonatomic) UITextView* textView;

@end

@implementation GameStatsVC

-(void)loadView
{
    
    [super loadView];
    CGRect textViewRect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.textView = [[UITextView alloc] initWithFrame:textViewRect];
    self.textView.editable = NO;
    self.textView.text = [NSString stringWithFormat:@"Hit Percentage: %.3f\nMiss Percentage: %.3f\nGlass Percentage: %.3f", self.finalGameStats.hitPercentage, self.finalGameStats.missPercentage, self.finalGameStats.glassPercentage];
    [self.view addSubview:self.textView];
    
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
