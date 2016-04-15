//
//  Like+CoreDataProperties.h
//  InstagramClone
//
//  Created by Richard Velazquez on 4/14/16.
//  Copyright © 2016 Team4. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Like.h"

NS_ASSUME_NONNULL_BEGIN

@interface Like (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *likeTimestamp;
@property (nullable, nonatomic, retain) Photo *photo;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
