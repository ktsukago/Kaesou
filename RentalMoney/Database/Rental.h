//
//  Rental.h
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/01/28.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Rental : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * lender;
@property (nonatomic, retain) NSDate * backDate;
@property (nonatomic, retain) NSDate * rentDate;
@property (nonatomic, retain) NSDate * lastUpdate;
@property (nonatomic, retain) NSNumber * doneBack;

@end
