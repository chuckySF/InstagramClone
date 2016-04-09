//
//  CommentViewController.m
//  InstagramClone
//
//  Created by Richard Velazquez on 4/7/16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()
@property (weak, nonatomic) IBOutlet UITextField *enterCommentTextField;
@property (weak, nonatomic) IBOutlet UIButton *addCommentButton;
@property (weak, nonatomic) IBOutlet UIView *addCommentBackgroundView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation CommentViewController


-(void)viewWillAppear:(BOOL)animated{
  //comment view scrolll code [self registerForKeyboardNotifications];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated{
  //comment view scroll code: [self deRegisterForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma Comments Adding + viewing

//http://masteringios.com/blog/2013/10/04/how-to-make-uitextfield-move-up-when-keyboard-is-present/
- (IBAction)onAddCommentButtonPressed:(UIButton *)sender {
//  
}
//
//- (void)registerForKeyboardNotifications {
//  [[NSNotificationCenter defaultCenter] addObserver:self
//                                           selector:@selector(keyboardWasShown:)
//                                               name:UIKeyboardDidShowNotification
//                                             object:nil];
//  
//  [[NSNotificationCenter defaultCenter] addObserver:self
//                                           selector:@selector(keyboardWillBeHidden:)
//                                               name:UIKeyboardWillHideNotification
//                                             object:nil];
//  
//  
//}
//
//- (void)deRegisterForKeyboardNotifications {
//  [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                  name:UIKeyboardDidHideNotification
//                                                object:nil];
//  
//  [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                  name:UIKeyboardWillHideNotification
//                                                object:nil];
//  
//}
//
//- (void)keyboardWasShown:(NSNotification *)notification {
//  
//  NSDictionary* info = [notification userInfo];
//  
//  CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//  
//  CGPoint commentButtonOrigin = self.addCommentButton.frame.origin;
//  CGPoint enterCommentTextFieldOrigin = self.enterCommentTextField.frame.origin;
//  CGPoint addCommentBackgroundViewOrigin = self.addCommentBackgroundView.frame.origin;
//
//
//  CGFloat commentButtonHeight = self.addCommentButton.frame.size.height;
//  CGFloat enterCommentTextFieldHeight = self.enterCommentTextField.frame.size.height;
//
//  
//  CGRect visibleRect = self.view.frame;
//  
//  visibleRect.size.height -= keyboardSize.height;
//  
//  if (!CGRectContainsPoint(visibleRect, commentButtonOrigin)){
//    
//    CGPoint scrollPoint = CGPointMake(0.0, commentButtonOrigin.y - visibleRect.size.height + commentButtonHeight);
//    
//    [self.scrollView setContentOffset:scrollPoint animated:YES];
//    
//  }
//  
//  if (!CGRectContainsPoint(visibleRect, enterCommentTextFieldOrigin)){
//    
//    CGPoint scrollPoint = CGPointMake(0.0, enterCommentTextFieldOrigin.y - visibleRect.size.height + enterCommentTextFieldHeight);
//    
//    [self.scrollView setContentOffset:scrollPoint animated:YES];
//    
//  }
//  
//  if (!CGRectContainsPoint(visibleRect, addCommentBackgroundViewOrigin)){
//    
//    CGPoint scrollPoint = CGPointMake(0.0, enterCommentTextFieldOrigin.y - visibleRect.size.height + enterCommentTextFieldHeight);
//    
//    [self.scrollView setContentOffset:scrollPoint animated:YES];
//    
//  }
//  
//}
//
//- (void)keyboardWillBeHidden:(NSNotification *)notification {
//  
//  [self.scrollView setContentOffset:CGPointZero animated:YES];
//  
//}



@end
