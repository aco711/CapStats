//
//  GameStatsVC.m
//  CapStats
//
//  Created by Alex Cohen on 8/19/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import "GameStatsVC.h"

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
