//
//  User+CoreDataProperties.h
//  InstagramClone
//
//  Created by Richard Velazquez on 4/7/16.
//  Copyright © 2016 Team4. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"
@class Photo;

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *userName;
@property (nullable, nonatomic, retain) NSData *userImage;
@property (nullable, nonatomic, retain) NSString *userBio;
@property (nullable, nonatomic, retain) id userLocation;
@property (nullable, nonatomic, retain) NSSet<Photo *> *photos;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *comments;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *likes;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet<Photo *> *)values;
- (void)removePhotos:(NSSet<Photo *> *)values;

- (void)addCommentsObject:(NSManagedObject *)value;
- (void)removeCommentsObject:(NSManagedObject *)value;
- (void)addComments:(NSSet<NSManagedObject *> *)values;
- (void)removeComments:(NSSet<NSManagedObject *> *)values;

- (void)addLikesObject:(NSManagedObject *)value;
- (void)removeLikesObject:(NSManagedObject *)value;
- (void)addLikes:(NSSet<NSManagedObject *> *)values;
- (void)removeLikes:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
