//
//  DetailsHistoryViewController.h
//  LandRun
//
//  Created by students@deti on 23/12/15.
//  Copyright © 2015 students@deti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface DetailsHistoryViewController : UIViewController

@property (nonatomic, strong) NSString *photoName;
@property (weak, nonatomic) IBOutlet UILabel *HumLabel;
@property (weak, nonatomic) IBOutlet UILabel *PressLabel;
@property (weak, nonatomic) IBOutlet UILabel *KcalLabel;
@property (weak, nonatomic) IBOutlet UILabel *TempLabel;

@property (weak, nonatomic) IBOutlet UIImageView *photo_image;

- (ALAssetsLibrary *)defaultAssetsLibrary;

@end
