//
//  FMNContact.m
//  ForgetMeNot
//
//  Created by Marcus Grant on 3/17/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//  Ported from MyContacts project
//

#import "FMNContact.h"
#import "FMNCommunique.h"

@implementation FMNContact

// Insert code here to add functionality to your managed object subclass

#pragma mark - class inits


+(instancetype)initWithContext:(NSManagedObjectContext *)context
                     firstName:(NSString *)firstName
                      lastName:(NSString *)lastName
                   phoneNumber:(id)phoneNumber
                         eMail:(id)eMail
                      birthday:(NSDate *)birthday
                 activityScore:(NSNumber *)activityScore
                           uID:(NSNumber *)uID
                   communiques:(NSOrderedSet *)communiques
{
    // This is the most explicit init, from which all other inits will call upon.
    // First we create a new FMNContact instance, that we modify with the initializer --
    //     properties that are passed through as arguments. This is done by asking the --
    //     context for an instance of the contact class within the context.
    // These properties are then passed to this entityDescription "NewContact" within --
    //     the context, and then passed back as an instance of FMNContacts
    FMNContact *newContact;
    newContact = [NSEntityDescription insertNewObjectForEntityForName:@"FMNContact"
                                               inManagedObjectContext:context];
    newContact.firstName    = firstName;
    newContact.lastName     = lastName;
    newContact.phoneNumber  = [FMNContact getValidatedPhoneNumberWith:phoneNumber];
    newContact.eMail        = [FMNContact getValidatedEMailWith:eMail];
    newContact.birthday     = birthday;
    newContact.activityScore = activityScore;
    newContact.uID          = [FMNContact getValidatedIDWith:uID
                                          fromManagedContext:context];//TODO: implement
    newContact.communiques  = communiques;//TODO: assumed validate by communique inits
#warning remove this after testing git branch update




}

//TODO: Add implementations for different types for entering phone numbers
//TODO: Add cases with and without the country code
// Helper function that handles any basic type to convert them into a properly --
//     formatted string. Phone Numbers are stored as an array of strings. Formatted as --
//     "+<country-code><number with no added formatting>
+(NSString *)convertToPhoneNumberString:(id) phoneNum
{

    if ([phoneNum isKindOfClass:[NSNumber class]])
    {
        //TODO: Make sure this works
        NSString *returnString;
        returnString = [FMNContact formatPhoneString:
                        [NSString stringWithFormat:@"%@",(NSNumber *)phoneNum]];
        return returnString;

    }
    else if ([phoneNum isKindOfClass:[NSString class]])
    {
        return [FMNContact formatPhoneString:(NSString *) phoneNum];
    }
    return @"Error";
}


+(NSString *)formatPhoneString:(NSString *)phoneString
{
    //TODO: Add formatting options based on region
    // Helper function that takes any string with phone number and formats it properly
    // i.e. +1234567890
    // This is done by definig the legal chars for the string (numbers and '+'), then --
    //   taking the inverse of that set to trim the illegal characters from "phoneString".
    NSCharacterSet *validChars, *charsToTrim;
    validChars = [NSCharacterSet characterSetWithCharactersInString:@"+(-)123456790"];
    charsToTrim = [validChars invertedSet];
    return [phoneString stringByTrimmingCharactersInSet:charsToTrim];
}

#pragma mark - class property validators

+(NSArray *)getValidatedPhoneNumberWith:(id)phoneNumber
{
    // validate that the given reference is an array of strings using helper func
#warning this needs implementation and comments
}

