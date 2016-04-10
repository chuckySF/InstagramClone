//
//  ZoomImageViewController.m
//  InstagramClone
//
//  Created by Richard Velazquez on 4/10/16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import "ZoomImageViewController.h"

@interface ZoomImageViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation ZoomImageViewController

- (void)viewDidLoad {
  
    [super viewDidLoad];
    self.imageView.image = self.passedImage;
  
     self.scrollView.minimumZoomScale=1.0;
     self.scrollView.maximumZoomScale=5.0;
    [self.scrollView setClipsToBounds:TRUE];
  
  
    self.scrollView.delegate=self;


}


#pragma actions
- (IBAction)onDismissButtonPressed:(UIBarButtonItem *)sender {
  
    [self dismissViewControllerAnimated:YES completion:nil];
  
}

#pragma scroll delegate methods
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)aScrollView {
  return self.imageView;
}







@end
