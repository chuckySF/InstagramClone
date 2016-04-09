//
//  GridViewController.m
//  InstagramClone
//
//  Created by Richard Velazquez on 4/7/16.
//  Copyright © 2016 Team4. All rights reserved.
//


#import "GridViewController.h"
#import "GridCollectionViewCell.h"
#import "GridViewFlowLayout.h"

#import "GridZoomViewController.h"

@interface GridViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end

@implementation GridViewController

#pragma View did load/ Appear
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.collectionViewLayout = [[GridViewFlowLayout alloc] init];
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
    [cell.imageView setImage:[UIImage imageNamed:@"chuckTestImage"]];
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //if ([segue.identifier isEqual: @"gridZoomSegue"]) {
    //    GridZoomViewController *gridZoomVC = segue.destinationViewController;
     //   self.definesPresentationContext = YES; //self is presenting view controller
      //  gridZoomVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
       // gridZoomVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
       // [self presentViewController:gridZoomVC animated:NO completion:nil];
    //}
    
    
}


@end
