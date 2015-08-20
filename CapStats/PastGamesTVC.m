//
//  PastGamesTVC.m
//  CapStats
//
//  Created by Alex Cohen on 8/19/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import "PastGamesTVC.h"
#import "GameStatsVC.h"
#import "FinalGame.H"

@implementation PastGamesTVC



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"Past Game Cell"];
    
    return cell;
    
    
}


@end
