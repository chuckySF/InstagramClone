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
#import "PhotoCollectionViewCell.h"

@interface HomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
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


#pragma Collection View
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return self.photos.count;
  
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
  Photo *tempPhoto = [self.photos objectAtIndex:indexPath.row];

  
  PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell" forIndexPath:indexPath];
  NSData *imageData = tempPhoto.photoImage;
  cell.imageView.image = [UIImage imageWithData:imageData];
  
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





@end
