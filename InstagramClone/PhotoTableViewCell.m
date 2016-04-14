//
//  PhotoTableViewCell.m
//  InstagramClone
//
//  Created by Richard Velazquez on 4/9/16.
//  Copyright © 2016 Team4. All rights reserved.
//


#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>
#import "PhotoTableViewCell.h"


@implementation PhotoTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    //// button formatting
    self.userNameButtonOutlet.titleLabel.font = [UIFont fontWithName:@"Gotham Narrow" size:15];
    [self.userNameButtonOutlet setTitleColor:[UIColor colorWithRed:18/255.0 green:86/255.0 blue:136/255.0 alpha:1.0] forState:UIControlStateNormal];
    self.locationButtonOutlet.titleLabel.font = [UIFont fontWithName:@"Gotham Narrow" size:15];
    [self.locationButtonOutlet setTitleColor:[UIColor colorWithRed:69/255.0 green:142/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    self.viewCommentButton.titleLabel.font = [UIFont fontWithName:@"Gotham Narrow" size:15];
    [self.viewCommentButton setTitleColor:[UIColor colorWithRed:69/255.0 green:142/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    //// uilabel formatting
    self.datePosted.font = [UIFont fontWithName:@"Gotham Narrow" size:15];
    self.datePosted.textColor = [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1.0];
    self.likeCount.font = [UIFont fontWithName:@"Gotham Narrow" size:15];
    self.likeCount.textColor = [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1.0];
    
    //// textview formatting
    [self.pictureDescription setFont:[UIFont fontWithName:@"Gotham Narrow" size:15]];
    [self.pictureDescription setTextColor:[UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1.0]];
    

    self.pictureDescription.editable = false;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onZoomButtonPressed:(UIButton *)sender {
  [self.delegate didTapZoom:sender];

}

- (IBAction)onCommentButtonPressed:(UIButton *)sender {
  [self.delegate didWanttoSeeComments:sender];
}

- (IBAction)onLikeButtonPressed:(UIButton *)sender {
  
  [self.delegate photoLiked: sender];

}




@end