+(NSArray *)getValidatedEMailWith:(id)eMail
{
    // validate that the given reference is an array of strings using helper func
#warning still needs comments and implementation
}
//Generic Helper func for validating array of string properties
+(NSArray *)getValidatedArrayOfStringFrom:(id)unkownReference
{
    // Handle the two different types of given property values:
    //     1. String, it will be added as the first and only string in an array
    //     2. Array, check that all elements are strings, then give array reference
    //     3. This should never happen, throw an error (and abort?)


    //Type mismatch error definition for phoneNumbers
    //TODO: Figure out how to encapsulate error handling with unique error enums
    NSDictionary *invalidPropTypeErrDict;
    invalidPropTypeErrDict = @{
                  NSLocalizedDescriptionKey:
                      NSLocalizedString(@"Invalid Type Exception", nil),
                  NSLocalizedFailureReasonErrorKey:
                      NSLocalizedString(@"PhoneNumber is only array of string", nil),
                  NSLocalizedRecoverySuggestionErrorKey:
                      NSLocalizedString(@"Check FMNContact inits or setter", nil)
                  };
    NSError *invalidPropertyTypeError;
    invalidPropertyTypeError = [NSError errorWithDomain:@"FMNContact"
                                                    code:1
                                                userInfo:invalidPropTypeErrDict];

    // if array is given, check that all elements are strings, else give error & abort
    if ([unkownReference isKindOfClass:[NSArray class]])
    {
        //check that only strings are contained
        NSArray *unknownArray = (NSArray *)unkownReference;
        for (NSObject *currentObject in unknownArray)
        {
            //if an array item isn't a string, throw error type 1 and abort
            if ( ![currentObject isKindOfClass:[NSString class]] )
            {
                NSLog(@"Critical Error %@, %@", invalidPropertyTypeError,
                      [invalidPropertyTypeError userInfo]);
                abort();//TODO: Handle explicitly for external classes using this class
            }
        }
        return (NSArray *)unknownArray;
    }
    // if string is given, create an array of strings with this string in it
    else if ([unkownReference isKindOfClass:[NSString class]])
    {
        return [NSArray arrayWithObject:(NSString *)unkownReference];
    }
    //Else should NEVER HAPPEN, throw error and abort
    //TODO: remove abort and find explicit handling of this situation
    else
    {
        // Replace this block with error handling code to handle
        //    this error approprietly. NEVER ship an app with a potential
        //    for this error occuring. But could be useful for development.
        // abort() causes the app to generate a crash log and... abort

        NSLog(@"Critical Error %@, %@", invalidPropertyTypeError,
              [invalidPropertyTypeError userInfo]);
        abort();
    }
    return nil;//TODO: Necessary?
}

//TODO: Implement with regEx: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$"
//credit for regEx: http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
+(NSString *)getValidatedEMailStringFrom:(NSString *)emailString
{
    // Validate that the string is a valid email address for cases:
    //     1. @ exists
    //     2. valid domain name exists
    //     3. valid .domain exists
    //     4. valid email username exists
    //     5. follows regex rules
    // Then trim any trailing or leading whitespace and return email string if valid
    // If not valid return a nil and give error code 2 without abort

    //Invalid email string error definition
    //TODO: Figure out how to encapsulate error handling with unique error enums
    NSString *errorDescription = @"Invalid E-Mail string for FMNContact property";
    NSString *errorFailReason = @"E-Mail must follow regEx and FMNContact formatting";
    NSString *errorSuggestion = @"Check FMNContact inits & sets are using valid strings";
    NSDictionary *invalidEMailStringDict;
    invalidEMailStringDict = @{
                               NSLocalizedDescriptionKey:
                                   NSLocalizedString(errorDescription, nil),
                               NSLocalizedFailureReasonErrorKey:
                                   NSLocalizedString(errorFailReason, nil),
                               NSLocalizedRecoverySuggestionErrorKey:
                                   NSLocalizedString(errorSuggestion, nil)
                               };
    NSError *invalidEMailStringError;
    invalidEMailStringError = [NSError errorWithDomain:@"FMNContact"
                                                  code:2
                                              userInfo:invalidEMailStringDict];

    // Check rule 1 in comments
    if (![emailString containsString:@"@"])
    {
        //error
        NSLog(@"Critical Error %@, %@ during set of email of FMNContact",
              invalidEMailStringError, [invalidEMailStringError userInfo]);
        return nil; //TODO: Explicit external handling of this must be confirmed
    }

    //TODO: add whitespace trimming func

    return emailString;
    
    
    
}

#pragma mark - Error Returns





@end
