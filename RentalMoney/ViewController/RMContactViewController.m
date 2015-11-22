//
//  RMContactViewController.m
//  RentalMoney
//
//  Created by 塚越 啓介 on 2014/02/06.
//  Copyright (c) 2014年 ktsukago. All rights reserved.
//

#import "RMContactViewController.h"
#import "RMMoveUpAnimation.h"

NSString *const FeedUrlGoogleDocs = @"https://docs.google.com/forms/d/14QaDtjFfFna-023zLZlomq4eYpKXL0lmrTvHnuyw2N0/formResponse";


@interface RMContactViewController ()

@property (weak, nonatomic) IBOutlet UITextView *contactText;

@end

@implementation RMContactViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


#pragma mark - IBAction


- (IBAction)tapSubmitContactButton:(id)sender {
    NSURL *url = [NSURL URLWithString:FeedUrlGoogleDocs];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSMutableDictionary *postBody = [[NSMutableDictionary alloc] init];
    postBody[@"entry.2122285305"] = self.contactText.text;
    [request setHTTPBody:[[postBody urlEncodedString] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [self performSelectorOnMainThread:@selector(showPostDoneMessage) withObject:nil waitUntilDone:YES];
    }];
}

- (void)showPostDoneMessage
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"ご協力ありがとうございました。" delegate:nil cancelButtonTitle:@"閉じる" otherButtonTitles:nil];
    [alert show];
}

@end
