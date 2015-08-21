//
//  PastGamesTVC.m
//  CapStats
//
//  Created by Alex Cohen on 8/19/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import "PastGamesTVC.h"
#import "GameStatsVC.h"
#import <Realm/Realm.h>
#import "FinalGameStats.h"

@implementation PastGamesTVC


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
   // RLMRealm * realm = [RLMRealm defaultRealm];
    RLMResults * allGames = [FinalGameStats allObjects];
    return [allGames count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Past Game Cell" forIndexPath:indexPath];
     
     RLMResults * allGames = [FinalGameStats allObjects];
     FinalGameStats* objectAtIndexPath = [allGames objectAtIndex:indexPath.row];
     cell.textLabel.text = [NSString stringWithFormat:@"Game %lu", (unsigned long)objectAtIndexPath.gameNumber];
     cell.detailTextLabel.text = [NSString stringWithFormat:@"Hit Percentage: %.2f", objectAtIndexPath.hitPercentage];
     
     
 
 // Configure the cell...
 
 return cell;
 }

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GameStatsVC * gsVC = [[GameStatsVC alloc] init];
    RLMResults * allGames = [FinalGameStats allObjects];
    FinalGameStats* objectAtIndexPath = [allGames objectAtIndex:indexPath.row];
    
    gsVC.finalGameStats = objectAtIndexPath;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self showViewController:gsVC sender:self];
    
    
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

