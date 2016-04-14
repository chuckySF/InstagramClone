//
//  CommentCellTableViewCell.m
//  InstagramClone
//
//  Created by James Rochabrun on 09-04-16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import "CommentCellTableViewCell.h"

@implementation CommentCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    //format username
    self.nameLabelCell.font = [UIFont fontWithName:@"Gotham Narrow" size:15];
    self.nameLabelCell.textColor = [UIColor colorWithRed:18/255.0 green:86/255.0 blue:136/255.0 alpha:1.0];

    //format date timestamp
    self.timeLabelCell.font = [UIFont fontWithName:@"Gotham Narrow" size:15];
    self.timeLabelCell.textColor = [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1.0];

    //format comment text
    self.commentLabelCell.font = [UIFont fontWithName:@"Gotham Narrow" size:15];
    self.commentLabelCell.textColor = [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1.0];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
