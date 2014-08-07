//
//  BrewersPositionTableViewController.h
//  Brewers
//
//  Created by Ryan Hardt on 3/17/14.
//  Copyright (c) 2014 Ryan Hardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrewersSettingsTableViewController.h"

@interface BrewersPositionTableViewController : UITableViewController<BrewersSettingsDelegate>

-(void)retrieveAllPlayerData;

@end
