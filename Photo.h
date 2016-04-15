//
//  Photo.h
//  InstagramClone
//
//  Created by Richard Velazquez on 4/14/16.
//  Copyright © 2016 Team4. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, Like, User;

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Photo+CoreDataProperties.h"
