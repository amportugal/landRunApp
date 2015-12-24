//
//  StartLandViewController.h
//  LandRun
//
//  Created by students@deti on 22/12/15.
//  Copyright © 2015 students@deti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/Corelocation.h>


@interface StartLandViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,
    CLLocationManagerDelegate> {
        CLLocationManager *locationManager;
    }



@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UILabel *HumLabel;
@property (weak, nonatomic) IBOutlet UILabel *PressLabel;
@property (weak, nonatomic) IBOutlet UILabel *KcalLabel;
@property (weak, nonatomic) IBOutlet UILabel *TempLabel;

- (IBAction)StopTheLand:(id)sender;

- (IBAction)takePhoto:(id)sender;

@end
