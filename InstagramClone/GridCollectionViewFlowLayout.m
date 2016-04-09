//
//  GridCollectionViewFlowLayout.m
//  InstagramClone
//
//  Created by Chucky on 4/9/16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import "GridCollectionViewFlowLayout.h"

@implementation GridCollectionViewFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.minimumLineSpacing = 1.0;
        self.minimumInteritemSpacing = 1.0;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

- (CGSize)itemSize
{
    NSInteger numberOfColumns = 3;
    CGFloat itemWidth = (CGRectGetWidth(self.collectionView.frame) - (numberOfColumns - 1)) / numberOfColumns;
    return CGSizeMake(itemWidth, itemWidth);
}

@end
