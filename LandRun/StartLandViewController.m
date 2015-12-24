//
//  StartLandViewController.m
//  LandRun
//
//  Created by students@deti on 22/12/15.
//  Copyright © 2015 students@deti. All rights reserved.
//

#import "StartLandViewController.h"
#import <Parse/Parse.h>
#import "AssetsLibrary/AssetsLibrary.h"
#import "LoggedViewController.h"

@import CoreLocation;

NSInteger landId;

@implementation StartLandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.HumLabel setHidden:YES];
    [self.PressLabel setHidden:YES];
    [self.KcalLabel setHidden:YES];
    [self.TempLabel setHidden:YES];
    

    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager requestAlwaysAuthorization];
    
    [locationManager startUpdatingLocation];
    
    self.navigationItem.hidesBackButton=YES;
    
    /*Get last land id*/
    PFQuery *query = [PFQuery queryWithClassName:@"LandSnapshot"];
    [query orderByDescending:@"landId"];
    query.limit=1;
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if(!error){
            NSString *landId_string=[object objectForKey:@"landId"];
            if (landId_string == nil)
                landId=0;
            else
                landId=[landId_string intValue];
                landId=landId+1;
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
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

- (IBAction)StopTheLand:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Stop the Land"
                                                    message:@"Are you sure you want to finish this Land?"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    alert.tag=2;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Land" message:@"Insert the name of your Land:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.tag=1;
    switch (alertView.tag) {
        case 1:
            switch(buttonIndex) {
                case 0: //"Cancel" pressed
                    break;
                case 1: //"OK" pressed
                    NSLog([[alertView textFieldAtIndex:0] text]);
                    
                    PFQuery *query = [PFQuery queryWithClassName:@"LandSnapshot"];
                    [query whereKey:@"landId" equalTo:@(landId)];
                    
                    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
                        if (error) {
                            NSLog(@"%@", error);
                            return;
                        }
                        for (PFObject *message in objects) {
                            message[@"landName"]=[[alertView textFieldAtIndex:0] text];
                        }
                        int success = [PFObject saveAll:objects];
                        NSLog(@"Status %@", success? @"updated successfully": @"update failed");
                    }];
                    
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    break;
            }
            break;
        case 2:
            switch(buttonIndex) {
                case 0: //"No" pressed
                    break;
                case 1: //"Yes" pressed
                    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
                    [alert show];
                    break;
            }
            break;
            
        default:
            break;
    }
    
}

- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    __block NSURL *image_url;
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library writeImageToSavedPhotosAlbum:[chosenImage CGImage] orientation:(ALAssetOrientation)[chosenImage imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
        if(error){
            NSLog(@"error");
            
        }
        else{
            image_url=assetURL;
            NSLog(@"url %@", assetURL);
            
            NSLog(@"url %@", [image_url absoluteString]);
            [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint * _Nullable geoPoint, NSError * _Nullable error) {

                if (!error) {
                    PFUser *current = [PFUser currentUser];
                    
                    PFObject *landSnapshot = [PFObject objectWithClassName:@"LandSnapshot"];
                    landSnapshot[@"username"] = current.username;
                    landSnapshot[@"photoName"] = [image_url absoluteString];
                    landSnapshot[@"humidity"] = @50;
                    landSnapshot[@"pressure"] = @51;
                    landSnapshot[@"kCalories"] = @52;
                    landSnapshot[@"temperature"] = @53;
                    landSnapshot[@"position"] = geoPoint;
                    landSnapshot[@"landId"] = [NSNumber numberWithInteger:landId];
                    
                    [landSnapshot saveInBackground];
                    
                    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([geoPoint latitude], [geoPoint longitude]);
                    
                    /*Add a marker to the map*/
                    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                    [annotation setCoordinate:coord];
                    [annotation setTitle:@"Keep running"];
                    [self.mapView addAnnotation:annotation];
                    
                    
                }
                
            }];
            
            [picker dismissViewControllerAnimated:YES completion:NULL];
        }
    }];
    
    
    
    
    
}
@end
