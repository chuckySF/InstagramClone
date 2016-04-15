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
@property (weak, nonatomic) IBOutlet UITextField *enterCommentTextfield;

@end

@implementation CommentViewController
@synthesize scrollView;


- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.moc = appDelegate.managedObjectContext;
     NSLog(@"sqlite dir = \n%@", appDelegate.applicationDocumentsDirectory);
    
    
    //textfield setting
    self.enterCommentTextfield.placeholder =[NSString stringWithFormat:@"Enter a comment as %@", self.user.userName];
    
    
    self.addCommentButton.layer.cornerRadius = 8; // this value vary as per your desire
    self.addCommentButton.clipsToBounds = YES;

    
    [self.enterCommentTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

}


-(void)textFieldDidChange :(UITextField *)theTextField{
    if (self.enterCommentTextfield.text.length > 0) {
        self.addCommentButton.userInteractionEnabled = true;
        self.addCommentButton.highlighted = false;
    } else {
        self.addCommentButton.userInteractionEnabled = false;
        self.addCommentButton.highlighted = true;
    }

}

-(void)viewWillAppear:(BOOL)animated{
    
    //[self.navigationItem setHidesBackButton:true];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    self.comments = [NSMutableArray new];
    
    self.comments = [[self.photo.comments allObjects] mutableCopy] ;
    
    //testing relationships
    NSLog(@"ckeck this out %@", self.photo.comments);

    
    [self.tableView reloadData];
    
    
    
    self.addCommentButton.userInteractionEnabled = false;
    self.addCommentButton.highlighted = true;

    // Do any additional setup after loading the view.
//    if (self.enterCommentTextfield.text.length > 0) {
//        self.addCommentButton.userInteractionEnabled = true;
//        self.addCommentButton.highlighted = false;
//    } else {
//        self.addCommentButton.userInteractionEnabled = false;
//        self.addCommentButton.highlighted = true;
//    }
    
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
    
    cell.commentLabelCell.text = comment.commentText;
    
    cell.nameLabelCell.text = self.user.userName;
    
    NSData *imageData = self.user.userImage;
    
    cell.imageCell.image = [UIImage imageWithData:imageData];
    
    
    //making the profile picture circle
    //we put the half of the height and weight as a value 
    cell.imageCell.layer.cornerRadius = 22;
    cell.imageCell.layer.masksToBounds = YES;
    
    //this is for ricky
//    cell.profileImageView.layer.cornerRadius = 25;
//    
//    cell.profileImageView.layer.masksToBounds = YES;
  
    
    //date code
    float timeSincePosting = [comment.commentTimestamp timeIntervalSinceNow] * -1;
    float timeSincePostingInMinutes = timeSincePosting/60;
    int minsInt = timeSincePostingInMinutes / 1;
    cell.timeLabelCell.text = [self convertTimeInMinutesToString:minsInt];
    
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

    //adding the comment to the Photo
    [self.photo addCommentsObject:comment];
        
    //adding values to attributes
    comment.commentText = self.enterCommentTextfield.text;

    
    comment.commentTimestamp = [NSDate date];

    //saving in coreData
    NSError *error;
    
    if ([self.moc save:&error]){
        [self.comments addObject:comment];
        NSLog(@"%@,  %lu  in the array", comment, self.comments.count);
    }else{
        NSLog(@"an error has occurred,...%@",error);
    }
    
    //dismiis keyboard
    [self dismissKeyboard:sender];
    [self.enterCommentTextfield setText:@""];

    
    [self.tableView reloadData];
    
        self.addCommentButton.userInteractionEnabled = false;
        self.addCommentButton.highlighted = true;
    
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
        NSLog(@"the picture was deleted");
    }else {
        NSLog(@"ERROR: %@", error);
    }
    
    [self.tableView reloadData];
    
    
}


#pragma textfield
//
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    
//    if (textField.text.length > 0) {
//        self.addCommentButton.userInteractionEnabled = true;
//        self.addCommentButton.highlighted = false;
//    } else {
//        self.addCommentButton.userInteractionEnabled = false;
//        self.addCommentButton.highlighted = true;
//    }
//    return true;
//}
//
//-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//    if (textField.text.length > 0) {
//        self.addCommentButton.userInteractionEnabled = true;
//        self.addCommentButton.highlighted = false;
//    } else {
//        self.addCommentButton.userInteractionEnabled = false;
//        self.addCommentButton.highlighted = true;
//    }
//    return true;
//}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    

    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:TRUE];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y -258., self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
    
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:TRUE];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y +258., self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];

}




-(void) dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
    [self.enterCommentTextfield resignFirstResponder];

}

#pragma setting the comment time stamp


-(NSString *)convertTimeInMinutesToString:(int)minutes{
    if (minutes < 1)
    {
        NSString *returnedString = [NSString stringWithFormat:@"Now"];
        return returnedString;
    }
    else if (minutes < 60)
    {
        NSString *returnedString = [NSString stringWithFormat:@"%im ago", minutes];
        NSLog(@"%@ was returned",returnedString);
        return returnedString;
    }else if (minutes > 60 && minutes < 120)
    {
        int hours = minutes / 60;
        NSString *returnedString = [NSString stringWithFormat:@"%ih ago", hours];
        NSLog(@"%@ was returned",returnedString);
        return returnedString;
    }
    else if (minutes > 60 && minutes < (60 * 24))
    {
        int hours = minutes / 60;
        NSString *returnedString = [NSString stringWithFormat:@"%i ago", hours];
        NSLog(@"%@ was returned",returnedString);
        return returnedString;
    }
    else if (minutes > (60 * 24) && minutes < (60 * 24 * 7))
    {
        int days = minutes / (60 * 24);
        NSString *returnedString = [NSString stringWithFormat:@"%id ago", days];
        NSLog(@"%@ was returned",returnedString);
        return returnedString;
    }else if (minutes > (60 * 24 * 7) && minutes < (60 * 24 * 14)){
        int weeks = minutes / (60 * 24 * 7);
        NSString *returnedString = [NSString stringWithFormat:@"%iw ago", weeks];
        NSLog(@"%@ was returned",returnedString);
        return returnedString;
    }
    else if (minutes > (60 * 24 * 7))
    {
        int weeks = minutes / (60 * 24 * 7);
        NSString *returnedString = [NSString stringWithFormat:@"%i week", weeks];
        NSLog(@"%@ was returned",returnedString);
        return returnedString;
    }
    else {
        return nil;
    }
    
    
}



















































@end
