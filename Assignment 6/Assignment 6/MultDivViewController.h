//
//  MultDivViewController.h
//  Assignment 6
//
//  Created by Eric L Eisner on 3/4/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultDivViewController : UIViewController

@property(nonatomic, weak) IBOutlet UILabel* operand1Label;
@property(nonatomic, weak) IBOutlet UILabel* operand2Label;
@property(nonatomic, weak) IBOutlet UILabel* operatorLabel;
@property(nonatomic, weak) IBOutlet UILabel* answerLabel;

-(IBAction)screenTapped;

@end
