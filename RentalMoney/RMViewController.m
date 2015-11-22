//
//  RMViewController.m
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/01/26.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import "RMViewController.h"
#import "NADView.h"

@interface RMViewController ()<NADViewDelegate>

@property (nonatomic, strong) NADView *nadView;
@property (weak, nonatomic) IBOutlet UIView *adView;

@end

@implementation RMViewController


#pragma mark - life cycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // (2) NADViewの作成
    self.nadView = [[NADView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    // (3) ログ出力の指定
    [self.nadView setIsOutputLog:NO];
    // (4) set apiKey, spotId.
#ifdef DEBUG
    [self.nadView setNendID:@"a6eca9dd074372c898dd1df549301f277c53f2b9"
                     spotID:@"3172"];
#else
    [self.nadView setNendID:@"29cfcf84be8b56a77624efa27f38af32d40ba16c"
                     spotID:@"135656"];
#endif
    [self.nadView setDelegate:self]; //(5)
    [self.nadView load]; //(6)
    [self.adView addSubview:self.nadView]; // 最初から表示する場合
    
}


#pragma mark - segue


- (IBAction)topViewReturnActionForSegue:(UIStoryboardSegue *)segue
{
    
}


@end
