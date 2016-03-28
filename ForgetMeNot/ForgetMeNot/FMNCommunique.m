//
//  FMNCommunique.m
//  ForgetMeNot
//
//  Created by Marcus Grant on 3/17/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//

#import "FMNCommunique.h"

@implementation FMNCommunique

// Insert code here to add functionality to your managed object subclass

+(instancetype)initWithContext:(NSManagedObjectContext *)context
                      contents:(NSString *)contents
                    dateTimeOf:(NSDate *)dateTimeOf
                          type:(NSString *)type
                      duration:(NSNumber *)duration
                       contact:(id)contact
{
    FMNCommunique *newComm;
    newComm = [NSEntityDescription insertNewObjectForEntityForName:@"FMNCommunique"
                                            inManagedObjectContext:context];
    newComm.contents    = contents;
    newComm.dateTimeOf  = dateTimeOf;
    newComm.type        = type;
    newComm.duration    = duration;


    //Throw error and abort if id isn't of type FMNContact
    //TODO: Eventually all this needs to be handled explicitly in external
    NSDictionary *invalidRelationTypeDict;
    invalidRelationTypeDict = @{
                                NSLocalizedDescriptionKey:
                    NSLocalizedString(@"Invalid relational reference",nil),
                                NSLocalizedFailureReasonErrorKey:
                    NSLocalizedString(@"contact property not FMNContact type",nil),
                                NSLocalizedRecoverySuggestionErrorKey:
                                    NSLocalizedString(@"Check that FMNCommunique is init'd with a contact of type FMNContact", nil)};
    NSError *invalidRelationTypeErr = [NSError errorWithDomain:@"FMNCommunique"
                                                          code:4
                                                userInfo:invalidRelationTypeDict];
    if (![contact isKindOfClass:[FMNContact class]])
    {
        NSLog(@"Critical error %@, %@!", invalidRelationTypeErr,
              [invalidRelationTypeErr userInfo]);
    }
    else
    {
        newComm.contact = contact;
    }

    return [newComm copy];

}
@end
