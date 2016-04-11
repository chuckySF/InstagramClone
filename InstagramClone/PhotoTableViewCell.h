//
//  PhotoTableViewCell.h
//  InstagramClone
//
//  Created by Richard Velazquez on 4/9/16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PhotoTableViewCellDelegate
-(void)didTapZoom:(UIButton *)button;
-(void)didWanttoSeeComments:(UIButton *)button;

@end



@interface PhotoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIButton *userNameButtonOutlet;
@property (weak, nonatomic) IBOutlet UITextView *pictureDescription;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *datePosted;
@property (weak, nonatomic ) UITapGestureRecognizer *imageTapped;

@property (nonatomic, assign) id <PhotoTableViewCellDelegate> delegate;

@end
