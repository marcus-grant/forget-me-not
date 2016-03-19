//
//  FMNContact+CoreDataProperties.h
//  ForgetMeNot
//
//  Created by Marcus Grant on 3/18/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FMNContact.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMNContact (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *activityScore;
@property (nullable, nonatomic, retain) NSDate *birthday;
@property (nullable, nonatomic, retain) id eMail;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) id phoneNumber;
@property (nullable, nonatomic, retain) NSNumber *uID;
@property (nullable, nonatomic, retain) NSOrderedSet<FMNCommunique *> *communiques;

@end

@interface FMNContact (CoreDataGeneratedAccessors)

- (void)insertObject:(FMNCommunique *)value inCommuniquesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCommuniquesAtIndex:(NSUInteger)idx;
- (void)insertCommuniques:(NSArray<FMNCommunique *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCommuniquesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCommuniquesAtIndex:(NSUInteger)idx withObject:(FMNCommunique *)value;
- (void)replaceCommuniquesAtIndexes:(NSIndexSet *)indexes withCommuniques:(NSArray<FMNCommunique *> *)values;
- (void)addCommuniquesObject:(FMNCommunique *)value;
- (void)removeCommuniquesObject:(FMNCommunique *)value;
- (void)addCommuniques:(NSOrderedSet<FMNCommunique *> *)values;
- (void)removeCommuniques:(NSOrderedSet<FMNCommunique *> *)values;

@end

NS_ASSUME_NONNULL_END
