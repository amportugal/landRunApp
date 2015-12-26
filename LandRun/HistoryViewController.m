//
//  HistoryViewController.m
//  LandRun
//
//  Created by students@deti on 22/12/15.
//  Copyright © 2015 students@deti. All rights reserved.
//

#import "HistoryViewController.h"
#import <Parse/Parse.h>
#import "AssetsLibrary/AssetsLibrary.h"
#import "LoggedViewController.h"
#import "DetailsHistoryViewController.h"

//#import "AssetsLibrary/AssetsLibrary.h"
//#import "LoggedViewController.h"

@import CoreLocation;
@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Value %@", self.valueToSearch);
    PFQuery *query = [PFQuery queryWithClassName:@"LandSnapshot"];
    [query whereKey:@"landId" equalTo:self.valueToSearch];
    
    
    NSArray *objects = [query findObjects];
    
    PFGeoPoint * _Nullable geoPoint;
    
    for (PFObject *message in objects) {
            //message[@"landName"]=[[alertView textFieldAtIndex:0] text];
        
            geoPoint=message[@"position"];
        
            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([geoPoint latitude], [geoPoint longitude]);
            
            /*Add a marker to the map*/
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        
            [annotation setCoordinate:coord];
            [annotation setTitle:@"Keep running"];
            [annotation setSubtitle:message[@"photoName"]];
            [self.mapView addAnnotation:annotation];
        
        
            
        }
        //int success = [PFObject saveAll:objects];
        //NSLog(@"Status %@", success? @"updated successfully": @"update failed");

    
    
}

/*-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(nonnull id<MKAnnotation>)annotation{
    NSLog(@"herenow");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailsHistoryViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"detailsHistoryPage"];
    [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
    
    viewController.photoName=[annotation title];
    
    //[self presentViewController:viewController animated:NO completion:NULL];
    [self.navigationController pushViewController:viewController animated:YES];
    
    return annotation;
}*/

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

- (IBAction)landSelected:(id)sender {
    MKPointAnnotation *annot=[self.mapView.selectedAnnotations objectAtIndex:0];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailsHistoryViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"detailsHistoryPage"];
    [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
    
    viewController.photoName=[annot subtitle];
    
    //[self presentViewController:viewController animated:NO completion:NULL];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
