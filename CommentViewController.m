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

@interface CommentViewController ()<UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addCommentButton;
@property (weak, nonatomic) IBOutlet UIView *addCommentBackgroundView;
@property NSManagedObjectContext *moc;
@property NSMutableArray *comments;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *enterCommentTextField;

@end

@implementation CommentViewController
@synthesize scrollView;


- (void)viewDidLoad {
    [super viewDidLoad];
    //setting the pointer to the delegate
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.moc = appDelegate.managedObjectContext;
    
    self.comments = [NSMutableArray new];
    
    //keyboard stuff

}

-(void)viewWillAppear:(BOOL)animated{
    
    self.comments = [[self.photo.comments allObjects] mutableCopy] ;
//    self.comments = [[self.user.comments allObjects] mutableCopy] ;

    
    [self.tableView reloadData];
}


-(void)viewWillDisappear:(BOOL)animated{
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
    
    //dismiis keyboard
    [self dismissKeyboard:sender];
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


#pragma scrollview
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y);
    [scrollView setContentOffset:scrollPoint animated: YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
 
    [scrollView setContentOffset:CGPointZero animated: YES];
}

//resign the keyboard
-(BOOL) textFieldShouldReturn: (UITextField *) textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void) dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
    [self.enterCommentTextField resignFirstResponder];

}


















































@end
