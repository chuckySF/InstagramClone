//
//  HomeViewController.m
//  InstagramClone
//hello  
//
//  Created by Richard Velazquez on 4/7/16.
//  Copyright © 2016 Team4. All rights reserved.
//

// made changes 7:08

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "Photo.h"
#import "PhotoTableViewCell.h"
#import "Comment.h"
#import "User.h"
#import "GridViewController.h"
#import "CommentViewController.h"
#import "ZoomImageViewController.h"
#import "AddPhotoViewController.h"
#import "Like.h"



@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource,PhotoTableViewCellDelegate, UIScrollViewDelegate>
@property NSMutableArray *photos;
@property NSMutableArray *users;
@property NSManagedObjectContext *moc;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property UIImage *zoomImage;
@property Photo *clickedPhoto;
@property User *currentUser;

@property (weak, nonatomic) IBOutlet UIButton *gridButton;
@property (weak, nonatomic) IBOutlet UIButton *listButton;

@end

@implementation HomeViewController


#pragma View load/Appear

-(void)viewWillAppear:(BOOL)animated{
  
  [self pullPhotosFromCoreData];
  [self.tableView reloadData];
  
  [self.tableView setAllowsSelection:NO];
  
  //////setup formatting
  self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"Billabong" size:30]};
    
    
    self.gridButton.highlighted = true;
    self.listButton.highlighted = false;
}




- (void)viewDidLoad {
  [super viewDidLoad];
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  self.moc = appDelegate.managedObjectContext;
  
    
  [self pullPhotosFromCoreData];
  
  if (self.photos.count == 0) {
    [self createDefaultPhotosAndSaveToCoreData];
  }
  
  //sets up current user
  //Photo *tempPhoto = [self.photos objectAtIndex:0];
  
  //////setup formatting
  UIColor *instaBlue = [UIColor colorWithRed:(18/255.0) green:(86/255.0) blue:(136/255.0) alpha:1];
  self.navigationController.navigationBar.barTintColor = instaBlue;
  self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
  self.navigationController.navigationBar.translucent = NO;
  self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"Billabong" size:30]};
  self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
  
  
  //////setup formatting
  self.gridButton.imageView.clipsToBounds = true;
  self.gridButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
  //self.gridButton.imageView.frame.size = CGSizeMake(44.0, 44.0);
  //self.gridButton.imageView.frame.size = CGSizeMake(44.0, 44.0)
  [self.gridButton setFrame:CGRectMake(0, 0, 24.0, 24.0)];
  
  
  self.listButton.imageView.clipsToBounds = true;
  self.listButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
  //self.gridButton.imageView.frame.size = CGSizeMake(44.0, 44.0);
  //self.gridButton.imageView.frame.size = CGSizeMake(44.0, 44.0)
  [self.listButton setFrame:CGRectMake(0, 0, 24.0, 24.0)];
    

    
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  NSLog(@"Memomry crash");
  
}

-(void)viewWillDisappear:(BOOL)animated{
  //NSLog(@"VIEW WILL DISAPPEAR");
}



#pragma CoreData
-(void)createDefaultPhotosAndSaveToCoreData{
  self.photos = [NSMutableArray new];
  NSString *d1 = @"Hi I hope you like this picture";
  NSString *d2 = @"Woah, I'm like a #legit photographer";
  NSString *d3 = @"I think I'll delete this one #deleting";
  NSString *d4 = @"#damn you guys messed up now";
  NSString *d5 = @" Hi, my name is #what, my name is #who";
  
  NSArray *descriptions = @[d1,d2,d3,d4,d5];
  
  User *defaultUser= [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.moc];
  defaultUser.userName = @"DoubleClickRick";
  UIImage *userProfilePicture = [UIImage imageNamed:@"image0"];
  defaultUser.userImage = UIImageJPEGRepresentation(userProfilePicture, 1.0);
  self.currentUser = defaultUser;
  
  for (int i = 0; i < 5; i++) {
    
    NSString *photoString = [NSString stringWithFormat:@"image%i", i];
    UIImage *newImage = [UIImage imageNamed:photoString];
    
    Photo *newPhoto = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:self.moc];
    
    newPhoto.photoImage = UIImageJPEGRepresentation(newImage, 1.0);
    newPhoto.photoDescription = [descriptions objectAtIndex:i];
    newPhoto.photoTimestamp = [NSDate date];
    
    newPhoto.user = defaultUser;
    
    [self.photos addObject:newPhoto];
  }
  
  NSError *error;
  if ([self.moc save:&error]) {
    NSLog(@"Save was a success");
    NSLog(@"%lu is how many photos that were saved to core data", (unsigned long)self.photos.count);
  } else {
    NSLog(@"failed because %@", error);
  }
  
}

