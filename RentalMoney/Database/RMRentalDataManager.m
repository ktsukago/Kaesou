//
//  RMRentalDataManager.m
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/01/27.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import "RMRentalDataManager.h"

@interface RMRentalDataManager()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultController;

@end


@implementation RMRentalDataManager


static RMRentalDataManager *instance;

+ (RMRentalDataManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSFetchedResultsController *)rentalFetchedResultController:(id<NSFetchedResultsControllerDelegate>)delegate
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:kEntityNameRental inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    //http://www.lifeaether.com/overtaker/blog/?p=1747
    /*
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"doneBack = NO"];
    [fetchRequest setPredicate:predicate];
     */
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptorForTimeStamp = [[NSSortDescriptor alloc] initWithKey:@"lastUpdate" ascending:NO];
    NSSortDescriptor *sortDescriptorForDone = [[NSSortDescriptor alloc] initWithKey:@"doneBack" ascending:YES];
    
    NSArray *sortDescriptors = @[sortDescriptorForDone, sortDescriptorForTimeStamp];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = delegate;
    self.fetchedResultController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultController performFetch:&error]) {
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return self.fetchedResultController;
}



@end
