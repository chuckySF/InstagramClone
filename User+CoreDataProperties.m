//
//  User+CoreDataProperties.m
//  InstagramClone
//
//  Created by Richard Velazquez on 4/7/16.
//  Copyright © 2016 Team4. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

@dynamic userName;
@dynamic userImage;
@dynamic userBio;
@dynamic userLocation;
@dynamic photos;
@dynamic comments;
@dynamic likes;

@end