-(void)pullPhotosFromCoreData {
  
  self.photos = [NSMutableArray new];
  
  //fetch request for photo
  NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Photo"];
  NSError *error;
  
  NSMutableArray *coreDataArray = [[self.moc executeFetchRequest:request error:&error]mutableCopy];
  
  if (error == nil) {
    NSLog(@"pull was successful");
    
    //sorts the array
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"photoTimestamp" ascending:NO];
    self.photos = [[coreDataArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]]mutableCopy];
    //[self.tableView reloadData];
    
  } else {
    NSLog(@"Error: %@", error);
  }

  //fetch request for user
  NSFetchRequest *request1 = [[NSFetchRequest alloc]initWithEntityName:@"User"];
  NSError *error1;
  
  NSMutableArray *coreDataArray1 = [[self.moc executeFetchRequest:request1 error:&error1]mutableCopy];
  
  if (error == nil) {
    NSLog(@"User pull was successful");
    
    //sorts the array
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"photoTimestamp" ascending:NO];
    self.users = [[coreDataArray1 sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]]mutableCopy];
    
    if (self.users.count > 0)
    {
      self.currentUser = [self.users objectAtIndex:0];
    }
    
    //then reload data
    [self.tableView reloadData];
    
  } else {
    NSLog(@"User Pull Error: %@", error);
  }

  
  
  

}



#pragma mark Table View
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.photos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
       
  //grabbing temporary photo item
  Photo *tempPhoto = [self.photos objectAtIndex:indexPath.row];
  
  //casting as user
  User *tempUser = (User *)tempPhoto.user;
  NSLog(@"the user for this photo is %@", tempUser.userName);
  
  //creating cell
  PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  
  //seting image info
  NSData *imageData = tempPhoto.photoImage;
  cell.photoImageView.image = [UIImage imageWithData:imageData];
  cell.profileImageView.image = [UIImage imageWithData:tempUser.userImage];
    
    //make profile imageview circular
    cell.profileImageView.layer.cornerRadius = 22;
    cell.profileImageView.layer.masksToBounds = YES;

    
    
  cell.pictureDescription.text = tempPhoto.photoDescription;
  
  
  //Comment button Title logic
  
  if (tempPhoto.comments.count == 0)
  {
    [cell.commentButton setTitle:@"Comment" forState:UIControlStateNormal];
  }
  else
  {
    NSString *buttontitle = [NSString stringWithFormat:@"Comments %lu", tempPhoto.comments.count];
    [cell.commentButton setTitle:buttontitle forState:UIControlStateNormal];
  }
  
  //date code
  float timeSincePosting = [tempPhoto.photoTimestamp timeIntervalSinceNow] * -1;
  float timeSincePostingInMinutes = timeSincePosting/60;
  int minsInt = timeSincePostingInMinutes / 1;
  cell.datePosted.text = [self convertTimeInMinutesToString:minsInt];
  
  
  
  
  NSString *likeCount = [NSString stringWithFormat:@"💙 %lu likes", tempPhoto.likes.count];
  
  
  cell.likeCount.text = likeCount;
  
  
  [cell.userNameButtonOutlet setTitle:tempUser.userName forState:UIControlStateNormal];
  
  //delegate stuff
  cell.delegate = self;
  
  //Decides which heart appears
  if ([self currentUserHasLikedPicture:tempPhoto]) {
    [cell.heartButton setImage:[UIImage imageNamed:@"heart-full-red"] forState:UIControlStateNormal];
    //NSLog(@"this image should be the full heart");
    
  }else {
    [cell.heartButton setImage:[UIImage imageNamed:@"heart-outline"] forState:UIControlStateNormal];
    //NSLog(@"this image should be empty heart");
  }
  
  return cell;
}



-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
  NSString *delete = [NSString stringWithFormat:@"Delete Picture"];
  return delete;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
  return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
  
  Photo *deletedPhoto = [self.photos objectAtIndex:indexPath.row];
  
  //deletes photo
  [self.photos removeObject:deletedPhoto];
  [self.moc deleteObject:deletedPhoto];
  
  [self.tableView reloadData];
  
  //Saves moc
  NSError *error;
  [self.moc save:&error];
}


#pragma User Interaction
-(void)didTapZoom:(UIButton *)button{
  
  //gets the appropriate cell
  CGPoint hitPoint = [button convertPoint:CGPointZero toView:self.tableView];
  NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
  Photo *zommedPhoto = [self.photos objectAtIndex:hitIndex.row];
  
  //gets the image for that cell and saves it for public access so we have it in prepare for segue
  NSData *imageData = zommedPhoto.photoImage;
  self.zoomImage = [UIImage imageWithData:imageData];
  
  [self performSegueWithIdentifier:@"zoomSegue" sender:nil];
}


-(void)didWanttoSeeComments:(UIButton *)button{
  
  CGPoint hitPoint = [button convertPoint:CGPointZero toView:self.tableView];
  NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
  Photo *commentPhoto = [self.photos objectAtIndex:hitIndex.row];
  
  self.clickedPhoto = commentPhoto;
  
  [self performSegueWithIdentifier:@"commentSegue" sender:nil];
}


-(BOOL)currentUserHasLikedPicture:(Photo *)photo{
  
  NSSet *likesSet = photo.likes;
  
  for (Like *like in likesSet)
  {
    if (like.user == self.currentUser)
    {
      return YES;
    }
  }
  
  return NO;
}



