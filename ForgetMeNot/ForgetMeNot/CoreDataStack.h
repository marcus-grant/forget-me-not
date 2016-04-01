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

//TODO: should this be a private property?
@property (readwrite,strong,nonatomic) NSManagedObjectContext *managedObjectContext;

-(id)initWithStoreURL:(NSURL*)storeURL modelURL:(NSURL*)modelURL;
+(instancetype)setupDataStore;
-(NSManagedObjectContext *)setupManagedObjectContext;
-(void)saveContext;
-(NSURL *)applicationDocumentsDirectory;

@end
