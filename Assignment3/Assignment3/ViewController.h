//
//  ViewController.h
//  Assignment3
//
//  Created by Eric L Eisner on 2/11/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BurnGenerator.h"
#import "MadLibGenerator.h"

@interface ViewController : UIViewController

@property(nonatomic, weak) IBOutlet UITextView* textView;
@property(nonatomic, weak) IBOutlet UIButton* btnBurn;
@property(nonatomic, weak) IBOutlet UIButton* btnMadLib;
@property(nonatomic, strong) MadLibGenerator* mlg;
@property(nonatomic, strong) BurnGenerator* bg;

-(IBAction)clickBurn:(id)sender;
-(IBAction)clickMadLib:(id)sender;

@end
