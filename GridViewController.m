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


@interface GridViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIButton *gridButton;
@property (weak, nonatomic) IBOutlet UIButton *listButton;


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


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


@end