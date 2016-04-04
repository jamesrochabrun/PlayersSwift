//
//  Person+CoreDataProperties.h
//  PlayersSwift
//
//  Created by James Rochabrun on 03-04-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *picture;
@property (nullable, nonatomic, retain) NSNumber *selected;
@property (nullable, nonatomic, retain) NSString *skill;

@end

NS_ASSUME_NONNULL_END
