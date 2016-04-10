//
//  PhotoTableViewCell.h
//  InstagramClone
//
//  Created by Richard Velazquez on 4/9/16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIButton *userNameButtonOutlet;
@property (weak, nonatomic) IBOutlet UITextView *pictureDescription;

@end
