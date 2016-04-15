//
//  TestViewController.m
//  InstagramClone
//
//  Created by Richard Velazquez on 4/14/16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import "TestViewController.h"
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
#import "NewTextView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>
#import "videoCellTableViewCell.h"

@interface TestViewController ()<UITableViewDelegate, UITableViewDataSource>

@property NSMutableArray *photos;
@property NSManagedObjectContext *moc;
@property (strong, nonatomic) MPMoviePlayerController *videoController;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  self.moc = appDelegate.managedObjectContext;
  
  [self pullPhotosFromCoreData];

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
  
  
  [self.tableView reloadData];
  
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
 return 1;
  
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  videoCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  
 // Photo *tempPhoto = [self.photos objectAtIndex:indexPath.row];
  
 // NSLog(@"%@:%@",tempPhoto.photoDescription, tempPhoto.photoVideo);
  
  
//  NSURL *url = [NSURL fileURLWithPath:@"InstagramClone/var/mobile/Containers/Data/Application/C517B9B4-C525-437D-B258-403191DFFC4F/Documents/vid1.mp4"];
 
  
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"/var/mobile/Containers/Data/Application/34E0D17E-5F7C-4B13-936D-9D551C60E9CD/Documents/vid1" ofType:@"mp4"];
  
  NSFileManager *fileManager = [NSFileManager defaultManager];
  //Get documents directory
  NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains
  (NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectoryPath = [directoryPaths objectAtIndex:0];
  if ([fileManager fileExistsAtPath:@""]==YES) {
    NSLog(@"File exists");
  }
  
  NSLog(@"%@", filePath);
  
  NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
  
  cell.movie = [[MPMoviePlayerController alloc]initWithContentURL:fileUrl];
  
  [cell.movie play];
  
  return cell;
 
  
  
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
