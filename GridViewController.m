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



@end

@implementation GridViewController

#pragma View did load/ Appear
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.collectionViewLayout = [[GridCollectionViewFlowLayout alloc] init];
    
    
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