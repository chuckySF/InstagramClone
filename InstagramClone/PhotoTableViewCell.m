//
//  PhotoTableViewCell.m
//  InstagramClone
//
//  Created by Richard Velazquez on 4/9/16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import "PhotoTableViewCell.h"

@implementation PhotoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onZoomButtonPressed:(UIButton *)sender {
  [self.delegate didTapZoom:sender];
}


@end
