//
//  ToDoListSettingsTableViewController.h
//  ToDo2
//
//  Created by Eric L Eisner on 4/6/14.
//  Copyright (c) 2014 Ryan Hardt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoListSettingsTableViewController : UITableViewController

@property(nonatomic, weak) IBOutlet UISwitch* deleteOnCompleteSwitch;
@property(nonatomic, weak) NSMutableString* deleteOnComplete;

@end
