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



@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource,PhotoTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property NSMutableArray *photos;
@property NSManagedObjectContext *moc;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property UIImage *zoomImage;
@property Photo *clickedPhoto;
@property User *currentUser;


@end

@implementation HomeViewController


#pragma View load/Appear

-(void)viewWillAppear:(BOOL)animated{
  self.segmentedControl.selectedSegmentIndex = 0;
  
  [self pullPhotosFromCoreData];
  [self.tableView reloadData];
  
  [self.tableView setAllowsSelection:NO];
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
  Photo *tempPhoto = [self.photos objectAtIndex:0];
  self.currentUser = (User *)tempPhoto.user;
  
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
  
  //fetch request
  NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Photo"];
  NSError *error;
  
  NSMutableArray *coreDataArray = [[self.moc executeFetchRequest:request error:&error]mutableCopy];
  
  if (error == nil) {
    NSLog(@"pull was successful");
    
    //sorts the array
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"photoTimestamp" ascending:NO];
    self.photos = [[coreDataArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]]mutableCopy];
    [self.tableView reloadData];
    
  } else {
    NSLog(@"Error: %@", error);
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
  //NSLog(@"the user for this photo is %@", tempUser.userName);
  
  //creating cell
  PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  
  //seting image info
  NSData *imageData = tempPhoto.photoImage;
  cell.photoImageView.image = [UIImage imageWithData:imageData];
  cell.profileImageView.image = [UIImage imageWithData:tempUser.userImage];
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
  
  
  
  
  NSString *likeCount = [NSString stringWithFormat:@"%lu", tempPhoto.likes.count];
  
  
  cell.likeCount.text = likeCount;

  
  [cell.userNameButtonOutlet setTitle:tempUser.userName forState:UIControlStateNormal];
  
  //delegate stuff
  cell.delegate = self;
  
  //Decides which heart appears
  if ([self currentUserHasLikedPicture:tempPhoto]) {
    [cell.heartButton setImage:[UIImage imageNamed:@"Gaming-Hearts-icon-1"] forState:UIControlStateNormal];
    NSLog(@"this image should be the full heart");

  }else {
    [cell.heartButton setImage:[UIImage imageNamed:@"emptyHeart"] forState:UIControlStateNormal];
    NSLog(@"this image should be empty heart");
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


#pragma Segmented Control
- (IBAction)onSegmentedControlPressed:(UISegmentedControl *)sender {
  switch (self.segmentedControl.selectedSegmentIndex) {
    case 0:
    break;
    case 1:
      [self performSegueWithIdentifier:@"gridSegue" sender: nil];

  
      
    default:
      break;
  }
  
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
      for (Like *like in likesSet)
      {
        //finds the like and removes it
        if (like.user == self.currentUser)
        {
        [likedPhoto removeLikesObject:like];
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
    AddPhotoViewController *destVC = segue.destinationViewController;
    
    destVC.user = self.currentUser;
  }
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
  
  
}

#pragma Algorithms 
-(NSString *)convertTimeInMinutesToString:(int)minutes{
  if (minutes < 1)
  {
    NSString *returnedString = @"Less than one minute ago";
    //NSLog(@"%@ was returned",returnedString);
    return returnedString;
  }
  else if (minutes < 60)
  {
    NSString *returnedString = [NSString stringWithFormat:@"%i minutes ago", minutes];
    //NSLog(@"%@ was returned",returnedString);
    return returnedString;
  }else if (minutes > 60 && minutes < 120)
  {
    int hours = minutes / 60;
    NSString *returnedString = [NSString stringWithFormat:@"%i hour ago", hours];
    //NSLog(@"%@ was returned",returnedString);
    return returnedString;
  }
  else if (minutes > 60 && minutes < (60 * 24))
  {
    int hours = minutes / 60;
    NSString *returnedString = [NSString stringWithFormat:@"%i hours ago", hours];
    //NSLog(@"%@ was returned",returnedString);
    return returnedString;
  }
  else if (minutes > (60 * 24) && minutes < (60 * 24 * 7))
  {
    int days = minutes / (60 * 24);
    NSString *returnedString = [NSString stringWithFormat:@"%i days ago", days];
    //NSLog(@"%@ was returned",returnedString);
    return returnedString;
  }else if (minutes > (60 * 24 * 7) && minutes < (60 * 24 * 14)){
    int weeks = minutes / (60 * 24 * 7);
    NSString *returnedString = [NSString stringWithFormat:@"%i week ago", weeks];
    //NSLog(@"%@ was returned",returnedString);
    return returnedString;
  }
  else if (minutes > (60 * 24 * 7))
  {
    int weeks = minutes / (60 * 24 * 7);
    NSString *returnedString = [NSString stringWithFormat:@"%i weeks ago", weeks];
    //NSLog(@"%@ was returned",returnedString);
    return returnedString;
  }
  else {
    return nil;
  }
  
  
}


@end
