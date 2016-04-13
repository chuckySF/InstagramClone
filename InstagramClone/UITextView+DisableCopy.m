//
//  UITextView+DisableCopy.m
//  InstagramClone
//
//  Created by Chucky on 4/12/16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import "UITextView+DisableCopy.h"

@implementation UITextView (DisableCopy)

- (BOOL)canBecomeFirstResponder
{
    return NO;
}

@end
