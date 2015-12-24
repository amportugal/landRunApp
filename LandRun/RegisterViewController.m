//
//  RegisterViewController.m
//  LandRun
//
//  Created by students@deti on 22/12/15.
//  Copyright © 2015 students@deti. All rights reserved.
//

#import "RegisterViewController.h"
#import <Parse/Parse.h>
#import "ViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textViewUsername.delegate = self;
    self.textViewPassword.delegate = self;
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)tryRegister:(id)sender {
    
    if ([self.textViewUsername.text  length]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User invalid"
                                                        message:@"You must insert username before"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    else if([self.textViewPassword.text  length]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password invalid"
                                                        message:@"You must insert password before"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else{
        PFUser *user = [PFUser user];
        user.username = self.textViewUsername.text;
        user.password = self.textViewPassword.text;
        
        //[query whereKey:@"username" equalTo:self.textViewUsername.text];
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if(error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User invalid"
                                                                message:@"User already exists. You must insert another one."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            else
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User created"
                                                                message:@"Log in with your new user."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
                /*ViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
                [self presentViewController:viewController animated:YES completion:NULL];*/
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                ViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"loginPage"];
                [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
                
                [self presentViewController:viewController animated:NO completion:NULL];
                
            }
        }];
    }
}
@end
