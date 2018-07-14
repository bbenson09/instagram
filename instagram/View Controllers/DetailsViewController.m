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
    
    self.usernameLabel.text = self.post.author.username;
    self.descriptionLabel.text = self.post.caption;
    self.likesLabel.text = [NSString stringWithFormat:@"%@ Likes", [self.post.likeCount stringValue]];
    
    PFFile *imageFile = self.post[@"image"];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
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
        CALayer *imageLayer = self.profilePic.layer;
        [imageLayer setCornerRadius:5];
        [imageLayer setBorderWidth:1];
        [imageLayer setMasksToBounds:YES];
        [self.profilePic.layer setCornerRadius:self.profilePic.frame.size.width/2];
        [self.profilePic.layer setMasksToBounds:YES];
        self.profilePic.image = [UIImage imageWithData:data];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonClicked:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)likeButtonClicked:(id)sender {
    
    NSNumber *newLikeCount = [NSNumber numberWithInt:[self.post.likeCount intValue] + 1];
    self.post.likeCount = newLikeCount;
    self.likesLabel.text = [NSString stringWithFormat:@"%@ Likes", [self.post.likeCount stringValue]];
    [self.post saveInBackground];
}


@end
