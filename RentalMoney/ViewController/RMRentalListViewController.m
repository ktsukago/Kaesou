//
//  RMRentalListViewController.m
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/01/28.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import "RMRentalListViewController.h"
#import "RMRentalDataManager.h"
#import "RMRentalCell.h"

@interface RMRentalListViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController *rentalFetchedResultController;
@property (weak, nonatomic) IBOutlet UIImageView *doneImageView;
@property (weak, nonatomic) IBOutlet UILabel *doneTextLabel;
@property (weak, nonatomic) IBOutlet UIToolbar *footerToolBar;

@end

@implementation RMRentalListViewController


#pragma mark - life cycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    srand((unsigned)time(NULL));
    if (random() %2 == 0) {
        self.doneImageView.image = [UIImage imageNamed:@"shake"];
        self.doneTextLabel.text = @"シェイクするとDONEが消えます";
    }
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, self.footerToolBar.frame.size.height)];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.rentalFetchedResultController  = [[RMRentalDataManager sharedInstance] rentalFetchedResultController:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewDidDisappear:animated];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}


#pragma mark - motion

//モーション開始時に実行
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"motionBegan:");
    //全部消す
    NSManagedObjectContext *context = [[RMRentalDataManager sharedInstance] managedObjectContext];
    for (Rental *rentalEntity in [self.rentalFetchedResultController fetchedObjects]) {
        if ([rentalEntity.doneBack isEqualToNumber:@1]) {
            [context deleteObject:rentalEntity];
            rentalEntity.doneBack = @1;
        }
    }
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

//モーション終了時に実行
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"motionEnded:");
}

//モーションキャンセル時に実行
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"motionCancelled:");
}


#pragma mark - table view datasource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.rentalFetchedResultController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.rentalFetchedResultController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    RMRentalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RMRentalCell"];
    if (cell == nil) {
        cell = [[RMRentalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rentalCell"];
        
        // iOS 7 separator
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


#pragma mark - table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [[RMRentalDataManager sharedInstance] managedObjectContext];
    Rental *rentalEntity = [self.rentalFetchedResultController objectAtIndexPath:indexPath];
    
    if ([rentalEntity.doneBack isEqualToNumber:@0]) {
        rentalEntity.doneBack = @1;
        UIApplication *application = [UIApplication sharedApplication];
        application.applicationIconBadgeNumber--;
    } else {
        rentalEntity.doneBack = @0;
        UIApplication *application = [UIApplication sharedApplication];
        application.applicationIconBadgeNumber++;
    }
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


#pragma mark - NSFetchedResultController delegate


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(RMRentalCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}



#pragma mark - cell


- (void)configureCell:(RMRentalCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Rental *rentalInfo = [self.rentalFetchedResultController objectAtIndexPath:indexPath];
    cell.lenderLabel.text = rentalInfo.lender;
    cell.priceLabel.text = [NSString stringWithFormat:@"%@円", rentalInfo.price];
    cell.doneImage.hidden =  [rentalInfo.doneBack isEqualToNumber:@0] ? YES : NO;
    cell.backDateLabel.text = [NSDate backDateStringAt:rentalInfo.backDate];
}


#pragma mark - util


- (UIView *)viewWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    return imageView;
}

@end
