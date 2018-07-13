//
//  ProfileEditorViewController.h
//  instagram
//
//  Created by Bevin Benson on 7/12/18.
//  Copyright © 2018 Bevin Benson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileEditorDelegate

- (void)updatedProfileInfo;

@end

@interface ProfileEditorViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) id<ProfileEditorDelegate> delegate;

@end
