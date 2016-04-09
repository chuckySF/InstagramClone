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
    return 100;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GridCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gridCell" forIndexPath:indexPath];
    [cell.imageView setImage:[UIImage imageNamed:@"image1"]];
    
    //cell.imageView.center = CGPointMake(cell.contentView.bounds.size.width/2, cell.contentView.bounds.size.height/2);
    

    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


@end