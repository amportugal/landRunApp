//
//  LoggedViewController.m
//  LandRun
//
//  Created by students@deti on 22/12/15.
//  Copyright © 2015 students@deti. All rights reserved.
//

#import "LoggedViewController.h"
#import "deviceSelector.h"
#import <Parse/Parse.h>
@interface LoggedViewController ()

@end

@implementation LoggedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)startLand:(id)sender {
    
    deviceSelector *dS = [[deviceSelector alloc]initWithStyle:UITableViewStyleGrouped];
    
    [dS setModalPresentationStyle:UIModalPresentationFullScreen];
    
    [self presentViewController:dS animated:NO completion:NULL];

    
}

- (IBAction)logoutButton:(id)sender {
   
   [PFUser logOut];
    if (![PFUser currentUser])
   {
       //go to login page
       NSLog(@"GOtoLogin");
       UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
       UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"loginPage"];
       [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
       
       [self presentViewController:viewController animated:NO completion:NULL];

   }
   
    
}

@end
