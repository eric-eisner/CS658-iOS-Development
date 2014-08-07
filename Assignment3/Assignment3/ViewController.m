//
//  ViewController.m
//  Assignment3
//
//  Created by Eric L Eisner on 2/11/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	_bg = [[BurnGenerator alloc] init];
    _mlg = [[MadLibGenerator alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickBurn:(id)sender
{
    [_textView setText:[_bg generate]];
}

-(IBAction)clickMadLib:(id)sender
{
    [_textView setText:[_mlg generate]];
}

@end
