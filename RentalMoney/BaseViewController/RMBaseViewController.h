//
//  RMBaseViewController.h
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/01/28.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMBaseViewController : UIViewController

@property (nonatomic, assign)CGPoint panStartPoint;
@property (nonatomic, assign)CGPoint panEndPoint;

- (void)panGesture:(UIPanGestureRecognizer *)recognizer;

@end
