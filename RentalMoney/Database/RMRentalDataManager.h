//
//  RMRentalDataManager.h
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/01/27.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import "RMDBManager.h"

static NSString *kEntityNameRental = @"Rental";

@interface RMRentalDataManager : RMDBManager

+ (RMRentalDataManager *)sharedInstance;
- (NSFetchedResultsController *)rentalFetchedResultController:(id<NSFetchedResultsControllerDelegate>)delegate;

@end
