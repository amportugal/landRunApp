//
//  DetailsHistoryViewController.m
//  LandRun
//
//  Created by students@deti on 23/12/15.
//  Copyright © 2015 students@deti. All rights reserved.
//

#import "DetailsHistoryViewController.h"
#import "Parse/Parse.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface DetailsHistoryViewController ()

@end

@implementation DetailsHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.HumLabel setHidden:YES];
    [self.PressLabel setHidden:YES];
    [self.KcalLabel setHidden:YES];
    [self.TempLabel setHidden:YES];
    
    PFUser *current = [PFUser currentUser];
    
    PFQuery *query = [PFQuery queryWithClassName:@"LandSnapshot"];
    [query whereKey:@"username" equalTo:current.username];
    [query whereKey:@"photoName" containsString:self.photoName];
    
    PFObject *object=[query getFirstObject];

    self.HumLabel.text=[NSString stringWithFormat:@"%0.1f%%rH", [object[@"humidity"] floatValue]];
    self.PressLabel.text=[NSString stringWithFormat:@"%@ mBar", object[@"pressure"]];
    self.TempLabel.text=[NSString stringWithFormat:@"%0.1fºC", [object[@"temperature"] floatValue]];
            
    [self.HumLabel setHidden:NO];
    [self.PressLabel setHidden:NO];
    [self.TempLabel setHidden:NO];
    
    typedef void (^ALAssetsLibraryAssetForURLResultBlock)(ALAsset *asset);
    typedef void (^ALAssetsLibraryAccessFailureBlock)(NSError *error);
    
    
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
            if (iref) {
                UIImage *myImage = [UIImage imageWithCGImage:iref];
                self.photo_image.image = myImage;
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                });
            }
    };
    
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        NSLog(@"Can't get image - %@",[myerror localizedDescription]);
    };
    
    ALAssetsLibrary* assetslibrary =  [self defaultAssetsLibrary];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", object[@"photoName"]]];
    [assetslibrary assetForURL:url
                   resultBlock:resultblock
                  failureBlock:failureblock];
    
    
}

- (ALAssetsLibrary *)defaultAssetsLibrary {
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
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

@end
