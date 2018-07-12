//
//  LoginViewController.m
//  instagram
//
//  Created by Bevin Benson on 7/9/18.
//  Copyright © 2018 Bevin Benson. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "PFUser+Extension.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (IBAction)signUpTapped:(id)sender {
    
    if ([self.usernameField.text isEqual:@""]) {
        [self issueAlert:@"Username Required" :@"Please enter a username"];
    }

    else if ([self.passwordField.text isEqual: @""]) {
        [self issueAlert:@"Password Required" :@"Please enter a password"];
    }
    else {
        [self registerUser];
    }
}

- (IBAction)loginTapped:(id)sender {
    
    if ([self.usernameField.text isEqual:@""]) {
        [self issueAlert:@"Username Required" :@"Please enter a username"];
    }
    else if ([self.passwordField.text isEqual: @""]) {
        [self issueAlert:@"Password Required" :@"Please enter a password"];
    }
    else {
        [self loginUser];
    }
}

- (void)loginUser {
    
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            [self performSegueWithIdentifier:@"segueFromLogin" sender:nil];
        }
    }];
}

- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;

    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            [self performSegueWithIdentifier:@"segueFromLogin" sender:nil];
        }
    }];
    newUser.numberFollowing = @0;
    newUser.numberFollowers = @0;
    newUser.numberPosts = @0;
    newUser.profilePic = nil;
    [newUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"Updated following, followers, post numbers");
    }];
}

- (void)issueAlert:(NSString *)title :(NSString *)message {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:(title) message:(message) preferredStyle:(UIAlertControllerStyleAlert)];
    
    // create a cancel action
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        // handle cancel response here. Doing nothing will dismiss the view.
    }];
    
    // add the cancel action to the alertController
    [alert addAction:cancelAction];
    
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // handle response here.
        
    }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
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
