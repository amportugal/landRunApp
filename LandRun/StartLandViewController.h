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
#import "BLEDevice.h"
#import "BLEUtility.h"
#import "deviceCellTemplate.h"
#import "Sensors.h"
#import <MessageUI/MessageUI.h>

#define MIN_ALPHA_FADE 0.2f
#define ALPHA_FADE_STEP 0.05f


@interface StartLandViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CBCentralManagerDelegate,CBPeripheralDelegate, MFMailComposeViewControllerDelegate,
CLLocationManagerDelegate> {
        CLLocationManager *locationManager;
    };



@property (strong,nonatomic) BLEDevice *d;
@property NSMutableArray *sensorsEnabled;


@property (weak, nonatomic) IBOutlet UIWebView *webview;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UILabel *HumLabel;
@property (weak, nonatomic) IBOutlet UILabel *PressLabel;
@property (weak, nonatomic) IBOutlet UILabel *KcalLabel;
@property (weak, nonatomic) IBOutlet UILabel *TempLabel;

@property (weak, nonatomic) BLEDevice *andSensorTag;

- (IBAction)StopTheLand:(id)sender;

- (IBAction)takePhoto:(id)sender;




/// Everything funny jajajajajjajaja
@property (strong,nonatomic) temperatureCellTemplate *ambientTemp;
@property (strong,nonatomic) temperatureCellTemplate *irTemp;
@property (strong,nonatomic) accelerometerCellTemplate *acc;
@property (strong,nonatomic) temperatureCellTemplate *rH;
@property (strong,nonatomic) accelerometerCellTemplate *mag;
@property (strong,nonatomic) sensorMAG3110 *magSensor;
@property (strong,nonatomic) temperatureCellTemplate *baro;
@property (strong,nonatomic) sensorC953A *baroSensor;
@property (strong,nonatomic) accelerometerCellTemplate *gyro;
@property (strong,nonatomic) sensorIMU3000 *gyroSensor;


@property (strong,nonatomic) sensorTagValues *currentVal;
@property (strong,nonatomic) NSMutableArray *vals;
@property (strong,nonatomic) NSTimer *logTimer;

@property float logInterval;

-(id) initWithStyle:(UITableViewStyle)style andSensorTag:(BLEDevice *)andSensorTag;

-(void) configureSensorTag;
-(void) deconfigureSensorTag;




- (IBAction) handleCalibrateMag;
- (IBAction) handleCalibrateGyro;

-(void) alphaFader:(NSTimer *)timer;
-(void) logValues:(NSTimer *)timer;

-(IBAction)sendMail:(id)sender;


@end
