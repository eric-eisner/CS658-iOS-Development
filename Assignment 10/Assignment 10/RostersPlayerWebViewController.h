//
//  RostersPlayerWebViewController.h
//  Rosters
//
//  Created by Eric L Eisner on 3/30/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RostersPlayerWebViewController : UIViewController

@property(nonatomic, weak) IBOutlet UIWebView* webView;
@property(nonatomic, weak) NSString* playerUrl;

@end
