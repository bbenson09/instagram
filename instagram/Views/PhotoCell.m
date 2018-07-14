//
//  PhotoCell.m
//  instagram
//
//  Created by Bevin Benson on 7/9/18.
//  Copyright © 2018 Bevin Benson. All rights reserved.
//

#import "PhotoCell.h"
#import "MainFeedViewController.h"

@implementation PhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setPost:(Post *)post {
    
    _post = post;
    
    self.descriptionLabel.text = self.post.caption;
    self.usernameLabel.text = self.post.author.username;
    self.topUsernameLabel.text = self.post.author.username;
    self.likesLabel.text = [NSString stringWithFormat:@"%@ Likes", [self.post.likeCount stringValue]];
    
    if ([self.post.userLikes containsObject:[PFUser currentUser]]) {
        [self.likesButton setSelected:YES];
    }
    
    PFFile *imageFile = post.image;
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        
        // Do something with the image
        self.photo.image = [UIImage imageWithData:data];
    }];
    
    PFFile *profilePicFile = post.author[@"profilePic"];
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

- (IBAction)likeButtonTapped:(id)sender {
    
    if ([self.post.userLikes containsObject:[PFUser currentUser]]) {
        
        NSNumber *newLikeCount = [NSNumber numberWithInt:[self.post.likeCount intValue] - 1];
        self.post.likeCount = newLikeCount;
        self.likesLabel.text = [NSString stringWithFormat:@"%@ Likes", [self.post.likeCount stringValue]];
        [self.likesButton setSelected:NO];
        [self.post.userLikes addObject:[PFUser currentUser]];
        [self.post saveInBackground];
        
        
    }
    else {
        
        NSNumber *newLikeCount = [NSNumber numberWithInt:[self.post.likeCount intValue] + 1];
        self.post.likeCount = newLikeCount;
        self.likesLabel.text = [NSString stringWithFormat:@"%@ Likes", [self.post.likeCount stringValue]];
        [self.likesButton setSelected:YES];
        [self.post.userLikes removeObject:[PFUser currentUser]];
        [self.post saveInBackground];
    }
    
    
}

@end
