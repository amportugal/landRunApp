//
//  ViewController.h
//  LandRun
//
//  Created by students@deti on 22/12/15.
//  Copyright © 2015 students@deti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>


- (IBAction)tryLogin:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *textViewUsername;

@property (weak, nonatomic) IBOutlet UITextField *textViewPassword;

@end

