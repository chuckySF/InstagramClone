//
//  FinalizeViewController.m
//  InstagramClone
//
//  Created by Richard Velazquez on 4/7/16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import "FinalizeViewController.h"
#import "User.h"
#import "Photo.h"
#import "Comment.h"
#import "AppDelegate.h"


@interface FinalizeViewController ()
@property NSManagedObjectContext *moc;
@property NSMutableArray *photos;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;


@end

@implementation FinalizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSLog(@"sqlite dir = \n%@", appDelegate.applicationDocumentsDirectory);
    
    NSLog(@"MY NAME IS %@ and i am checking that i was correctly passed to this view",   self.user.userName);
    
    self.moc = appDelegate.managedObjectContext;
    
    //displaying the image in the finalize VC
    NSData *imagedata = self.photo.photoImage;
    
    self.imageView.image = [UIImage imageWithData:imagedata];
    
    self.photos = [[NSMutableArray alloc]init];
}

//this action has 2 actions, the exit segue and add the photoin coredata



- (void)viewWillAppear:(BOOL)animated {
    
    //////setup formatting
    self.cancelButton.imageView.clipsToBounds = true;
    self.cancelButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.cancelButton setFrame:CGRectMake(0, 0, 24.0, 24.0)];
    self.doneButton.imageView.clipsToBounds = true;
    self.doneButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.doneButton setFrame:CGRectMake(0, 0, 24.0, 24.0)];
}


- (IBAction)onShareButtonPressed:(UIButton *)sender {
    self.photo.photoDescription = self.textView.text;
    
    self.photo.photoTimestamp =  [NSDate date];
    
    //setting the relationships
    //adding the picture to the user
    [self.user addPhotosObject:self.photo];
    
    
    NSError *error;
    
    if ([self.moc save:&error]){
        [self.photos addObject:self.photo];
        NSLog(@"%@,  %lu  in the array of photos", self.photo, self.photos.count);
    }else{
        NSLog(@"an error has occurred,...%@",error);
    }
}


#pragma dismiss view

- (IBAction)cancelSharePhoto:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma resign keyboard








@end
