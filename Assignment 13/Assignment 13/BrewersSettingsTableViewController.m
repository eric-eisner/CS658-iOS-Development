//
//  BrewersSettingsTableViewController.m
//  brewers
//
//  Created by Ryan Hardt on 4/10/14.
//  Copyright (c) 2014 Ryan Hardt. All rights reserved.
//

#import "BrewersSettingsTableViewController.h"

@interface BrewersSettingsTableViewController ()

@end

@implementation BrewersSettingsTableViewController

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
    BOOL isOfflineModeEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:isOfflineModeEnabledKey];
    [self.isOfflineModeEnabledSwitch setOn:isOfflineModeEnabled];
    [self.refreshPlayersButton setEnabled:!isOfflineModeEnabled];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)switchToggled
{
    if(self.isOfflineModeEnabledSwitch.isOn && !self.didRetrieveAllPlayerData) {
        [self.delegate retrieveAllPlayerData];
        self.didRetrieveAllPlayerData = true;
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:self.isOfflineModeEnabledSwitch.isOn forKey:isOfflineModeEnabledKey];
    [self.refreshPlayersButton setEnabled:!self.isOfflineModeEnabledSwitch.isOn];
}

-(IBAction)refreshPlayersButtonPressed
{
    [self.delegate retrieveAllPlayerData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

@end
