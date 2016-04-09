//
//  GridViewController.m
//  InstagramClone
//
//  Created by Richard Velazquez on 4/7/16.
//  Copyright © 2016 Team4. All rights reserved.
//

// I'm going to start making changess

#import "GridViewController.h"

@interface GridViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;


@end

@implementation GridViewController


#pragma View did load/ Appear
-(void)viewWillAppear:(BOOL)animated{
  [self.navigationItem setHidesBackButton:true];
  self.segmentedControl.selectedSegmentIndex = 1;

}

- (void)viewDidLoad {
    [super viewDidLoad];
  

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Segmented Control
- (IBAction)onSegmentedControlPressed:(UISegmentedControl *)sender {
  
  switch (self.segmentedControl.selectedSegmentIndex) {
    case 0:

      [self.navigationController popViewControllerAnimated:false];
      
    case 1:
     break;
      
      
    default:
      break;
  }
  
  
}

#pragma CollectionView

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gridCell" forIndexPath:indexPath];
  
  return cell;
  
  
}

@end
