//
//  NewTextView.m
//  InstagramClone
//
//  Created by Chucky on 4/13/16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import "NewTextView.h"

@implementation NewTextView

//disable copy paste actions
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

//disable magnifier
-(void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    //Prevent zooming but not panning
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
    {
        gestureRecognizer.enabled = NO;
    }
    [super addGestureRecognizer:gestureRecognizer];
    return;
}

@end
