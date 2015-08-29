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

-(void)viewDidLoad
{
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Edit"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(alterEditing)];
    self.navigationItem.rightBarButtonItem = editButton;
}


-(void)alterEditing
{
    if (self.editing == YES) [self setEditing:NO animated:YES];
    else
    {
        [self setEditing:YES animated:YES];
    }
    
}
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
-(NSString*)dateToString:(NSDate*)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    NSInteger day = [components day];
    NSInteger week = [components month];
    NSInteger year = [components year];
    
    NSString* stringDate = [NSString stringWithFormat:@"%ld/%ld/%ld", (long)week, (long)day, (long)year];
    return stringDate;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Past Game Cell" forIndexPath:indexPath];
     
     RLMResults * allGames = [FinalGameStats allObjects];
     FinalGameStats* objectAtIndexPath = [allGames objectAtIndex:indexPath.row];
     cell.textLabel.text = [NSString stringWithFormat:@"Game %lu (Total Hits: %ld)", indexPath.row + 1, (long)objectAtIndexPath.numberOfHits];
     cell.detailTextLabel.text = [self dateToString:objectAtIndexPath.date];
     if (objectAtIndexPath.hitPercentage > .10)
     {
         cell.backgroundColor = [UIColor colorWithRed:0 green:179.0f/255.0f blue:89.0f/255.0f alpha:1];
     }
 
 return cell;
 }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GameStatsVC * gsVC = [[GameStatsVC alloc] init];
    RLMResults * allGames = [FinalGameStats allObjects];
    FinalGameStats* objectAtIndexPath = [allGames objectAtIndex:indexPath.row];
    
    gsVC.finalGameStats = objectAtIndexPath;
    [self.navigationController pushViewController:gsVC animated:YES];
    
    
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
     
 // Delete the row from the data source
     RLMResults * allGames = [FinalGameStats allObjects];
     RLMObject * finalGameStatsToDelete = [allGames objectAtIndex:indexPath.row];
     RLMRealm * realm = [RLMRealm defaultRealm];
     [realm beginWriteTransaction];
     [realm deleteObject:finalGameStatsToDelete];
     [realm commitWriteTransaction];
     
     [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
     
     [tableView reloadData];
     
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }

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

