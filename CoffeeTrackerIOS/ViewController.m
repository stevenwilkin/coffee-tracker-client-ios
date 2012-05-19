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

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"btn-bg.png"];
    UIImage *stretchedImage = [image stretchableImageWithLeftCapWidth:6 topCapHeight:0];
    [button setBackgroundImage:stretchedImage forState:UIControlStateNormal];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)trackCoffee:(id)sender {
    NSLog(@"> coffee!");
}

@end
