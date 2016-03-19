//
//  StorageController.m
//  ForgetMeNot
//
//  Created by Marcus Grant on 3/15/16.
//  Copyright © 2016 Marcus Grant. All rights reserved.
//  Ported from MyContacts project
//

#import "CoreDataStack.h"

@implementation CoreDataStack
@synthesize managedObjectContext = _managedObjectContext;

+(instancetype)setupDataStore
{
    static CoreDataStack *_sharedCoreDataStore = nil;
    //static dispatch_once_t singletonToken;//TODO: Is this necessary?
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedCoreDataStore = [[CoreDataStack alloc]init]; });
    return _sharedCoreDataStore;
}

-(NSManagedObjectContext *)setupManagedObjectContext
{
    if(_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }

    NSError *errorNil = nil;

    NSURL *storeURL = [[self applicationDocumentsDirectory]URLByAppendingPathComponent:@"coreDataStore.sqlite"];

    if  (![[NSFileManager defaultManager] fileExistsAtPath:[storeURL path]])
    {
        //uncomment to use a preloaded sqlite store
        /*
         NSURL *preloadURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"coreDataStore" ofType:@"sqlite"]];
         NSError *err = nil;
         if (![[NSFileManager defaultManager] copyItemAtURL:preloadURL toURL:storeURL error:&err]) {
         NSLog(@"Oops, could copy preloaded data");
         }
         */
    }

    NSManagedObjectModel *managedModel = [[NSManagedObjectModel alloc]
                                                initWithContentsOfURL:storeURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedModel];

    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&errorNil];

    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

-(void)saveContext
{
    NSError *errorNil = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    // So long as a an assigned managed object context exists, attempt to save
    
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&errorNil])
        {
            // Replace this block with save error handling code to handle
            //    this error approprietly. NEVER ship an app with a potential
            //    for this error occuring. But could be useful for development.
            // abort() causes the app to generate a crash log and... abort
            NSLog(@"Critical Error %@, %@ during save method of Core Data Stack",
                  errorNil, [errorNil userInfo]);
            abort();
        }

    }
}

// Returns the URL to the application's Documents directory.
-(NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
