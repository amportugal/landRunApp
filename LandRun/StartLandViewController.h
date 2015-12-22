//
//  StartLandViewController.h
//  LandRun
//
//  Created by students@deti on 22/12/15.
//  Copyright © 2015 students@deti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartLandViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *HumLabel;
@property (weak, nonatomic) IBOutlet UILabel *PressLabel;
@property (weak, nonatomic) IBOutlet UILabel *KcalLabel;
@property (weak, nonatomic) IBOutlet UILabel *TempLabel;
- (IBAction)takePhoto:(id)sender;

@end
