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
    
    [self setProfilePic];
}

- (void)setProfilePic {
    
    PFFile *profilePicFile = self.user.profilePic;
    [profilePicFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        self.profilePic.image = [UIImage imageWithData:data];
    }];
}

@end
