//
//  ToDoListSettingsTableViewController.m
//  ToDo2
//
//  Created by Eric L Eisner on 4/6/14.
//  Copyright (c) 2014 Ryan Hardt. All rights reserved.
//

#import "ToDoListSettingsTableViewController.h"
#import "ToDoListViewController.h"

@interface ToDoListSettingsTableViewController ()

@end

@implementation ToDoListSettingsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    if([self.deleteOnComplete isEqualToString:@"YES"]) {
        [self.deleteOnCompleteSwitch setOn:YES];
    } else {
        [self.deleteOnCompleteSwitch setOn:NO];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    if(self.deleteOnCompleteSwitch.isOn) {
        [self.deleteOnComplete setString:@"YES"];
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:DeleteOnCompleteKey];
    } else {
        [self.deleteOnComplete setString:@"NO"];
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:DeleteOnCompleteKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

@end
