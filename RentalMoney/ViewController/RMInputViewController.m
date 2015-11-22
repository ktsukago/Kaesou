//
//  RMInputViewController.m
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/01/30.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import "RMInputViewController.h"
#import "RMSubmitDateViewController.h"

@interface RMInputViewController ()

@property (weak, nonatomic) IBOutlet UITextField *priceTextField;

@property (weak, nonatomic) IBOutlet UIButton *button1000;
@property (weak, nonatomic) IBOutlet UIButton *button10000;
@property (weak, nonatomic) IBOutlet UIButton *button500;
@property (weak, nonatomic) IBOutlet UIButton *button100;
@property (weak, nonatomic) IBOutlet UIView *buttonBaseView;

@end

@implementation RMInputViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]){
        _priceTextField.text = @"0";
    }
    return self ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - segue


- (IBAction)rentalInputViewReturnActionForSegue:(UIStoryboardSegue *)segue
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toSubmit"] ||
        [segue.identifier isEqualToString:@"toSubmitNavigation"]) {
        self.rentalEntity.price = @([self.priceTextField.text integerValue]);
        RMSubmitDateViewController *submitViewController = [segue destinationViewController];
        submitViewController.rentalEntity = self.rentalEntity;
    }

}


#pragma mark - IBAction


- (IBAction)tap10000Button:(id)sender {
    NSInteger addedPrice = [self.priceTextField.text integerValue] + 10000;
    self.priceTextField.text = [NSString stringWithFormat:@"%ld", (long)addedPrice];
    
    UIImageView *image10000 = [[UIImageView alloc] initWithImage:self.button10000.imageView.image];
    image10000.frame = CGRectOffset(self.button10000.frame, self.buttonBaseView.frame.origin.x + 5.0f, self.buttonBaseView.frame.origin.y - 5.0f);
    [self.view addSubview:image10000];
    [self.view sendSubviewToBack:image10000];
    
    
    [UIView animateWithDuration:0.3f animations:^{
        image10000.frame = CGRectMake(self.priceTextField.frame.origin.x,
                                      self.priceTextField.frame.origin.y,
                                      image10000.frame.size.width,
                                      image10000.frame.size.height);
    } completion:^(BOOL finished) {
        [image10000 removeFromSuperview];
    }];
    
}

- (IBAction)tap1000Button:(id)sender {
    NSInteger addedPrice = [self.priceTextField.text integerValue] + 1000;
    self.priceTextField.text = [NSString stringWithFormat:@"%ld", (long)addedPrice];
    
    UIImageView *image1000 = [[UIImageView alloc] initWithImage:self.button1000.imageView.image];
    image1000.frame = CGRectOffset(self.button1000.frame, self.buttonBaseView.frame.origin.x + 5.0f, self.buttonBaseView.frame.origin.y - 5.0f);
    [self.view addSubview:image1000];
    [self.view sendSubviewToBack:image1000];
    
    
    [UIView animateWithDuration:0.3f animations:^{
        image1000.frame = CGRectMake(self.priceTextField.frame.origin.x,
                                      self.priceTextField.frame.origin.y,
                                      image1000.frame.size.width,
                                      image1000.frame.size.height);
    } completion:^(BOOL finished) {
        [image1000 removeFromSuperview];
    }];
}

- (IBAction)tap500Button:(id)sender {
    NSInteger addedPrice = [self.priceTextField.text integerValue] + 500;
    self.priceTextField.text = [NSString stringWithFormat:@"%ld", (long)addedPrice];
    
    UIImageView *image500 = [[UIImageView alloc] initWithImage:self.button500.imageView.image];
    image500.frame = CGRectOffset(self.button500.frame, self.buttonBaseView.frame.origin.x + 5.0f, self.buttonBaseView.frame.origin.y - 5.0f);
    [self.view addSubview:image500];
    [self.view sendSubviewToBack:image500];
    
    
    [UIView animateWithDuration:0.3f animations:^{
        image500.frame = CGRectMake(self.priceTextField.frame.origin.x,
                                    self.priceTextField.frame.origin.y,
                                    image500.frame.size.width,
                                    image500.frame.size.height);
    } completion:^(BOOL finished) {
        [image500 removeFromSuperview];
    }];
}

- (IBAction)tap100Button:(id)sender {
    NSInteger addedPrice = [self.priceTextField.text integerValue] + 100;
    self.priceTextField.text = [NSString stringWithFormat:@"%ld", (long)addedPrice];
    
    UIImageView *image100 = [[UIImageView alloc] initWithImage:self.button100.imageView.image];
    image100.frame = CGRectOffset(self.button100.frame, self.buttonBaseView.frame.origin.x + 5.0f, self.buttonBaseView.frame.origin.y - 5.0f);
    [self.view addSubview:image100];
    [self.view sendSubviewToBack:image100];
    
    
    [UIView animateWithDuration:0.3f animations:^{
        image100.frame = CGRectMake(self.priceTextField.frame.origin.x,
                                     self.priceTextField.frame.origin.y,
                                     image100.frame.size.width,
                                     image100.frame.size.height);
    } completion:^(BOOL finished) {
        [image100 removeFromSuperview];
    }];
}


#pragma mark -


- (void)toNextPage
{
    [self performSegueWithIdentifier:@"toSubmitNavigation" sender:self];
}

- (void)toPreviousPage
{
    [self performSegueWithIdentifier:@"backToInputWhoPage" sender:self];
}

@end
