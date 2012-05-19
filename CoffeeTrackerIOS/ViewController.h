//
//  ViewController.h
//  CoffeeTrackerIOS
//
//  Created by Steven Wilkin on 19/05/2012.
//  Copyright (c) 2012 NullTheory Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "ApiKey.h"

#ifdef TARGET_IPHONE_SIMULATOR
    #define API_BASE_URL @"http://0.0.0.0:9292"
#endif

#ifdef TARGET_OS_IPHONE
    #undef API_BASE_URL
    #define API_BASE_URL @"http://coffee-tracker.herokuapp.com"
#endif

@interface ViewController : UIViewController {
    AFHTTPClient *client;
}

@property (nonatomic) IBOutlet UIButton *button;
@property (assign) IBOutlet UILabel *count;

- (void)setCountFromResponseOperation:(AFHTTPRequestOperation *)operation;
- (IBAction)trackCoffee:(id)sender;

@end
