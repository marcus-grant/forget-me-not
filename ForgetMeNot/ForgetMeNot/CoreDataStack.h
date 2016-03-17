//
//  StorageController.h
//  ForgetMeNot
//
//  Created by Marcus Grant on 3/15/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+(instancetype)setupDataStore;
-(NSManagedObjectContext *)setupManagedObjectContext;
-(void)saveContext;
-(NSURL *)applicationDocumentsDirectory;

@end
