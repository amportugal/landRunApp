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

@import CoreLocation;


@implementation StartLandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.HumLabel setHidden:YES];
    [self.PressLabel setHidden:YES];
    [self.KcalLabel setHidden:YES];
    [self.TempLabel setHidden:YES];
    
    /*[self.mapView addObserver:self
                   forKeyPath:@"myLocation"
                      options:(NSKeyValueObservingOptionNew |
                               NSKeyValueObservingOptionOld)
                      context:NULL];*/

    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager requestAlwaysAuthorization];
    
    [locationManager startUpdatingLocation];
    
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
                    
                    [landSnapshot saveInBackground];
                    
                    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([geoPoint latitude], [geoPoint longitude]);
                    
                    /*Add a marker to the map*/
                    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                    [annotation setCoordinate:coord];
                    [annotation setTitle:@"Keep running bitch"];
                    [self.mapView addAnnotation:annotation];
                    
                    
                }
                
            }];
            
            [picker dismissViewControllerAnimated:YES completion:NULL];
        }
    }];
    
    
    
    
    
}
@end
