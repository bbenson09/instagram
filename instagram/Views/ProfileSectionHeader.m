//
//  ProfileSectionHeader.m
//  instagram
//
//  Created by Bevin Benson on 7/12/18.
//  Copyright © 2018 Bevin Benson. All rights reserved.
//

#import "ProfileSectionHeader.h"

@implementation ProfileSectionHeader

- (void)setUser:(PFUser *)user {
    
    _user = user;
    
    self.usernameLabel.text = self.user.username;
    self.numberPosts.text = [self.user.numberPosts stringValue];
    self.numberFollowers.text = [self.user.numberFollowers stringValue];
    self.numberFollowing.text = [self.user.numberFollowing stringValue];
    self.userCaptionLabel.text = self.user.userCaption;
    
    [self setProfilePic];
}

- (void)setProfilePic {
    
    PFFile *profilePicFile = self.user.profilePic;
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

@end
