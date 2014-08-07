//
//  RostersPlayersTableViewController.m
//  Rosters
//
//  Created by Eric L Eisner on 3/30/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "RostersPlayersTableViewController.h"
#import "BaseballPlayer.h"
#import "RostersPlayerDetailViewController.h"
#import "RostersAddEditPlayerViewController.h"

@interface RostersPlayersTableViewController ()
//@property(nonatomic, weak) UIBarButtonItem* addButton;
@property(nonatomic, strong) BaseballPlayer* player;
@end

@implementation RostersPlayersTableViewController

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
    self.player = nil;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addPlayer
{
    [self performSegueWithIdentifier:@"addPlayerSegue" sender:self];
}

#pragma mark - add player delegate

-(void)doneAddPlayer
{
    //if([self.player.firstName isEqualToString:@""] && [self.player.lastName isEqualToString:@""] && [self.player.url isEqualToString:@""]) {
        
    //}
    //NSLog(@"%@ %@ - %@", self.player.firstName, self.player.lastName, self.player.position);
    [self.players insertObject:self.player atIndex:self.players.count];
    
    //NSIndexPath* indexPath = [NSIndexPath indexPathForRow:self.players.count inSection:0];
    
    //[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}

-(void)cancelAddPlayer
{
    self.player = nil;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.players count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.players objectAtIndex:indexPath.row] fullName];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.players removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    /*else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    } */
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    BaseballPlayer* player = [self.players objectAtIndex:fromIndexPath.row];
    [self.players removeObjectAtIndex:fromIndexPath.row];
    [self.players insertObject:player atIndex:toIndexPath.row];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"showPlayerDetailSegue"]) {
        RostersPlayerDetailViewController* dest = [segue destinationViewController];
        UITableViewCell* cell = (UITableViewCell*)sender;
        dest.player = [self.players objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        dest.navigationItem.title = cell.textLabel.text;
    } else if ([segue.identifier isEqualToString:@"addPlayerSegue"]) {
        RostersAddEditPlayerViewController* dest = [segue destinationViewController];
        self.player = [[BaseballPlayer alloc] init];
        dest.delegate = self;
        self.player.position = self.navigationItem.title;
        dest.player = self.player;
        dest.navigationItem.title = @"Add Player";
    }
}

@end
