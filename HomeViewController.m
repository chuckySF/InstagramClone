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
#import "GridViewController.h"


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
  
  for (int i = 0; i < 5; i++) {
   
    NSString *photoString = [NSString stringWithFormat:@"image%i", i];
    UIImage *newImage = [UIImage imageNamed:photoString];
    
    
    Photo *newPhoto = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:self.moc];
    newPhoto.photoImage = UIImageJPEGRepresentation(newImage, 1.0);
    newPhoto.photoDescription = [NSString stringWithFormat:@"Image:%i description", i];
    newPhoto.photoTimestamp = nil;
    
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
  
  Photo *tempPhoto = [self.photos objectAtIndex:indexPath.row];
  
  PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  
  NSData *imageData = tempPhoto.photoImage;
  cell.photoImageView.image = [UIImage imageWithData:imageData];
  cell.profileImageView.image = [UIImage imageNamed:@"image2"];
  
  return cell;
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



#pragma Pass photos array in segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"gridSegue"]) {
        
        GridViewController *gridVC = segue.destinationViewController;
        gridVC.photos = self.photos;
        
        
        
    }
    
    
}





@end
