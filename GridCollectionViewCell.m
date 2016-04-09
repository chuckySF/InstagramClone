//
//  GridCollectionViewCell.m
//  InstagramClone
//
//  Created by Chucky on 4/9/16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import "GridCollectionViewCell.h"

@implementation GridCollectionViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.center = CGPointMake(self.contentView.bounds.size.width/2,self.contentView.bounds.size.height/2);
}


@end
