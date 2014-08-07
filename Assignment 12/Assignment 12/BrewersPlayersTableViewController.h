//
//  BrewersPlayersTableViewController.h
//  Brewers
//
//  Created by Ryan Hardt on 3/17/14.
//  Copyright (c) 2014 Ryan Hardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrewersPlayer.h"

@interface BrewersPlayersTableViewController : UITableViewController

@property(nonatomic, strong) NSMutableArray* players;
@property(nonatomic) Position position;

@end
