//
//  Photo+CoreDataProperties.h
//  InstagramClone
//
//  Created by Richard Velazquez on 4/7/16.
//  Copyright © 2016 Team4. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Photo.h"
@class User;

NS_ASSUME_NONNULL_BEGIN

@interface Photo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *photoTimestamp;
@property (nullable, nonatomic, retain) NSData *photoImage;
@property (nullable, nonatomic, retain) NSString *photoDescription;
@property (nullable, nonatomic, retain) NSManagedObject *user;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *likes;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *comments;

@end

@interface Photo (CoreDataGeneratedAccessors)

- (void)addLikesObject:(NSManagedObject *)value;
- (void)removeLikesObject:(NSManagedObject *)value;
- (void)addLikes:(NSSet<NSManagedObject *> *)values;
- (void)removeLikes:(NSSet<NSManagedObject *> *)values;

- (void)addCommentsObject:(NSManagedObject *)value;
- (void)removeCommentsObject:(NSManagedObject *)value;
- (void)addComments:(NSSet<NSManagedObject *> *)values;
- (void)removeComments:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
