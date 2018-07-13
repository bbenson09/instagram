//
//  ProfileSectionHeader.h
//  instagram
//
//  Created by Bevin Benson on 7/12/18.
//  Copyright © 2018 Bevin Benson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFUser+Extension.h"

@interface ProfileSectionHeader : UICollectionReusableView;

@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *numberPosts;
@property (weak, nonatomic) IBOutlet UILabel *numberFollowers;
@property (weak, nonatomic) IBOutlet UILabel *numberFollowing;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userCaptionLabel;

@property (strong, nonatomic) PFUser *user;

@end
