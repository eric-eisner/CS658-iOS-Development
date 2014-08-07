//
//  BrewersPositionTableViewController.m
//  Brewers
//
//  Created by Ryan Hardt on 3/17/14.
//  Copyright (c) 2014 Ryan Hardt. All rights reserved.
//

#import "BrewersSettingsTableViewController.h"
#import "BrewersPositionTableViewController.h"
#import "BrewersPlayersTableViewController.h"
#import "BrewersPlayer.h"
#import "AppDelegate.h"

@interface BrewersPositionTableViewController ()

@property(nonatomic) BOOL didEnableOfflineMode;

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
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:OfflineMode]) {
        [self refreshPlayers];
        self.didEnableOfflineMode = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showSettings
{
    [self performSegueWithIdentifier:@"SettingsSegue" sender:self];
}

-(void)settingsDidChange
{
    if([[NSUserDefaults standardUserDefaults] boolForKey:OfflineMode]) {
        self.didEnableOfflineMode = YES;
        [self refreshPlayers];
    }
}

-(void)refreshPlayers
{
    if(self.didEnableOfflineMode) {
        return;
    }
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    
    [appDelegate resetData];
    
    NSManagedObjectContext* moc = [appDelegate managedObjectContext];
        
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //do stuff on background thread here
        for(int i=0; i <= RIGHT_FIELD; ++i) {
            [self playersFromWebServiceForPosition:i withMoc:moc];
        }
    });
    
    self.didEnableOfflineMode = YES;
        
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
    if([segue.identifier isEqualToString:@"SettingsSegue"]) {
        BrewersSettingsTableViewController* settings = [segue destinationViewController];
        settings.delegate = self;
        return;
    }
    
    BrewersPlayersTableViewController* dest = [segue destinationViewController];
    Position position = (Position)[self.tableView indexPathForSelectedRow].row+1;
    dest.players = [self playersForPosition:position];
    dest.position = position;
    dest.navigationItem.title = [BrewersPlayer nameForPosition:position];
}

-(NSMutableArray*)playersForPosition:(Position)position
{
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* moc = [appDelegate managedObjectContext];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"BrewersPlayer" inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor* sortByName = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortByName]];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"position = %i", position];
    [fetchRequest setPredicate:predicate];
    
    NSError* error = nil;
    NSMutableArray* fetchResults = [NSMutableArray arrayWithArray:[moc executeFetchRequest:fetchRequest error:&error]];
    
    if(!fetchResults) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    } else if(fetchResults.count == 0 && ![[NSUserDefaults standardUserDefaults] boolForKey:OfflineMode]){
        // obtain players from web service
        fetchResults = [self playersFromWebServiceForPosition:position withMoc:moc];
    } else {
        if(![[NSUserDefaults standardUserDefaults] boolForKey:OfflineMode]) {
            [self removePlayersForPosition:position];
            fetchResults = [self playersFromWebServiceForPosition:position withMoc:moc];
        }
    }
    
    return fetchResults;
}

-(void)removePlayersForPosition:(Position)position
{
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* moc = [appDelegate managedObjectContext];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"BrewersPlayer" inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor* sortByName = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortByName]];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"position = %i", position];
    [fetchRequest setPredicate:predicate];
    
    NSError* error = nil;
    NSMutableArray* fetchResults = [NSMutableArray arrayWithArray:[moc executeFetchRequest:fetchRequest error:&error]];
    
    if(!fetchResults) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    for(BrewersPlayer* player in fetchResults) {
        [moc deleteObject:player];
    }
}

-(NSMutableArray*)playersFromWebServiceForPosition:(Position)position withMoc:(NSManagedObjectContext*)moc
{
    NSString* brewersPlayersURLString = @"http://api.cbssports.com/fantasy/players/search?SPORT=baseball&version=3.0&response_format=json&pro_team=MIL";
    
    NSString* brewersPlayersByPositionURLString = [brewersPlayersURLString stringByAppendingFormat:@"&position=%@", [BrewersPlayer identifierForPosition:position]];
    
    NSURL* brewersPlayersByPositionURL = [NSURL URLWithString:brewersPlayersByPositionURLString];
    NSData* data = [NSData dataWithContentsOfURL:brewersPlayersByPositionURL];
    
    // make dictionary from json response
    NSError* error = nil;
    NSDictionary* jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSDictionary* bodyDictionary = [jsonDictionary objectForKey:@"body"];
    NSArray* playerDictionaries = [bodyDictionary objectForKey:@"players"];
    
    BrewersPlayer* player;
    NSMutableArray* players = [[NSMutableArray alloc] init];
    for(NSDictionary* playerDictionary in playerDictionaries) {
        player = [NSEntityDescription insertNewObjectForEntityForName:@"BrewersPlayer" inManagedObjectContext:moc];
        player.firstName = [playerDictionary objectForKey:@"firstname"];
        player.lastName = [playerDictionary objectForKey:@"lastname"];
        player.position = [NSNumber numberWithInt:position];
        player.infoUrl = [@"http://www.cbssports.com/mlb/players/playerpage/" stringByAppendingString:[playerDictionary valueForKey:@"id"]];
        NSURL* headshotUrl = [NSURL URLWithString:[playerDictionary valueForKey:@"photo_url"]];
        player.headshot = [NSData dataWithContentsOfURL:headshotUrl];
        
        [players addObject:player];
    }
    
    return players;
}

@end
