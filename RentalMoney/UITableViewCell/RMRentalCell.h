//
//  RMRentalCell.h
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/01/28.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCSwipeTableViewCell.h"

@interface RMRentalCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *backDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *doneImage;
@property (weak, nonatomic) IBOutlet UILabel *lenderLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
