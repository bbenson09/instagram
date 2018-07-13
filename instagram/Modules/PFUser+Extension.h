//
//  PFUser+Extension.h
//  instagram
//
//  Created by Bevin Benson on 7/12/18.
//  Copyright © 2018 Bevin Benson. All rights reserved.
//

#import "PFUser.h"
#import <Parse/Parse.h>

@interface PFUser (Extension)

@property (nonatomic, strong) NSNumber *numberFollowers;
@property (nonatomic, strong) NSNumber *numberFollowing;
@property (nonatomic, strong) NSNumber *numberPosts;
@property (nonatomic, strong) PFFile *profilePic;
@property (nonatomic, strong) NSString *userCaption;

+ (void) postUserImage: ( UIImage * _Nullable )image : ( PFUser *)user withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end
