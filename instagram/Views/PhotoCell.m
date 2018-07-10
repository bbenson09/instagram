//
//  PhotoCell.m
//  instagram
//
//  Created by Bevin Benson on 7/9/18.
//  Copyright © 2018 Bevin Benson. All rights reserved.
//

#import "PhotoCell.h"

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
    
    PFFile *imageFile = post[@"image"];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        
        // Do something with the image
        self.photo.image = [UIImage imageWithData:data];
    }];
    
    
    
    
}

@end
