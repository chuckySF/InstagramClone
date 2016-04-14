//
//  Photo+CoreDataProperties.h
//  InstagramClone
//
//  Created by James Rochabrun on 13-04-16.
//  Copyright © 2016 Team4. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Photo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Photo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *photoDescription;
@property (nullable, nonatomic, retain) NSData *photoImage;
@property (nullable, nonatomic, retain) NSDate *photoTimestamp;
@property (nullable, nonatomic, retain) NSData *photoVideo;
@property (nullable, nonatomic, retain) NSNumber *photoBool;
@property (nullable, nonatomic, retain) NSSet<Comment *> *comments;
@property (nullable, nonatomic, retain) NSSet<Like *> *likes;
@property (nullable, nonatomic, retain) User *user;

@end

@interface Photo (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet<Comment *> *)values;
- (void)removeComments:(NSSet<Comment *> *)values;

- (void)addLikesObject:(Like *)value;
- (void)removeLikesObject:(Like *)value;
- (void)addLikes:(NSSet<Like *> *)values;
- (void)removeLikes:(NSSet<Like *> *)values;

@end

NS_ASSUME_NONNULL_END
