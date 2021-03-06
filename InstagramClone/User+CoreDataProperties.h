//
//  User+CoreDataProperties.h
//  InstagramClone
//
//  Created by James Rochabrun on 13-04-16.
//  Copyright © 2016 Team4. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *userBio;
@property (nullable, nonatomic, retain) NSData *userImage;
@property (nullable, nonatomic, retain) id userLocation;
@property (nullable, nonatomic, retain) NSString *userName;
@property (nullable, nonatomic, retain) NSSet<Comment *> *comments;
@property (nullable, nonatomic, retain) NSSet<Like *> *likes;
@property (nullable, nonatomic, retain) NSSet<Photo *> *photos;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *videos;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet<Comment *> *)values;
- (void)removeComments:(NSSet<Comment *> *)values;

- (void)addLikesObject:(Like *)value;
- (void)removeLikesObject:(Like *)value;
- (void)addLikes:(NSSet<Like *> *)values;
- (void)removeLikes:(NSSet<Like *> *)values;

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet<Photo *> *)values;
- (void)removePhotos:(NSSet<Photo *> *)values;

- (void)addVideosObject:(NSManagedObject *)value;
- (void)removeVideosObject:(NSManagedObject *)value;
- (void)addVideos:(NSSet<NSManagedObject *> *)values;
- (void)removeVideos:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
