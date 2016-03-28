//
//  FMNCommunique.h
//  ForgetMeNot
//
//  Created by Marcus Grant on 3/17/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FMNContact.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMNCommunique : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+(instancetype)initWithContext:(NSManagedObjectContext *)context
                      contents:(NSString *)contents
                    dateTimeOf:(NSDate *)dateTimeOf
                          type:(NSString *)type
                      duration:(NSNumber *)duration
                       contact:(id)contact;



@end

NS_ASSUME_NONNULL_END

#import "FMNCommunique+CoreDataProperties.h"