-(void)photoLiked:(UIButton *)button{
  CGPoint hitPoint = [button convertPoint:CGPointZero toView:self.tableView];
  NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
  Photo *likedPhoto = [self.photos objectAtIndex:hitIndex.row];
  
  if ([self currentUserHasLikedPicture:likedPhoto]){
    //REMOVE THE LIKE
    
    //Run through the likes and remove the matching like
    
    NSSet *likesSet = likedPhoto.likes;
    NSLog(@"%lu",(unsigned long)likesSet.count);
    if (likesSet.count == 0) {
    }
    else
    {
      for (Like *like in likesSet)
      {
        //finds the like and removes it
        if (like.user == self.currentUser)
        {
          [likedPhoto removeLikesObject:like];
        }
      }
    }
  }
  else
    //CREATE A NEW LIKE AND SETS UP THE RELATIONSHIP
  {
    
    //creates new like
    Like *newLike = [NSEntityDescription insertNewObjectForEntityForName:@"Like" inManagedObjectContext:self.moc];
    
    //establishes the relationship
    [likedPhoto addLikesObject:newLike];
    [self.currentUser addLikesObject:newLike];
    
  }
  
  //saves either way
  NSError *error;
  [self.moc save:&error];
  
  //reloads the tableview after it is done
  [self.tableView reloadData];
  
}




#pragma Segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  if ([segue.identifier isEqualToString:@"gridSegue"]){
    
    GridViewController *destVC =  segue.destinationViewController;
    destVC.photos = self.photos;
    destVC.user = self.currentUser;
    
  }
  else if ([segue.identifier isEqualToString:@"commentSegue"]){
    
    CommentViewController *destVC = segue.destinationViewController;
    Photo *passedPhoto = self.clickedPhoto;
    User *passedUser = (User *)passedPhoto.user; //!!!!!!!!! needs to change after one user
    
    destVC.photo = passedPhoto;
    destVC.user = passedUser;
  }
  else if ([segue.identifier isEqualToString:@"zoomSegue"]){
    
    ZoomImageViewController *destVC = segue.destinationViewController;
    destVC.passedImage = self.zoomImage;
      
    
  }else if ([segue.identifier isEqualToString:@"homeToAddPhotoSegue"]){
    
    //have to pass the user through the navigation controller. Because the actual first destination is the navVC
    UINavigationController *destVC = segue.destinationViewController;
    
    //.view controllers is actually an array of vcs coming off nav. So we want to pass the user to the first VC.
    AddPhotoViewController *actualDestVC =  destVC.viewControllers[0];
    
    actualDestVC.user = self.currentUser;
    NSLog(@"%@", self.currentUser.userName);
  }
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
  
  
}

#pragma Algorithms
-(NSString *)convertTimeInMinutesToString:(int)minutes{
  if (minutes < 1)
  {
    NSString *returnedString = @"Now";
    //NSLog(@"%@ was returned",returnedString);
    return returnedString;
  }
  else if (minutes < 60)
  {
    NSString *returnedString = [NSString stringWithFormat:@"%im ago", minutes];
    //NSLog(@"%@ was returned",returnedString);
    return returnedString;
  }else if (minutes > 60 && minutes < 120)
  {
    int hours = minutes / 60;
    NSString *returnedString = [NSString stringWithFormat:@"%ih ago", hours];
    //NSLog(@"%@ was returned",returnedString);
    return returnedString;
  }
  else if (minutes > 60 && minutes < (60 * 24))
  {
    int hours = minutes / 60;
    NSString *returnedString = [NSString stringWithFormat:@"%ih ago", hours];
    //NSLog(@"%@ was returned",returnedString);
    return returnedString;
  }
  else if (minutes > (60 * 24) && minutes < (60 * 24 * 7))
  {
    int days = minutes / (60 * 24);
    NSString *returnedString = [NSString stringWithFormat:@"%id ago", days];
    //NSLog(@"%@ was returned",returnedString);
    return returnedString;
  }else if (minutes > (60 * 24 * 7) && minutes < (60 * 24 * 14)){
    int weeks = minutes / (60 * 24 * 7);
    NSString *returnedString = [NSString stringWithFormat:@"%iw ago", weeks];
    //NSLog(@"%@ was returned",returnedString);
    return returnedString;
  }
  else if (minutes > (60 * 24 * 7))
  {
    int weeks = minutes / (60 * 24 * 7);
    NSString *returnedString = [NSString stringWithFormat:@"%iw ago", weeks];
    //NSLog(@"%@ was returned",returnedString);
    return returnedString;
  }
  else {
    return nil;
  }

}


// snap cell while scrolling
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    // Determine which table cell the scrolling will stop on.
//    CGFloat cellHeight = 640.0f;
//    NSInteger cellIndex = floor(targetContentOffset->y / cellHeight);
//    
//    // Round to the next cell if the scrolling will stop over halfway to the next cell.
//    if ((targetContentOffset->y - (floor(targetContentOffset->y / cellHeight/3) * cellHeight/3)) > cellHeight/3) {
//        cellIndex++;
//    }
//    
//    // Adjust stopping point to exact beginning of cell.
//    targetContentOffset->y = cellIndex * cellHeight;
//}




@end
