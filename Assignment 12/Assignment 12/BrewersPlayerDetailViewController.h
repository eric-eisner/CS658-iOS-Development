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

@end
