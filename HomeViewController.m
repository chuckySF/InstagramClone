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


@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property NSMutableArray *photos;
@property NSManagedObjectContext *moc;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation HomeViewController


#pragma View load/Appear

-(void)viewWillAppear:(BOOL)animated{
  self.segmentedControl.selectedSegmentIndex = 0;
  
}


- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.moc = appDelegate.managedObjectContext;
  
    [self pullPhotosFromCoreData];
  
    if (self.photos.count == 0) {
      [self createDefaultPhotosAndSaveToCoreData];
    }
  
  [self.collectionView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"Memomry crash");

}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
  
  
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
  NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Photo"];
  
  NSError *error;
  self.photos = [[self.moc executeFetchRequest:request error:&error]mutableCopy];
  
  if (error == nil) {
    NSLog(@"pull was successful");
  } else {
    NSLog(@"Error: %@", error);
  }
  
  
}


#pragma Table View
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
  
 //date code
  float timeSincePosting = [tempPhoto.photoTimestamp timeIntervalSinceNow] * -1;
  float timeSincePostingInMinutes = timeSincePosting/60;
  int minsInt = timeSincePostingInMinutes / 1;
  cell.datePosted.text = [self convertTimeInMinutesToString:minsInt];
  
  NSLog(@"%i",minsInt);
  
  
  
  NSString *likeCount = [NSString stringWithFormat:@"%lu", tempPhoto.likes.count];
  
  
  cell.likeCount.text = likeCount;

  
  [cell.userNameButtonOutlet setTitle:tempUser.userName forState:UIControlStateNormal];
  
  return cell;
}

-(NSString *)convertTimeInMinutesToString:(int)minutes{
  if (minutes < 1)
  {
    NSString *returnedString = @"Less than one minute ago";
    NSLog(@"%@ was returned",returnedString);
    return returnedString;
  }
  else if (minutes < 60)
  {
    NSString *returnedString = [NSString stringWithFormat:@"%i minutes ago", minutes];
    NSLog(@"%@ was returned",returnedString);
    return returnedString;
  }
  else if (minutes > 60 && minutes < (60 * 24))
  {
    int hours = minutes / 60;
    NSString *returnedString = [NSString stringWithFormat:@"%i hours ago", hours];
    NSLog(@"%@ was returned",returnedString);
    return returnedString;
  }
  else if (minutes > (60 * 24) && minutes < (60 * 24 * 7))
  {
    int days = minutes / (60 * 24);
    NSString *returnedString = [NSString stringWithFormat:@"%i days ago", days];
    NSLog(@"%@ was returned",returnedString);
    return returnedString;
  }
  else if (minutes > (60 * 24 * 7))
  {
    int weeks = minutes / (60 * 24 * 7);
    NSString *returnedString = [NSString stringWithFormat:@"%i weeks ago", weeks];
    NSLog(@"%@ was returned",returnedString);
    return returnedString;
  }
  else {
    return nil;
  }
  
  
}


#pragma Segmented Controll
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





@end
