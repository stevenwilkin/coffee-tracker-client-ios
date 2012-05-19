//
//  ViewController.m
//  CoffeeTrackerIOS
//
//  Created by Steven Wilkin on 19/05/2012.
//  Copyright (c) 2012 NullTheory Ltd. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize button;
@synthesize count;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"btn-bg.png"];
    UIImage *stretchedImage = [image stretchableImageWithLeftCapWidth:6 topCapHeight:0];
    [button setBackgroundImage:stretchedImage forState:UIControlStateNormal];
    
    NSURL *url = [NSURL URLWithString:API_BASE_URL];
    client = [[AFHTTPClient alloc] initWithBaseURL:url];
    // API key must be set in pre-processor macros
    [client setDefaultHeader:@"X-API-KEY" value:API_KEY];
}

- (void)fetchCoffee {
    // clear cache
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    // set count label
    [count setText:@""];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [client getPath:@"/api" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self setCountFromResponseOperation:operation];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setCountFromResponseOperation:(AFHTTPRequestOperation *)operation {
    // convert response body to an integer
    int value = 0;
    NSScanner *scanner = [NSScanner scannerWithString:[operation responseString]];
    [scanner scanInt:&value];
    NSString *label = [NSString stringWithFormat:@"%d", value];
    [count setText:label];
}

- (IBAction)trackCoffee:(id)sender {
    // disable button while POST is in progress
    [button setEnabled:NO];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [client postPath:@"/api" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self setCountFromResponseOperation:operation];
        [button setEnabled:YES];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [button setEnabled:YES];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}

@end
