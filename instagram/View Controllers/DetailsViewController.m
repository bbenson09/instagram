//
//  DetailsViewController.m
//  instagram
//
//  Created by Bevin Benson on 7/10/18.
//  Copyright © 2018 Bevin Benson. All rights reserved.
//

#import "DetailsViewController.h"
#import "DateTools.h"

@interface DetailsViewController ()



@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.usernameLabel.text = self.post.author.username;
    self.descriptionLabel.text = self.post.caption;
    self.likesLabel.text = [NSString stringWithFormat:@"%@ Likes", [self.post.likeCount stringValue]];
    
    PFFile *imageFile = self.post[@"image"];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        
        // Do something with the image
        self.photo.image = [UIImage imageWithData:data];
    }];
    
    NSDate *createdAt = self.post.createdAt;
    self.timeAgo = [createdAt shortTimeAgoSinceNow];
    self.timestampLabel.text = self.timeAgo;
    
    PFFile *profilePicFile = self.post.author[@"profilePic"];
    [profilePicFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        self.profilePic.image = [UIImage imageWithData:data];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonClicked:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
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
