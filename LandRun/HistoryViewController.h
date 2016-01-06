//
//  HistoryViewController.h
//  LandRun
//
//  Created by students@deti on 22/12/15.
//  Copyright © 2015 students@deti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface HistoryViewController : UIViewController <MKMapViewDelegate>

- (IBAction)landSelected:(id)sender;

@property (nonatomic, strong) NSString *valueToSearch;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIButton *getMomentButton;


@end
