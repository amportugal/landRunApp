//
//  StartLandViewController.m
//  LandRun
//
//  Created by students@deti on 22/12/15.
//  Copyright © 2015 students@deti. All rights reserved.
//

#import "StartLandViewController.h"

@interface StartLandViewController ()

@end

@implementation StartLandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.HumLabel setHidden:YES];
    [self.PressLabel setHidden:YES];
    [self.KcalLabel setHidden:YES];
    [self.TempLabel setHidden:YES];
    
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
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    UIImageWriteToSavedPhotosAlbum(chosenImage, nil, nil, nil);
        
}
@end
