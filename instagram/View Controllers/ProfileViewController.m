//
//  ProfileViewController.m
//  instagram
//
//  Created by Bevin Benson on 7/10/18.
//  Copyright © 2018 Bevin Benson. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import "CollectionCell.h"
#import "Post.h"
#import "ProfileSectionHeader.h"
#import "PFUser+Extension.h"

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *profileCollection;
@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) NSArray *posts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.profileCollection.dataSource = self;
    self.profileCollection.delegate = self;
    
    
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.profileCollection.collectionViewLayout;
    
    CGFloat photosPerLine = 3;
    CGFloat itemWidth = self.profileCollection.frame.size.width / photosPerLine;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);

    [self getCurrentUser];
    [self.profileCollection reloadData];

}

- (void)queryUserPosts {
    
    PFQuery *query = [Post query];
    [query whereKey:@"author" equalTo:self.user];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.posts = posts;
            [self.profileCollection reloadData];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)getCurrentUser {
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"objectId" equalTo:[[PFUser currentUser]objectId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        else {
            self.user = [objects firstObject];
            [self queryUserPosts];
        }
    }];
}

- (void)updatedProfileInfo {
    
    [self.profileCollection refreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
 
 }
 */


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionCell" forIndexPath:indexPath];
    cell.post = self.posts[indexPath.item];
    
    return cell;
}
 
 - (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
     
     return self.posts.count;
 }

- (UICollectionReusableView *)collectionView: (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ProfileSectionHeader *header = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ProfileSectionHeader" forIndexPath:indexPath];
        
        header.user = self.user;
    }
    return header;
}





@end
