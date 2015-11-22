//
//  RMSubmitDateViewController.m
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/01/31.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import "RMSubmitDateViewController.h"
#import "RMRentalDataManager.h"
#import "RMAppDelegate.h"

@interface RMSubmitDateViewController ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dataBackgroundImageView;
@property (strong, nonatomic) UIDatePicker *datePicker;


@end

@implementation RMSubmitDateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDatePicker];
	// Do any additional setup after loading the view.
    NSDate *targetDate = [NSDate date];
    self.timeLabel.text = [NSDate timeStringAt:targetDate];
    self.dateLabel.text = [NSDate dateStringAt:targetDate];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark segue


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toList"] ||
        [segue.identifier isEqualToString:@"toListNavigation"]) {
        [self saveRentalEntity];
    } else if ([segue.identifier isEqualToString:@"backToInputMoney"]){
        self.dataBackgroundImageView.image = [UIImage imageNamed:@"DateBackgroundEnd"];
    }
}

- (void)saveRentalEntity
{
    NSManagedObjectContext *context = [[RMRentalDataManager sharedInstance] managedObjectContext];
    Rental *rentalEntity = (Rental *)[NSEntityDescription insertNewObjectForEntityForName:kEntityNameRental inManagedObjectContext: context];
    
    if ([self.rentalEntity.lender isEqualToString:@""]) {
        self.rentalEntity.lender = @"だれか";
    }
    
    if (self.rentalEntity.backDate == nil) {
        self.rentalEntity.backDate = [NSDate dateAfterHour:1];
    }
    
    [rentalEntity setPrice:self.rentalEntity.price];
    [rentalEntity setLender:self.rentalEntity.lender];
    [rentalEntity setBackDate:self.rentalEntity.backDate];
    [rentalEntity setDoneBack:@0];
    
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber++;
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [self setLocalNotification:self.rentalEntity];
}

- (void)setLocalNotification:(RMRentalEntity *)rentalEntity
{
    //UILocalNotificationクラスのインスタンスを作成します。
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
#ifdef DEBUG
    localNotif.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
#else
    localNotif.fireDate = rentalEntity.backDate;
#endif
    NSLog(@"date : %@", localNotif.fireDate);
    
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    //通知メッセージの本文を指定します。
    localNotif.alertBody = [NSString stringWithFormat:@"%@に%@円返しましょう", rentalEntity.lender, rentalEntity.price];
    
    localNotif.alertAction = @"Open";
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"通知を受信しました。" forKey:@"EventKey"];
    localNotif.userInfo = infoDict;
    
    //作成した通知イベント情報をアプリケーションに登録します。
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}

#pragma mark - IBAction


- (IBAction)tapSoonButton:(id)sender {
    NSDate *targetDate = [NSDate dateAfterHour:1];
    self.timeLabel.text = [NSDate timeStringAt:targetDate];
    self.dateLabel.text = [NSDate dateStringAt:targetDate];
    self.dataBackgroundImageView.image = [UIImage imageNamed:@"DateBackgroundEndSoon"];
    self.rentalEntity.backDate = targetDate;
    
    self.datePicker.date = targetDate;
}

- (IBAction)tapTommorowButton:(id)sender {
    NSDate *targetDate = [NSDate nextDay];
    self.timeLabel.text = [NSDate timeStringAt:targetDate];
    self.dateLabel.text = [NSDate dateStringAt:targetDate];
    self.dataBackgroundImageView.image = [UIImage imageNamed:@"DateBackgroundEndHour"];
    self.rentalEntity.backDate = targetDate;
    
     self.datePicker.date = targetDate;
}

- (IBAction)tapNextWeekButton:(id)sender {
#warning 週明け祝日対応
    NSDate *targetDate = [NSDate nextMonday];
    self.timeLabel.text = [NSDate timeStringAt:targetDate];
    self.dateLabel.text = [NSDate dateStringAt:targetDate];
    self.dataBackgroundImageView.image = [UIImage imageNamed:@"DateBackgroundEndNext"];
    self.rentalEntity.backDate = targetDate;
    
     self.datePicker.date = targetDate;
}

