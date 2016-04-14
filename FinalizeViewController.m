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


@interface FinalizeViewController  () <UITextViewDelegate>
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
    NSData *imagedata = self.photoData;
    
    self.imageView.image = [UIImage imageWithData:imagedata];
    
    self.photos = [[NSMutableArray alloc]init];
    
    self.textView.delegate = self;
    
    self.textView.text = @"Enter a description for the photo";
    self.textView.textColor = [UIColor grayColor];

}


//this action has 2 actions, the exit segue and add the photoin coredata



- (void)viewWillAppear:(BOOL)animated {
    
    //////setup formatting
    self.cancelButton.imageView.clipsToBounds = true;
    self.cancelButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.cancelButton setFrame:CGRectMake(0, 0, 24.0, 24.0)];
    self.doneButton.imageView.clipsToBounds = true;
    self.doneButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.doneButton setFrame:CGRectMake(0, 0, 32.0, 32.0)];
}


- (IBAction)onShareButtonPressed:(UIButton *)sender {
    
    
    if ([self.textView.text isEqualToString:@"Enter a description for the photo"]) {
        self.textView.text = @"";
    }
    
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:self.moc];

    photo.photoDescription = self.textView.text;
    
    photo.photoTimestamp =  [NSDate date];
    
    photo.photoImage = self.photoData;
    
    //setting the relationships
    //adding the picture to the user
    [self.user addPhotosObject:photo];
    
    NSError *error;
    
    if ([self.moc save:&error]){
        [self.photos addObject:photo];
        NSLog(@"%@,  %lu  in the array of photos", photo, self.photos.count);
    }else{
        NSLog(@"an error has occurred,...%@",error);
    }
}


#pragma dismiss view

- (IBAction)cancelSharePhoto:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Enter a description for the photo"]) {
        self.textView.text = @"";
        self.textView.textColor = [UIColor grayColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        self.textView.text = @"Enter a description for the photo";
        self.textView.textColor = [UIColor grayColor];
    }
    [textView resignFirstResponder];
}





@end
