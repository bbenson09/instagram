//
//  CollectionCell.h
//  instagram
//
//  Created by Bevin Benson on 7/10/18.
//  Copyright © 2018 Bevin Benson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Post.h"

@interface CollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photo;

@property (strong, nonatomic) Post *post;


@end
