//
//  DetailsViewController.h
//  instagram
//
//  Created by Bevin Benson on 7/10/18.
//  Copyright © 2018 Bevin Benson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface DetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photo;

@property (strong, nonatomic) Post *post;

@end
