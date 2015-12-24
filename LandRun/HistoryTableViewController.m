//
//  HistoryTableViewController.m
//  LandRun
//
//  Created by students@deti on 24/12/15.
//  Copyright © 2015 students@deti. All rights reserved.
//

#import "HistoryTableViewController.h"
#import "HistoryViewController.h"
#import <Parse/Parse.h>

@interface HistoryTableViewController ()

@end

@implementation HistoryTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.colors = [[NSArray alloc] initWithObjects: @"red", @"yellow", nil];
    //NSMutableArray *array;
    
    PFUser *current = [PFUser currentUser];
    
    PFQuery *query = [PFQuery queryWithClassName:@"LandSnapshot"];
    [query whereKey:@"username" equalTo:current.username];
    
    self.array=[[NSMutableArray alloc] init];
    self.array_ids=[[NSMutableArray alloc] init];
    
    NSArray *objects=[query findObjects];
    
        for (PFObject *message in objects) {
            if ( ![self.array_ids containsObject:message[@"landId"]]) {
                [self.array addObject:message[@"landName"]];
                [self.array_ids addObject:message[@"landId"]];
            }
            
            //message[@"landName"]=[[alertView textFieldAtIndex:0] text];
        }
        //int success = [PFObject saveAll:objects];
        //NSLog(@"Status %@", success? @"updated successfully": @"update failed");
    

    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier =@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text=[self.array objectAtIndex:indexPath.row];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //Value Selected by user
    NSString *selectedValue = [self.array_ids objectAtIndex:indexPath.row];
    //Initialize new viewController
    //HistoryViewController *viewController = [[HistoryViewController alloc] initWithNibName:nil bundle:nil];
    //Pass selected value to a property declared in NewViewController
    //viewController.valueToSearch= selectedValue;
    //Push new view to navigationController stack
    //[self.navigationController pushViewController:viewController animated:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HistoryViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"historyPage"];
    [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
    
    viewController.valueToSearch=selectedValue;
    
    //[self presentViewController:viewController animated:NO completion:NULL];
    [self.navigationController pushViewController:viewController animated:YES];
    
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
