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

    self.HumLabel.text=[NSString stringWithFormat:@"%@", object[@"humidity"]];
    self.PressLabel.text=[NSString stringWithFormat:@"%@", object[@"pressure"]];
    self.KcalLabel.text=[NSString stringWithFormat:@"%@", object[@"kCalories"]];
    self.TempLabel.text=[NSString stringWithFormat:@"%@", object[@"temperature"]];
            
    [self.HumLabel setHidden:NO];
    [self.PressLabel setHidden:NO];
    [self.KcalLabel setHidden:NO];
    [self.TempLabel setHidden:NO];
    
    typedef void (^ALAssetsLibraryAssetForURLResultBlock)(ALAsset *asset);
    typedef void (^ALAssetsLibraryAccessFailureBlock)(NSError *error);
    
    
    /*ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        if(!myasset)
            NSLog(@"I am here");
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
            if (iref) {
                NSLog(@"I am here2");
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"I am here3");
                    UIImage *myImage = [UIImage imageWithCGImage:iref scale:[rep scale] orientation:(UIImageOrientation)[rep orientation]];
                    self.photo_image.image = myImage;
                });
            }
    };
    
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        NSLog(@"Can't get image - %@",[myerror localizedDescription]);
    };
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    NSURL *url = [NSURL URLWithString:@"assets-library://asset/asset.JPG?id=CDC76125-CECE-4572-9D83-FF1A4AAE1CBD&ext=JPG"];
    [assetslibrary assetForURL:url
                   resultBlock:resultblock
                  failureBlock:failureblock];*/
    
    
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
