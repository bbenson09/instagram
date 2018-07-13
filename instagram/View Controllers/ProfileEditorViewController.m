//
//  ProfileEditorViewController.m
//  instagram
//
//  Created by Bevin Benson on 7/12/18.
//  Copyright © 2018 Bevin Benson. All rights reserved.
//

#import "ProfileEditorViewController.h"
#import "PFUser+Extension.h"

@interface ProfileEditorViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) UIImagePickerController *imagePickerVC;
@property (nonatomic, assign) BOOL isPhone;
@property (strong, nonatomic) PFUser *currentUser;

@end

@implementation ProfileEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentUser = [PFUser currentUser];
    // Do any additional setup after loading the view.
}

- (IBAction)doneClicked:(id)sender {
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
        [PFUser postUserImage:editedImage :self.currentUser withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            NSLog(@"New profile pic posted");
        }];
    }
    else {
        [PFUser postUserImage:originalImage :self.currentUser withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            NSLog(@"New profile pic posted");
        }];
    }
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
