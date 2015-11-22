//
//  RMConfigViewController.m
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/02/05.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import "RMConfigViewController.h"
#import "RMContactViewController.h"
#import "RMMoveUpAnimation.h"

typedef NS_ENUM(NSUInteger, SectionAbout){
    SectionAboutThisApp = 0,
    SectionAboutMax,
    SectionConfig,
};

typedef NS_ENUM(NSUInteger, RowAboutThisApp){
    RowAboutThisAppVersion = 0,
    RowAboutThisAppContact,
    RowAboutThisAppMax,
    RowAboutThisAppOSS,
    RowAboutThisAppTutorial,
};

typedef NS_ENUM(NSUInteger, RowConfig) {
    RowConfigCategory,
    RowConfigRemind,
    RowConfigMax,
};

@interface RMConfigViewController ()<UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RMConfigViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


#pragma mark - table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return RowAboutThisAppMax;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return SectionAboutMax;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ConfigCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    return [self aboutThisAppSectionCell:cell At:indexPath.row];
}


- (UITableViewCell *)aboutThisAppSectionCell:(UITableViewCell *)cell At:(NSInteger)row
{
    switch (row) {
        case RowAboutThisAppVersion:
            cell.textLabel.text = @"バージョン";
            cell.detailTextLabel.text = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ;
            break;
        case RowAboutThisAppContact:
            cell.textLabel.text = @"問い合わせ";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        default:
            break;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case RowAboutThisAppContact:{
            RMContactViewController *contactViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RMContactViewController"];
            contactViewController.modalPresentationStyle = UIModalPresentationCustom;
            contactViewController.transitioningDelegate = self;
            [self presentViewController:contactViewController animated:YES completion:nil];
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
            break;
        }
        default:
            break;
    }
}


#pragma mark - segue


- (IBAction)configViewReturnActionForSegue:(UIStoryboardSegue *)segue
{
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    RMMoveUpAnimation *animation = [[RMMoveUpAnimation alloc] init];
    animation.moveDistance = 600.0f;
    animation.isReverse = YES;
    return animation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    RMMoveUpAnimation *animation = [[RMMoveUpAnimation alloc] init];
    animation.moveDistance = 600.0f;
    animation.isReverse = NO;
    return animation;
}

@end
