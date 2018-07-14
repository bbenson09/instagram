//
//  ProfileEditorViewController.m
//  instagram
//
//  Created by Bevin Benson on 7/12/18.
//  Copyright © 2018 Bevin Benson. All rights reserved.
//

#import "ProfileEditorViewController.h"
#import "PFUser+Extension.h"
#import <Parse/Parse.h>

@interface ProfileEditorViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) UIImagePickerController *imagePickerVC;
@property (nonatomic, assign) BOOL isPhone;
@property (weak, nonatomic) IBOutlet UITextField *captionEditor;
@property (strong, nonatomic) PFUser *currentUser;


@end

@implementation ProfileEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentUser = [PFUser currentUser];
    
    // Do any additional setup after loading the view.
    
    PFFile *profilePicFile = self.currentUser.profilePic;
    [profilePicFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        
        if (!data) {
            return NSLog(@"%@", error);
        }
        
        CALayer *imageLayer = self.profilePic.layer;
        [imageLayer setCornerRadius:5];
        [imageLayer setBorderWidth:1];
        [imageLayer setMasksToBounds:YES];
        [self.profilePic.layer setCornerRadius:self.profilePic.frame.size.width/2];
        [self.profilePic.layer setMasksToBounds:YES];
        self.profilePic.image = [UIImage imageWithData:data];
    }];
}

- (IBAction)doneClicked:(id)sender {
    
    if (![self.captionEditor.text isEqualToString:@""] ) {
        
        self.currentUser.userCaption = self.captionEditor.text;
        [self.currentUser saveInBackground];
        NSLog(@"Caption edited");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)imageTapped:(id)sender {
    
    self.imagePickerVC = [UIImagePickerController new];
    self.imagePickerVC.delegate = self;
    self.imagePickerVC.allowsEditing = YES;
    
    
    
    self.isPhone = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    if (self.isPhone) {
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    if (self.isPhone) {
        [PFUser postProfileImage:editedImage :self.currentUser withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            NSLog(@"New profile pic posted");
        }];
        
    }
    else {
        [PFUser postProfileImage:originalImage :self.currentUser withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            NSLog(@"New profile pic posted");
        }];
    }
    [self.currentUser saveInBackground];
    PFFile *profilePicFile = self.currentUser.profilePic;
    [profilePicFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        
        CALayer *imageLayer = self.profilePic.layer;
        [imageLayer setCornerRadius:5];
        [imageLayer setBorderWidth:1];
        [imageLayer setMasksToBounds:YES];
        [self.profilePic.layer setCornerRadius:self.profilePic.frame.size.width/2];
        [self.profilePic.layer setMasksToBounds:YES];
        self.profilePic.image = [UIImage imageWithData:data];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backButtonTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
