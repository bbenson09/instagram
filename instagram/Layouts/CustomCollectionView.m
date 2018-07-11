//
//  CustomCollectionView.m
//  instagram
//
//  Created by Bevin Benson on 7/11/18.
//  Copyright © 2018 Bevin Benson. All rights reserved.
//

#import "CustomCollectionView.h"

@implementation CustomCollectionView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.minimumLineSpacing = 1.0;
        self.minimumInteritemSpacing = 1.0;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        
    }
    return self;
}

- (CGSize)itemSize
{
    NSInteger numberOfColumns = 3;
    
    CGFloat itemWidth = (CGRectGetWidth(self.collectionView.frame) - (numberOfColumns - 1)) / numberOfColumns;
    return CGSizeMake(itemWidth, itemWidth);
}



@end
