//
//  CollectionCell.m
//  instagram
//
//  Created by Bevin Benson on 7/10/18.
//  Copyright © 2018 Bevin Benson. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell

- (void)setPost:(Post *)post {
    
    _post = post;
    
    PFFile *imageFile = self.post.image;
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        
        // Do something with the image
        self.photo.image = [UIImage imageWithData:data];
    }];

}
- (void)prepareForReuse {
    
    [super prepareForReuse];
    self.photo.image = nil;
    
}

@end
