//
//  videoCellTableViewCell.m
//  InstagramClone
//
//  Created by James Rochabrun on 14-04-16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import "videoCellTableViewCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>

@implementation videoCellTableViewCell




-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.movie = [[MPMoviePlayerController alloc] init];
    self.movie.scalingMode = MPMovieScalingModeAspectFit;
    [self.contentView addSubview:self.movie.view];
  
  [self.movie play];

  
    return self;
}


//-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
////    if (self) {
//        self.movie = [[MPMoviePlayerController alloc] init];
//        self.movie.scalingMode = MPMovieScalingModeAspectFit;
//        [self.contentView addSubview:self.movie.view];
//
//    return self;
//}

- (void)layoutSubviews {
    [super layoutSubviews];
//    self.movie.accessibilityFrame = CGRectMake(10, 0, self.bounds.size.width - 80, self.bounds.size.height);
    [self.movie.view setFrame:CGRectMake(10, 0, self.bounds.size.width - 80, self.bounds.size.height)];
  

}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
