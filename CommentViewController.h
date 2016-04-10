//
//  CommentViewController.h
//  InstagramClone
//
//  Created by Richard Velazquez on 4/7/16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
#import "User.h"

@interface CommentViewController : UIViewController
@property Photo *photo;
@property User *user;
@property (weak, nonatomic) IBOutlet UITableView *scrollView;


@end