- (IBAction)tapNextMonthButton:(id)sender {
    NSDate *targetDate = [NSDate nextMonth];
    self.timeLabel.text = [NSDate timeStringAt:targetDate];
    self.dateLabel.text = [NSDate dateStringAt:targetDate];
    self.dataBackgroundImageView.image = [UIImage imageNamed:@"DateBackgroundEndMonth"];
    self.rentalEntity.backDate = targetDate;
    
     self.datePicker.date = targetDate;
}

- (void)setupDatePicker
{
    // イニシャライザ
    self.datePicker= [[UIDatePicker alloc]init];
    self.datePicker.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    self.datePicker.minuteInterval = 10;
    CGRect datePickerFrame = self.datePicker.frame;
    CGRect bottomFrame = CGRectOffset(datePickerFrame, 0.0f, [UIScreen height]);
    //    CGRect bottomFrame = CGRectOffset(datePickerFrame, 0.0f, [UIScreen height] - datePickerFrame.size.height);
    self.datePicker.frame = bottomFrame;
    
    [self.datePicker addTarget:self
                   action:@selector(datePickerDidValueChange:)
         forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.datePicker];
}

- (void)showDatePicker
{
    CGRect showedRect = CGRectMake(0.0f,
                                   [UIScreen height] - self.datePicker.frame.size.height,
                                   self.datePicker.frame.size.width,
                                   self.datePicker.frame.size.height);
    //表示されていたらそのまま
    if (self.datePicker.frame.origin.y == showedRect.origin.y) {
        return;
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        self.datePicker.frame = showedRect;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)toggleDatePicker
{
    CGRect showedRect = CGRectMake(0.0f,
                                   [UIScreen height] - self.datePicker.frame.size.height,
                                   self.datePicker.frame.size.width,
                                   self.datePicker.frame.size.height);
    //表示されていたらそのまま
    if (self.datePicker.frame.origin.y == showedRect.origin.y) {
        [self hideDatePicker];
    } else {
        [self showDatePicker];
    }
}

- (void)hideDatePicker
{
    CGRect hiddenRect = CGRectMake(0.0f,
                                   [UIScreen height] ,
                                   self.datePicker.frame.size.width,
                                   self.datePicker.frame.size.height);
    //隠れていたらそのまま
    if (self.datePicker.frame.origin.y == hiddenRect.origin.y) {
        return;
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        self.datePicker.frame = hiddenRect;
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)tapDatePicker:(id)sender {
    [self toggleDatePicker];
}


#pragma mark - date picker


- (void)datePickerDidValueChange:(UIDatePicker *)datePicker
{
    self.dateLabel.text = [NSDate dateStringAt:datePicker.date];
    self.timeLabel.text = [NSDate timeStringAt:datePicker.date];
}


#pragma mark -


- (void)toNextPage
{
    [self performSegueWithIdentifier:@"toListNavigation" sender:self];
}

- (void)toPreviousPage
{
    [self performSegueWithIdentifier:@"backToInputMoney" sender:self];
}


#pragma mark - pan 


- (void)panGesture:(UIPanGestureRecognizer *)recognizer
{
    [super panGesture:recognizer];
    CGPoint translation = [recognizer translationInView:self.view];
    if (self.panStartPoint.y == 0) {
        return;
    }
    CGFloat moveY = translation.y - self.panStartPoint.y;
    moveY *= 0.7f;
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.panStartPoint = translation;
            break;
        case UIGestureRecognizerStateChanged:
            self.panStartPoint = translation;
            self.datePicker.frame = CGRectOffset(self.datePicker.frame, 0.0f, moveY);
            break;
        case UIGestureRecognizerStateEnded:
            self.panStartPoint = translation;
            self.datePicker.frame = CGRectOffset(self.datePicker.frame, 0.0f, moveY);
            break;
        default:
            break;
    }
}

@end
