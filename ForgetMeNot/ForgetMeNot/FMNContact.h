//
//  FMNContact.h
//  ForgetMeNot
//
//  Created by Marcus Grant on 3/17/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//

//TODO: Add reminders as set of structs or set of reminder classes
//TODO: Add FB info
//TODO: Add Twit info
//TODO: Change email to be transformable for set of emails
//TODO: Make a setter for uID that checks the context for uID collisions
//TODO: Add helper function to properly format phone number string
//TODO: Add helper function to return a phone number string with regional formatting
//TODO: Add function that can evaluate the validity of numbers in a phonenum by region

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FMNCommunique;

NS_ASSUME_NONNULL_BEGIN

@interface FMNContact : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+(instancetype)initWithContext:(NSManagedObjectContext *)   context
                     firstName:(NSString *)                 firstName
                      lastName:(NSString *)                 lastName
                   phoneNumber:(id)                         phoneNumber
                         eMail:(id)                         eMail
                      birthday:(NSDate *)                   birthday
                 activityScore:(NSNumber *)                 activityScore
                           uID:(NSNumber *)                 uID
                   communiques:(NSOrderedSet *)             communiques;

#pragma mark - Helper Functions
+(NSString *)convertToPhoneNumberString:(id) phoneNum;
+(NSString *)formatPhoneString:(NSString *) phoneString;





@end

NS_ASSUME_NONNULL_END

#import "FMNContact+CoreDataProperties.h"
