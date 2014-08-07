//
//  BrewersPositionTableViewController.m
//  Brewers
//
//  Created by Ryan Hardt on 3/17/14.
//  Copyright (c) 2014 Ryan Hardt. All rights reserved.
//

#import "BrewersPositionTableViewController.h"
#import "BrewersPlayersTableViewController.h"
#import "BrewersPlayer.h"
#import "BrewersHeadshot.h"
#import "AppDelegate.h"
#import "BrewersSettingsTableViewController.h"
#import "Pitcher.h"
#import "PositionPlayer.h"

@interface BrewersPositionTableViewController ()
@property(nonatomic, strong) BrewersHeadshot* genericPlayerHeadshot;
@end

@implementation BrewersPositionTableViewController

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
    
    UIBarButtonItem* settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(showSettings)];
    self.toolbarItems = @[settingsButton];
    self.navigationController.toolbarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showSettings
{
    [self performSegueWithIdentifier:@"showSettingsSegue" sender:self];
}

-(void)retrieveAllPlayerData
{
    //execute in separate thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext* moc = [appDelegate managedObjectContext];
    
        //clear all player data
        NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription* entity = [NSEntityDescription entityForName:@"BrewersPlayer" inManagedObjectContext:moc];
        [fetchRequest setEntity:entity];
        
        NSError* error = nil;
        NSArray* fetchResults = [moc executeFetchRequest:fetchRequest error:&error];
        
        for(BrewersPlayer* player in fetchResults) {
            [moc deleteObject:player];
        }
        
        _genericPlayerHeadshot = nil;

        //replace all player data
        for(int i=STARTING_PITCHER; i<=RIGHT_FIELD; ++i) {
            [self playersFromWebServiceForPosition:i withMoc:moc];
        }
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 10;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"showSettingsSegue"]) {
        BrewersSettingsTableViewController* dest = [segue destinationViewController];
        dest.delegate = self;
    } else {
        BrewersPlayersTableViewController* dest = [segue destinationViewController];
        Position position = (Position)[self.tableView indexPathForSelectedRow].row+1;
        dest.position = position;
        dest.players = [self playersForPosition:position];
        dest.navigationItem.title = [BrewersPlayer nameForPosition:position];
    }
}

-(NSMutableArray*)playersForPosition:(Position)position
{
    BOOL isOfflineModeEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:isOfflineModeEnabledKey];
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* moc = [appDelegate managedObjectContext];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* entity;
    if(position == STARTING_PITCHER || position == RELIEF_PITCHER) {
        entity = [NSEntityDescription entityForName:@"Pitcher" inManagedObjectContext:moc];
    } else {
        entity = [NSEntityDescription entityForName:@"PositionPlayer" inManagedObjectContext:moc];
    }
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor* sortByName = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortByName]];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"position == %i", position];
    [fetchRequest setPredicate:predicate];
    
    NSError* error = nil;
    NSMutableArray* fetchResults = [NSMutableArray arrayWithArray:[moc executeFetchRequest:fetchRequest error:&error]];
    
    if(!fetchResults) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    else if([fetchResults count] == 0 && !isOfflineModeEnabled) {
        fetchResults = [self playersFromWebServiceForPosition:position withMoc:moc];
    }
    
    return fetchResults;
}


-(NSMutableArray*)playersFromWebServiceForPosition:(Position)position withMoc:(NSManagedObjectContext*)moc
{
    NSString* brewersPlayersURLString = @"http://api.cbssports.com/fantasy/players/search?SPORT=baseball&version=3.0&response_format=json&pro_team=MIL";
    
    NSString* brewersPlayersByPositionURLString =[brewersPlayersURLString stringByAppendingFormat:@"&position=%@",[BrewersPlayer identifierForPosition:position]];
        
    NSURL* brewersPlayersByPositionURL = [NSURL URLWithString:brewersPlayersByPositionURLString];
    NSData* data = [NSData dataWithContentsOfURL:brewersPlayersByPositionURL];
        
    //Make a dictionary out of what just came back
    NSError* error = nil;
    NSDictionary* jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSDictionary* bodyDictionary = [jsonResponse objectForKey:@"body"];
    NSArray* playerDictionaries = [bodyDictionary objectForKey:@"players"];
    
    BrewersPlayer* player;
    NSMutableArray* players = [[NSMutableArray alloc] init];
    for(NSDictionary* playerDictionary in playerDictionaries) {
        if(position == STARTING_PITCHER || position == RELIEF_PITCHER) {
            player = [NSEntityDescription insertNewObjectForEntityForName:@"Pitcher" inManagedObjectContext:moc];
        } else {
            player = [NSEntityDescription insertNewObjectForEntityForName:@"PositionPlayer" inManagedObjectContext:moc];
        }
        
        player.playerId = [playerDictionary valueForKey:@"id"];
        player.firstName = [playerDictionary valueForKey:@"firstname"];
        player.lastName = [playerDictionary valueForKey:@"lastname"];
        player.position = [NSNumber numberWithInt:position];
        NSString* headshotUrl = [playerDictionary valueForKey:@"photo_url"];
        
        if([noHeadshotURL isEqualToString:headshotUrl]) {
           // use generic image
            player.headshot = self.genericPlayerHeadshot;
        } else {
            player.headshot = [self createHeadshotWithUrl:headshotUrl inManagedObjectContext:moc];
        }
        
        [players addObject:player];
    }
    return players;
};

-(BrewersHeadshot*)genericPlayerHeadshot
{
    if(_genericPlayerHeadshot) {
        return _genericPlayerHeadshot;
    }
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* moc = [appDelegate managedObjectContext];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"BrewersHeadshot" inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"url == %@", noHeadshotURL];
    [fetchRequest setPredicate:predicate];
    
    NSError* error = nil;
    NSArray* fetchResults = [NSMutableArray arrayWithArray:[moc executeFetchRequest:fetchRequest error:&error]];
    
    if(!fetchResults) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    } else if([fetchResults count] == 0) {
        _genericPlayerHeadshot = [self createHeadshotWithUrl:noHeadshotURL inManagedObjectContext:moc];
    } else {
        _genericPlayerHeadshot = [fetchResults lastObject];
    }
    
    return _genericPlayerHeadshot;
}

-(BrewersHeadshot*)createHeadshotWithUrl:(NSString*)headshotUrl inManagedObjectContext:(NSManagedObjectContext*)moc
{
    BrewersHeadshot* headshot = [NSEntityDescription insertNewObjectForEntityForName:@"BrewersHeadshot" inManagedObjectContext:moc];
    headshot.url = headshotUrl;
    headshot.data = [NSData dataWithContentsOfURL:[NSURL URLWithString:headshotUrl]];
    
    return headshot;
}

@end
