//
//  AddPhotoViewController.m
//  InstagramClone
//
//  Created by Richard Velazquez on 4/7/16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import "AddPhotoViewController.h"

@interface AddPhotoViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation AddPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect frame= self.segmentedControl.frame;
    [self.segmentedControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 250)];



}



@end
