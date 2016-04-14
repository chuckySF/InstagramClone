//
//  AddPhotoViewController.m
//  InstagramClone
//
//  Created by Richard Velazquez on 4/7/16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import "AddPhotoViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "Comment.h"
#import "Photo.h"
#import "FinalizeViewController.h"

@interface AddPhotoViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIImage *pickedImage;
@property NSManagedObjectContext *moc;
@property NSMutableArray *photosArray;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *libraryButton;
@property (weak, nonatomic) IBOutlet UIButton *videoButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end





@implementation AddPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSLog(@"sqlite dir = \n%@", appDelegate.applicationDocumentsDirectory);
    
    self.moc = appDelegate.managedObjectContext;
    
    self.photosArray = [NSMutableArray new];
    
    ////formatting
    [self.cameraButton setHighlighted:true];
    [self.libraryButton setHighlighted:true];
    [self.videoButton setHighlighted:true];
    self.videoButton.userInteractionEnabled = false;

}


- (void)viewWillAppear:(BOOL)animated {
    
    //////formatting
    //remove back button text
    //[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, 50.f) forBarMetrics:UIBarMetricsDefault];
    //setup formatting
    UIColor *instaGray = [UIColor colorWithRed:(45/255.0) green:(45/255.0) blue:(45/255.0) alpha:1];
    self.navigationController.navigationBar.barTintColor = instaGray;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"Gotham Narrow" size:18]};
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    [[UINavigationBar appearance] setTitleTextAttributes: @{NSFontAttributeName: [UIFont fontWithName:@"Gotham Medium" size:18.0f]}];

    
    
    //////setup formatting
    self.cancelButton.imageView.clipsToBounds = true;
    self.cancelButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.cancelButton setFrame:CGRectMake(0, 0, 24.0, 24.0)];
//    self.doneButton.imageView.clipsToBounds = true;
//    self.doneButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [self.doneButton setFrame:CGRectMake(0, 0, 24.0, 24.0)];
    
    
    //disable Next button if imageView is nil
    if (self.pickedImage == nil) {
        self.nextButton.userInteractionEnabled = false;
        self.nextButton.highlighted = true;
    } else {
        self.nextButton.userInteractionEnabled = true;
        self.nextButton.highlighted = false;
        [self.nextButton setBackgroundColor:[UIColor colorWithRed:109/255.0 green:201/255.0 blue:147/255.0 alpha:1.0]];
        
        
        self.nextButton.layer.cornerRadius = 3; // this value vary as per your desire
        self.nextButton.clipsToBounds = YES;

        [self.nextButton setTitleColor:[UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:1.0] forState:UIControlStateNormal];
        
    }


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//this cancels the action (the cancel in the top right provided by apple)
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//this sets the pickedImage  in to the view
-(void)setPickedImage:(UIImage *)pickedImage
{
    _pickedImage = pickedImage;
    
    //here is where you can set the picked image
    [self.imageView setImage:pickedImage];
    
}

//user selects library
- (IBAction)onLibraryPressedButton:(UIButton *)sender {
    
    [self.cameraButton setHighlighted:true];
    [self.libraryButton setHighlighted:false];
    [self.videoButton setHighlighted:true];
    
    
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
    
    
    
}

//user selects camara
- (IBAction)onCameraButtonPressed:(UIButton *)sender {
    
    
    [self.cameraButton setHighlighted:false];
    [self.libraryButton setHighlighted:true];
    [self.videoButton setHighlighted:true];
    
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
    
    
}



- (IBAction)dismissCameraActions:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma Camera
//this sets the pickedImage
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //here we return a photo croped and rotated from the camera    
    image = [self squareImageWithImage:image scaledToSize:CGSizeMake(300,1)];
    
    self.pickedImage = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma fixing orientation of photo and scale
- (UIImage *)squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    double ratio;
    double delta;
    CGPoint offset;
    
    //make a new square size, that is the resized imaged width
    CGSize sz = CGSizeMake(newSize.width, newSize.width);
    
    //figure out if the picture is landscape or portrait, then
    //calculate scale factor and offset
    if (image.size.width > image.size.height) {
        ratio = newSize.width / image.size.width;
        delta = (ratio*image.size.width - ratio*image.size.height);
        offset = CGPointMake(delta/2, 0);
    } else {
        ratio = newSize.width / image.size.height;
        delta = (ratio*image.size.height - ratio*image.size.width);
        offset = CGPointMake(0, delta/2);
    }
    
    //make the final clipping rect based on the calculated values
    CGRect clipRect = CGRectMake(-offset.x, -offset.y,
                                 (ratio * image.size.width) + delta,
                                 (ratio * image.size.height) + delta);
    
    
    //start a new context, with scale factor 0.0 so retina displays get
    //high quality image
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(sz, YES, 0.0);
    } else {
        UIGraphicsBeginImageContext(sz);
    }
    UIRectClip(clipRect);
    [image drawInRect:clipRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma finally passing the Photo object and a User to stablish relationship

//I passed the NSDATA Photo to the finalize VC
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    //here we pass the image as nsdata
    NSData *imageData = UIImagePNGRepresentation(self.pickedImage);
    
    
    //sending the object Photo to the Finalize
    FinalizeViewController *destVC = segue.destinationViewController;
    
    destVC.photoData = imageData;
    
    //sending a user to stablish a relationship
    destVC.user = self.user;
    
    NSLog(@"%@", self.user.userName);
    
}























@end












