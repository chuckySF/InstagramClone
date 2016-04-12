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

@end

@implementation AddPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSLog(@"sqlite dir = \n%@", appDelegate.applicationDocumentsDirectory);
    
    self.moc = appDelegate.managedObjectContext;
    
    self.photosArray = [NSMutableArray new];


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
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Camera
//this sets the pickedImage
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.pickedImage = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

//user selects camara
- (IBAction)onCameraButtonPressed:(UIButton *)sender {
    
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}


- (IBAction)dismissCameraActions:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


//I passed the NSDATA Photo to the finalize VC
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:self.moc];
    
    //this is for the attribute value
    NSData *imageData = UIImagePNGRepresentation(self.pickedImage);
    
    photo.photoImage = [NSData dataWithData:imageData];
    
    //sending the object Photo to the Finalize
    FinalizeViewController *destVC = segue.destinationViewController;
    destVC.photo = photo;
    
    //sending a user to stablish a relationship
    destVC.user = self.user;
    

}






















@end












