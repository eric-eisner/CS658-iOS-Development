//
//  BrewersPlayerWebViewController.h
//  Brewers
//
//  Created by Ryan Hardt on 3/17/14.
//  Copyright (c) 2014 Ryan Hardt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrewersPlayerWebViewController : UIViewController

@property(nonatomic, weak) IBOutlet UIWebView* webView;
@property(nonatomic, strong) NSString* url;

@end
