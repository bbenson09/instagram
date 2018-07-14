//
//  ComposeViewController.m
//  instagram
//
//  Created by Bevin Benson on 7/9/18.
//  Copyright © 2018 Bevin Benson. All rights reserved.
//

#import "ComposeViewController.h"
#import <Parse/Parse.h>
#import "ProgressHUD.h"

@interface ComposeViewController ()

@property (strong, nonatomic) UIImagePickerController *imagePickerVC;
@property (weak, nonatomic) IBOutlet UIImageView *imView;
@property (weak, nonatomic) IBOutlet UITextField *captionField;
@property (strong, nonatomic) UIImage *image;
@property (nonatomic, assign) BOOL isPhone;


@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
}

- (IBAction)imageTapped:(id)sender {
    
    NSLog(@"Image tapped");
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
}

- (IBAction)cancelTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shareTapped:(id)sender {
    
    [ProgressHUD show:@"Posting"];
    [Post postUserImage:self.image withCaption:self.captionField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        
        [self.delegate didPost];
        NSLog(@"Successfully posted");
        [ProgressHUD dismiss];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    if (self.isPhone) {
        self.image = editedImage;
        [self.imView setImage:editedImage];
    }
    else {
        self.image = originalImage;
        [self.imView setImage:originalImage];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
