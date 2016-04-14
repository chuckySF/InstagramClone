//
//  FinalizeViewController.m
//  InstagramClone
//
//  Created by Richard Velazquez on 4/7/16.
//  Copyright © 2016 Team4. All rights reserved.
//


#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>

#import "FinalizeViewController.h"
#import "User.h"
#import "Photo.h"
#import "Comment.h"
#import "AppDelegate.h"
#import "videoCellTableViewCell.h"


@interface FinalizeViewController ()
@property NSManagedObjectContext *moc;
@property NSMutableArray *photos;
@property NSMutableArray *videos;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) MPMoviePlayerController *videoController;


@end

@implementation FinalizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSLog(@"sqlite dir = \n%@", appDelegate.applicationDocumentsDirectory);
    
    NSLog(@"MY NAME IS %@ and i am checking that i was correctly passed to this view",   self.user.userName);
    
    self.moc = appDelegate.managedObjectContext;
    
    self.photos = [[NSMutableArray alloc]init];

    //displaying the image in the finalize VC
    NSData *imagedata = self.photoData;
    
    
    //if a image was passed
    if(self.photoData){
        self.imageView.hidden = NO;
        self.imageView.image = [UIImage imageWithData:imagedata];
    }
    else{ //if a video URL was passed
        self.imageView.hidden = YES;

        //display the video in the top corner left
        self.videoController = [[MPMoviePlayerController alloc] init];
        [self.videoController setContentURL:self.videoURL];
        [self.videoController.view setFrame:CGRectMake (0, 0, 150, 150)];
        [self.view addSubview:self.videoController.view];
        
//        self.videoController.view.frame.size.height
        
        [self.videoController play];
        
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    //////setup formatting
    self.cancelButton.imageView.clipsToBounds = true;
    self.cancelButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.cancelButton setFrame:CGRectMake(0, 0, 24.0, 24.0)];
    self.doneButton.imageView.clipsToBounds = true;
    self.doneButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.doneButton setFrame:CGRectMake(0, 0, 24.0, 24.0)];
}


//this action has 2 actions, the exit segue and add the photoin coredata

- (IBAction)onShareButtonPressed:(UIButton *)sender {
    
    
    
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:self.moc];
    
    photo.photoDescription = self.textView.text;
    
    photo.photoTimestamp =  [NSDate date];
    
    photo.photoImage = self.photoData;
    
    NSData *currentVideo = [NSData dataWithContentsOfURL: self.videoURL];
    
    photo.photoVideo = currentVideo;
    
    NSLog(@"this in the nsdata %@", currentVideo);
    
    //add the photo to the user
    [self.user addPhotosObject:photo];
    
    //save the photo in coreData
    NSError *error;
    
    if ([self.moc save:&error]){
    }else{
        NSLog(@"an error has occurred,...%@",error);
    }
}


#pragma dismiss view

- (IBAction)cancelSharePhoto:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma share actions

- (IBAction)shareButtonPressed:(UIButton *)sender {
    
    // disable the button so the user cant touch it twice
    [[self shareButton] setEnabled:NO];
    
    // here we need to put the photo.photodescription
    NSString *shareText = [NSString stringWithFormat:@"hello" ];

    
    // define the picture to be shared
    UIImage *image = [UIImage imageWithData:self.photoData];
    
    UIImage *shareImage = image;
    
    //present activity Items
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[shareText,
                                                              shareImage]
                                      applicationActivities:nil];
    
    
    //how the actions pannel will be presented
    [activityViewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    //actions that we dont want to present in the actions pannel
    [activityViewController setExcludedActivityTypes:@[UIActivityTypePostToWeibo,
                                                       UIActivityTypeCopyToPasteboard,
                                                       UIActivityTypeMessage]];
    
    [self presentViewController:activityViewController animated:YES completion:^{
        [[self shareButton] setEnabled:YES];
    }];
    
    
}














@end
