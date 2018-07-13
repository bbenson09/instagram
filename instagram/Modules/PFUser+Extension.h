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

@property (nonatomic, strong) NSNumber * _Nullable numberFollowers;
@property (nonatomic, strong) NSNumber * _Nullable numberFollowing;
@property (nonatomic, strong) NSNumber * _Nullable numberPosts;
@property (nonatomic, strong) PFFile * _Nullable profilePic;
@property (nonatomic, strong) NSString * _Nullable userCaption;

+ (void) postProfileImage: ( UIImage * _Nullable )image : ( PFUser * _Nullable)user withCompletion: (PFBooleanResultBlock  _Nullable)completion;

+ (void) postCaption: ( NSString * _Nullable)caption : ( PFUser * _Nullable)user withCompletion: (PFBooleanResultBlock _Nullable)completion;

@end
