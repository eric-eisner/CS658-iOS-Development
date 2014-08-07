//
//  RostersPositionTableViewController.m
//  Rosters
//
//  Created by Eric L Eisner on 3/30/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "RostersPositionTableViewController.h"
#import "BaseballPlayer.h"
#import "RostersPlayersTableViewController.h"

@interface RostersPositionTableViewController ()
@property(nonatomic, strong) NSMutableArray* pitcher;
@property(nonatomic, strong) NSMutableArray* catcher;
@property(nonatomic, strong) NSMutableArray* firstBase;
@property(nonatomic, strong) NSMutableArray* secondBase;
@property(nonatomic, strong) NSMutableArray* thirdBase;
@property(nonatomic, strong) NSMutableArray* shortstop;
@property(nonatomic, strong) NSMutableArray* leftField;
@property(nonatomic, strong) NSMutableArray* centerField;
@property(nonatomic, strong) NSMutableArray* rightField;
@end

@implementation RostersPositionTableViewController

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
    
    self.pitcher = [[NSMutableArray alloc] init];
    self.catcher = [[NSMutableArray alloc] init];
    self.firstBase = [[NSMutableArray alloc] init];
    self.secondBase = [[NSMutableArray alloc] init];
    self.thirdBase = [[NSMutableArray alloc] init];
    self.shortstop = [[NSMutableArray alloc] init];
    self.leftField = [[NSMutableArray alloc] init];
    self.centerField = [[NSMutableArray alloc] init];
    self.rightField = [[NSMutableArray alloc] init];
    
    self.allPositions = [[NSArray alloc] initWithObjects:self.pitcher, self.catcher, self.firstBase, self.secondBase, self.thirdBase, self.shortstop, self.leftField, self.centerField,
                         self.rightField, nil];
    
    [self createPlayers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createPlayers
{
    BaseballPlayer* player;
    
    player = [[BaseballPlayer alloc] initWithFirstName:@"Yovani" lastName:@"Gallardo" position:@"Pitcher"];
    [self.pitcher addObject:player];
    
    player = [[BaseballPlayer alloc] initWithFirstName:@"Matt" lastName:@"Garza" position:@"Pitcher"];
    [self.pitcher addObject:player];
    
    player = [[BaseballPlayer alloc] initWithFirstName:@"Jim" lastName:@"Henderson" position:@"Pitcher"];
    [self.pitcher addObject:player];
    
    player = [[BaseballPlayer alloc] initWithFirstName:@"Jonathan" lastName:@"Lucroy" position:@"Catcher"];
    [self.catcher addObject:player];
    
    player = [[BaseballPlayer alloc] initWithFirstName:@"Martin" lastName:@"Maldonado" position:@"Catcher"];
    [self.catcher addObject:player];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 9;
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    RostersPlayersTableViewController* dest = [segue destinationViewController];
    UITableViewCell* cell = (UITableViewCell*)sender;
    dest.players = [self.allPositions objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    dest.navigationItem.title = cell.textLabel.text;
}

@end
