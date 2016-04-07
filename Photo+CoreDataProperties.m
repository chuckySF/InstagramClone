//
//  Photo+CoreDataProperties.m
//  InstagramClone
//
//  Created by Richard Velazquez on 4/7/16.
//  Copyright © 2016 Team4. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Photo+CoreDataProperties.h"

@implementation Photo (CoreDataProperties)

@dynamic photoTimestamp;
@dynamic photoImage;
@dynamic photoDescription;
@dynamic user;
@dynamic likes;
@dynamic comments;

@end
