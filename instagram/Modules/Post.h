//
//  Post.h
//  instagram
//
//  Created by Bevin Benson on 7/9/18.
//  Copyright © 2018 Bevin Benson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "PFUser+Extension.h"

@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString * _Nullable postID;
@property (nonatomic, strong) NSString * _Nullable userID;
@property (nonatomic, strong) PFUser * _Nullable author;
@property (nonatomic, strong) NSString * _Nullable caption;
@property (nonatomic, strong) PFFile * _Nullable image;
@property (nonatomic, strong) NSNumber * _Nullable likeCount;
@property (nonatomic, strong) NSNumber * _Nullable commentCount;
@property (nonatomic, strong) NSDate * _Nullable createdAt;
@property (nonatomic, strong) NSMutableArray<PFUser *> * _Nullable userLikes;

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end
