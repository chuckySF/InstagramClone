//
//  CommentViewController.m
//  InstagramClone
//
//  Created by Richard Velazquez on 4/7/16.
//  Copyright © 2016 Team4. All rights reserved.
//my first branch

#import "CommentViewController.h"
#import "User.h"
#import "Photo.h"
#import "Comment.h"
#import "AppDelegate.h"
#import "CommentCellTableViewCell.h"

@interface CommentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *enterCommentTextField;
@property (weak, nonatomic) IBOutlet UIButton *addCommentButton;
@property (weak, nonatomic) IBOutlet UIView *addCommentBackgroundView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property NSManagedObjectContext *moc;
@property NSMutableArray *comments;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CommentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //setting the pointer to the delegate
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.moc = appDelegate.managedObjectContext;
    
    self.comments = [NSMutableArray new];
    
}

-(void)viewWillAppear:(BOOL)animated{
  //comment view scrolll code [self registerForKeyboardNotifications];
    
    self.comments = [[self.photo.comments allObjects] mutableCopy] ;
//    self.comments = [[self.user.comments allObjects] mutableCopy] ;

    
    [self.tableView reloadData];
}


-(void)viewWillDisappear:(BOOL)animated{
  //comment view scroll code: [self deRegisterForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableView

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
    
    Comment *comment = [self.comments objectAtIndex:indexPath.row];
    
    cell.textCell.text = comment.commentText;
    
    cell.imageCell.image = [UIImage imageNamed:@"cartoon"];
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.comments.count;
}



#pragma Comments Adding + viewing

- (IBAction)onAddCommentButtonPressed:(UIButton *)sender {
    
    Comment *comment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:self.moc];
    
    //adding the comment to the user
    [self.user addCommentsObject:comment];
    comment.commentText = self.enterCommentTextField.text;

    
    //adding the comment to the Photo
    [self.photo addCommentsObject:comment];
    comment.commentText = self.enterCommentTextField.text;

    
    //saving in coreData
    NSError *error;
    
    
    if ([self.moc save:&error]){
        [self.comments addObject:comment];
        NSLog(@"%@", comment);
    }else{
        NSLog(@"an error has occurred,...%@",error);
    }
    
    //setting the textfield blank
    self.enterCommentTextField.text = @"";
}


#pragma Comments deleting comments 

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Comment *comment = [self.comments objectAtIndex:indexPath.row];
    
    [self.moc deleteObject:comment];
    
    //removing the cell
    [self.comments removeObjectAtIndex:indexPath.row];
    
    NSError *error;
    if ([self.moc save:&error]) {
        NSLog(@"the cat was deleted");
    }else {
        NSLog(@"ERROR: %@", error);
    }
    
    [self.tableView reloadData];
    
    
}



















































#pragma Comments textfield scrolling up
//http://masteringios.com/blog/2013/10/04/how-to-make-uitextfield-move-up-when-keyboard-is-present/

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
