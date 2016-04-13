//
//  GridViewController.m
//  InstagramClone
//
//  Created by Richard Velazquez on 4/7/16.
//  Copyright © 2016 Team4. All rights reserved.
//


#import "GridViewController.h"
#import "GridCollectionViewCell.h"
#import "GridCollectionViewFlowLayout.h"
#import "Photo.h"
#import "AddPhotoViewController.h"

#import "ZoomImageViewController.h"



@interface GridViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIButton *gridButton;
@property (weak, nonatomic) IBOutlet UIButton *listButton;

@property UIImage *zoomImage;

@end

@implementation GridViewController

#pragma View did load/ Appear
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.collectionViewLayout = [[GridCollectionViewFlowLayout alloc] init];
    NSLog(@"%lu",(unsigned long)self.photos.count);
    
    
    
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

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setHidesBackButton:true];
    self.segmentedControl.selectedSegmentIndex = 1;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"Billabong" size:30]};

    
    self.gridButton.highlighted = false;
    self.listButton.highlighted = true;
}


#pragma Segmented Control
- (IBAction)onSegmentedControlPressed:(UISegmentedControl *)sender {
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            [self.navigationController popViewControllerAnimated:false];
            break;
        case 1:
            break;
        default:
            break;
    }
}

#pragma CollectionView

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photos.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GridCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gridCell" forIndexPath:indexPath];
    UIImage *photoImage = [UIImage imageWithData:[[self.photos objectAtIndex:indexPath.row] photoImage]];
    [cell.imageView setImage:photoImage];
    

    
    return cell;
}


#pragma Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  
  if ([segue.identifier isEqualToString:@"gridToAddPhotoSegue"])
    
  {
  
  UINavigationController *destVC = segue.destinationViewController;
  
  AddPhotoViewController *actualDestVC =  destVC.viewControllers[0];
  
  actualDestVC.user = self.user;
  NSLog(@"%@", self.user.userName);
    
  } else if ([segue.identifier isEqualToString:@"zoomSegue"]){
      
      ZoomImageViewController *destVC = segue.destinationViewController;
      destVC.passedImage = self.zoomImage;
      
  }

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Photo *zommedPhoto = [self.photos objectAtIndex:indexPath.row];

    NSData *imageData = zommedPhoto.photoImage;

    self.zoomImage = [UIImage imageWithData:imageData];
    
    [self performSegueWithIdentifier:@"zoomSegue" sender:nil];
    
}

@end