//
//  ViewController.m
//  LandRun
//
//  Created by students@deti on 22/12/15.
//  Copyright © 2015 students@deti. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.textViewUsername.delegate = self;
    self.textViewPassword.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)tryLogin:(id)sender {
    if ([self.textViewUsername.text  length]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User invalid"
                                                        message:@"You must insert a username."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    else if([self.textViewPassword.text  length]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password invalid"
                                                        message:@"You must insert a password."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else{
        
        
        [PFUser logInWithUsernameInBackground:self.textViewUsername.text password:self.textViewPassword.text block:^(PFUser* user, NSError* error){
            if (error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User invalid"
                                                                message:@"That account does not exists."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You are logged in"
                                                                message:@"Congratz."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UINavigationController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"userLoggedIn"];
                [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
                
                [self presentViewController:viewController animated:NO completion:NULL];
            }
        }];
}
}
@end
