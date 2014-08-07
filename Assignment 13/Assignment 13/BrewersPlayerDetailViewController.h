//
//  BrewersPlayerDetailViewController.h
//  Brewers
//
//  Created by Ryan Hardt on 3/17/14.
//  Copyright (c) 2014 Ryan Hardt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BrewersPlayer;

@interface BrewersPlayerDetailViewController : UIViewController

@property(nonatomic, weak) BrewersPlayer* player;
@property(nonatomic, weak) IBOutlet UILabel* firstNameLabel;
@property(nonatomic, weak) IBOutlet UILabel* lastNameLabel;
@property(nonatomic, weak) IBOutlet UILabel* positionLabel;
@property(nonatomic, weak) IBOutlet UIButton* moreInfoButton;
@property(nonatomic, weak) IBOutlet UIImageView* headshotImageView;
@property(nonatomic, weak) IBOutlet UILabel* abLabel;
@property(nonatomic, weak) IBOutlet UILabel* hrLabel;
@property(nonatomic, weak) IBOutlet UILabel* avgLabel;
@property(nonatomic, weak) IBOutlet UILabel* rbiLabel;
@property(nonatomic, weak) IBOutlet UILabel* rLabel;
@property(nonatomic, weak) IBOutlet UILabel* sbLabel;
@property(nonatomic, weak) IBOutlet UILabel* abField;
@property(nonatomic, weak) IBOutlet UILabel* hrField;
@property(nonatomic, weak) IBOutlet UILabel* avgField;
@property(nonatomic, weak) IBOutlet UILabel* rbiField;
@property(nonatomic, weak) IBOutlet UILabel* rField;
@property(nonatomic, weak) IBOutlet UILabel* sbField;
@property(nonatomic, weak) IBOutlet UILabel* wLabel;
@property(nonatomic, weak) IBOutlet UILabel* lLabel;
@property(nonatomic, weak) IBOutlet UILabel* sLabel;
@property(nonatomic, weak) IBOutlet UILabel* eraLabel;
@property(nonatomic, weak) IBOutlet UILabel* kLabel;
@property(nonatomic, weak) IBOutlet UILabel* bbLabel;
@property(nonatomic, weak) IBOutlet UILabel* whipLabel;
@property(nonatomic, weak) IBOutlet UILabel* wField;
@property(nonatomic, weak) IBOutlet UILabel* lField;
@property(nonatomic, weak) IBOutlet UILabel* sField;
@property(nonatomic, weak) IBOutlet UILabel* eraField;
@property(nonatomic, weak) IBOutlet UILabel* kField;
@property(nonatomic, weak) IBOutlet UILabel* bbField;
@property(nonatomic, weak) IBOutlet UILabel* whipField;
@property(nonatomic, weak) IBOutlet UILabel* unavailableLabel;

@end
