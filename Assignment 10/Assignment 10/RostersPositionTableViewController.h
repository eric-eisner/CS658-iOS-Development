//
//  RostersPositionTableViewController.h
//  Rosters
//
//  Created by Eric L Eisner on 3/30/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RostersPositionTableViewController : UITableViewController

@property(nonatomic, strong) NSArray* allPositions;

-(BOOL)saveChanges;

@end
