//
//  PFUser+Extension.m
//  instagram
//
//  Created by Bevin Benson on 7/12/18.
//  Copyright © 2018 Bevin Benson. All rights reserved.
//

#import "PFUser+Extension.h"


@implementation PFUser (Extension)

- (NSNumber *)numberFollowing {
    return self[@"numberFollowing"];
}

- (void)setNumberFollowing:(NSNumber *)numberFollowing {
    self[@"numberFollowing"] = numberFollowing;
}

- (NSNumber *)numberFollowers {
    return self[@"numberFollowers"];
}

- (void)setNumberFollowers:(NSNumber *)numberFollowers {
    self[@"numberFollowers"] = numberFollowers;
}

- (NSNumber *)numberPosts {
    return self[@"numberPosts"];
}

- (void)setNumberPosts:(NSNumber *)numberPosts {
    self[@"numberPosts"] = numberPosts;
}

- (PFFile *)profilePic {
    return self[@"profilePic"];
}

- (void)setProfilePic:(PFFile *)profilePic {
    self[@"profilePic"] = profilePic;
}

- (NSString *)userCaption {
    return self[@"userCaption"];
}

- (void)setUserCaption:(NSString *)userCaption {
    self[@"userCaption"] = userCaption;
}

+ (void) postUserImage: ( UIImage * _Nullable )image : ( PFUser *)user withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    user.profilePic = [self getPFFileFromImage:image];
    
    [user.profilePic saveInBackgroundWithBlock: completion];
}

+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFile fileWithName:@"image.png" data:imageData];
}

@end
