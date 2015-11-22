//
//  RMRentalViewController.m
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/01/28.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import "RMRentalViewController.h"
#import "RMRentalDataManager.h"
#import "RMInputViewController.h"
#import "RMMoveUpAnimation.h"

@interface RMRentalViewController () <UITextFieldDelegate, UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UIButton *submitRentalButton;

- (IBAction)tapSubmitButton:(UIButton *)sender;

@end

@implementation RMRentalViewController


#pragma mark - life cycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.lenderTextField.delegate = self;
    self.lenderTextField.returnKeyType = UIReturnKeyDone;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.lenderTextField becomeFirstResponder];
}


#pragma mark - IBAction


- (IBAction)tapSubmitButton:(UIButton *)sender {
    NSManagedObjectContext *context = [[RMRentalDataManager sharedInstance] managedObjectContext];
    Rental *rentalEntity = (Rental *)[NSEntityDescription insertNewObjectForEntityForName:kEntityNameRental inManagedObjectContext: context];
    
    [rentalEntity setTitle:@"test"];
    [rentalEntity setPrice:@1000];
    [rentalEntity setLender:@"waro"];
    [rentalEntity setDoneBack:@0];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - uikeyboard delegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self toNextPage];
    
    return YES;
}


#pragma mark - segue


- (IBAction)rentalViewReturnActionForSegue:(UIStoryboardSegue *)segue
{
    
}

- (void)toNextPage
{
    RMRentalEntity *entity = [[RMRentalEntity alloc] init];
    entity.lender = self.lenderTextField.text;
    
    RMInputViewController *inputViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RMInputViewController"];
    
    inputViewController.rentalEntity = entity;
    inputViewController.modalPresentationStyle = UIModalPresentationCustom;
    inputViewController.transitioningDelegate = self;
    
    [self presentViewController:inputViewController animated:YES completion:nil];
}

#pragma mark - uiview transitioning delegate


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    RMMoveUpAnimation *animation = [[RMMoveUpAnimation alloc] init];
    animation.moveDistance = 150.0f;
    animation.isReverse = YES;
    return animation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    RMMoveUpAnimation *animation = [[RMMoveUpAnimation alloc] init];
    animation.moveDistance = 150.0f;
    animation.isReverse = NO;
    return animation;
}


#pragma mark - IBAction


- (IBAction)tapNextButton:(id)sender {
    [self toNextPage];
}

- (void)toPreviousPage
{
    [self performSegueWithIdentifier:@"backToTop" sender:self];
}


@end
