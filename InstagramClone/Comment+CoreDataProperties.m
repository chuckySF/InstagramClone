//
//  Comment+CoreDataProperties.m
//  InstagramClone
//
//  Created by James Rochabrun on 13-04-16.
//  Copyright © 2016 Team4. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Comment+CoreDataProperties.h"

@implementation Comment (CoreDataProperties)

@dynamic commentText;
@dynamic commentTimestamp;
@dynamic photo;
@dynamic user;
@dynamic video;

@end
