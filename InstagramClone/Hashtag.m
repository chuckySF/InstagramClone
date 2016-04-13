//
//  Hashtag.m
//  InstagramClone
//
//  Created by Chucky on 4/12/16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import "Hashtag.h"
#import <UIKit/UIKit.h>

@implementation Hashtag


//make behavior selectable in storyboard, all else-unchecked
-(NSMutableAttributedString*)decorateTags:(NSString *)stringWithTags{
    NSError *error = nil;

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\B#(\\w+)" options:0 error:&error];
    //NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"@(\\w+)" options:0 error:&error];
    
    NSArray *matches = [regex matchesInString:stringWithTags options:0 range:NSMakeRange(0, stringWithTags.length)];
    
    //NSLog(@"#%@",matches);
    
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:stringWithTags];
    
    NSInteger stringLength=[stringWithTags length];
    
    for (NSTextCheckingResult *match in matches) {
        NSRange wordRange = [match rangeAtIndex:0];
        NSString* word = [stringWithTags substringWithRange:wordRange];
        
        //Set Font
        UIFont *font=[UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
        [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, stringLength)];
        
        //Set Background Color
        UIColor *backgroundColor=[UIColor orangeColor];
        [attString addAttribute:NSBackgroundColorAttributeName value:backgroundColor range:wordRange];
        
        //Set Foreground Color
        UIColor *foregroundColor=[UIColor blueColor];
        [attString addAttribute:NSForegroundColorAttributeName value:foregroundColor range:wordRange];
        
        //Set Link
        [attString addAttribute:NSLinkAttributeName value:word range:wordRange];
        
        //attributedString.addAttribute(NSLinkAttributeName, value: "https://www.hackingwithswift.com", range: NSMakeRange(19, 55))

        NSLog(@"Found tag %@", word);
    }
    // Set up your text field or label to show up the result
    //    yourTextField.attributedText = attString;
    //    yourLabel.attributedText = attString;
    return attString;
}



@end
