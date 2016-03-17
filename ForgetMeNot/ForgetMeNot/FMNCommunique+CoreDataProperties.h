//
//  FMNCommunique+CoreDataProperties.h
//  ForgetMeNot
//
//  Created by Marcus Grant on 3/14/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FMNCommunique.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMNCommunique (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *contents;
@property (nullable, nonatomic, retain) NSDate *dateTimeOf;
@property (nullable, nonatomic, retain) NSNumber *duration;
@property (nullable, nonatomic, retain) NSString *type;

@end

NS_ASSUME_NONNULL_END
