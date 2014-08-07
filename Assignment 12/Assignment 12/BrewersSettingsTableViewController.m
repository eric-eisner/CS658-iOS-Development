//
//  BrewersSettingsTableViewController.m
//  Assignment 12
//
//  Created by Eric L Eisner on 4/22/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "BrewersSettingsTableViewController.h"
#import "BrewersPositionTableViewController.h"

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
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:OfflineMode]) {
        [self.offlineModeSwitch setOn:YES animated:YES];
        [self.refreshPlayersButton setEnabled:NO];
    } else {
        [self.offlineModeSwitch setOn:NO animated:YES];
        [self.refreshPlayersButton setEnabled:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)switchChangedState
{
    if(self.offlineModeSwitch.isOn) {
        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:OfflineMode];
        [self.refreshPlayersButton setEnabled:NO];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@NO forKey:OfflineMode];
        [self.refreshPlayersButton setEnabled:YES];
    }
    [[self delegate] settingsDidChange];
}

-(IBAction)refreshPlayers
{
    [[self delegate] refreshPlayers];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
