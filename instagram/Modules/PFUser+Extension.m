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
@end
