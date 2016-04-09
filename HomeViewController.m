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

@interface HomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation HomeViewController


#pragma View load/Appear

-(void)viewWillAppear:(BOOL)animated{
  self.segmentedControl.selectedSegmentIndex = 0;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"Memomry crash");

}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
  
  
}

#pragma Collection View
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return 10;
  
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell" forIndexPath:indexPath];
  
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
