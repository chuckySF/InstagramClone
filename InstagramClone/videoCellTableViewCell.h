//
//  videoCellTableViewCell.h
//  InstagramClone
//
//  Created by James Rochabrun on 14-04-16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "videoCellTableViewCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>

@interface videoCellTableViewCell : UITableViewCell

@property (strong, nonatomic) MPMoviePlayerController *movie;

@end
