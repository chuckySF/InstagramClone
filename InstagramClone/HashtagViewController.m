//
//  HashtagViewController.m
//  InstagramClone
//
//  Created by Chucky on 4/12/16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import "HashtagViewController.h"
#import "Hashtag.h"


@interface HashtagViewController () <UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextView *textView2;

@end

@implementation HashtagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.delegate = self;

    Hashtag *hashtag = [[Hashtag alloc] init];
    self.textView.attributedText = [hashtag decorateTags:self.textView.text];

}


-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
    NSLog(@"tapped");
    return false;
}

- (IBAction)onEmoji1Pressed:(UIButton *)sender {
    NSMutableString *oldString = [self.textView2.text mutableCopy];
    self.textView2.text = [oldString stringByAppendingString:@"#😂 "];
    
}

@end
