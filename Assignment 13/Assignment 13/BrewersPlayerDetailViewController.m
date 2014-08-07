//
//  BrewersPlayerDetailViewController.m
//  Brewers
//
//  Created by Ryan Hardt on 3/17/14.
//  Copyright (c) 2014 Ryan Hardt. All rights reserved.
//

#import "BrewersPlayerDetailViewController.h"
#import "BrewersPlayer.h"
#import "BrewersPlayerWebViewController.h"
#import "BrewersSettingsTableViewController.h"
#import "BrewersHeadshot.h"
#import "Pitcher.h"
#import "PositionPlayer.h"

@interface BrewersPlayerDetailViewController ()

@end

@implementation BrewersPlayerDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = [self.player fullName];
    self.firstNameLabel.text = self.player.firstName;
    self.lastNameLabel.text = self.player.lastName;
    self.positionLabel.text = [BrewersPlayer nameForPosition:[self.player.position intValue]];
    
    BOOL isOfflineModeEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:isOfflineModeEnabledKey];
    if(isOfflineModeEnabled) {
        self.moreInfoButton.enabled = NO;
        self.unavailableLabel.hidden = NO;
    } else {
        if([self isPitcher]) {
            [self clearPitcherFields];
            [self getPlayerStats];
            [self setPitcherViewForPitcher:(Pitcher*)self.player];
        } else {
            [self clearPositionPlayerFields];
            [self getPlayerStats];
            [self setPositionPlayerViewForPositionPlayer:(PositionPlayer*)self.player];
        }
        self.moreInfoButton.enabled = YES;
    }
    NSData* imageData = [self.player.headshot data];
    UIImage* headshot = [UIImage imageWithData:imageData];
    self.headshotImageView.image = headshot;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)isPitcher
{
    if([self.player.position intValue] == STARTING_PITCHER || [self.player.position intValue] == RELIEF_PITCHER) {
        return YES;
    }
    return NO;
}

-(void)setPositionPlayerViewForPositionPlayer:(PositionPlayer*)player
{
    self.abLabel.hidden = NO;
    self.hrLabel.hidden = NO;
    self.avgLabel.hidden = NO;
    self.rbiLabel.hidden = NO;
    self.rLabel.hidden = NO;
    self.sbLabel.hidden = NO;
    self.abField.hidden = NO;
    self.abField.text = player.ab;
    self.hrField.hidden = NO;
    self.hrField.text = player.hr;
    self.avgField.hidden = NO;
    self.avgField.text = player.avg;
    self.rbiField.hidden = NO;
    self.rbiField.text = player.rbi;
    self.rField.hidden = NO;
    self.rField.text = player.r;
    self.sbField.hidden = NO;
    self.sbField.text = player.sb;
}

-(void)clearPositionPlayerFields
{
    self.abField.text = @"0";
    self.hrField.text = @"0";
    self.avgField.text = @"0.000";
    self.rbiField.text = @"0";
    self.rField.text = @"0";
    self.sbField.text = @"0";
}

-(void)setPitcherViewForPitcher:(Pitcher*)pitcher
{
    self.wLabel.hidden = NO;
    self.lLabel.hidden = NO;
    self.sLabel.hidden = NO;
    self.eraLabel.hidden = NO;
    self.kLabel.hidden = NO;
    self.bbLabel.hidden = NO;
    self.whipLabel.hidden = NO;
    self.wField.hidden = NO;
    self.wField.text = pitcher.wins;
    self.lField.hidden = NO;
    self.lField.text = pitcher.loses;
    self.sField.hidden = NO;
    self.sField.text = pitcher.saves;
    self.eraField.hidden = NO;
    self.eraField.text = pitcher.era;
    self.kField.hidden = NO;
    self.kField.text = pitcher.k;
    self.bbField.hidden = NO;
    self.bbField.text = pitcher.walks;
    self.whipField.hidden = NO;
    self.whipField.text = pitcher.whip;
}

-(void)clearPitcherFields
{
    self.wField.text = @"0";
    self.lField.text = @"0";
    self.sField.text = @"0";
    self.eraField.text = @"0.00";
    self.kField.text = @"0";
    self.bbField.text = @"0";
    self.whipField.text = @"0.00";
}

-(void)getPlayerStats
{
    if([self isPitcher]) {
        [self getStatisticsForPitcher:(Pitcher*)self.player];
    } else {
        [self getStatisticsForPositionPlayer:(PositionPlayer*)self.player];
    }
}

-(void)getStatisticsForPitcher:(Pitcher*)pitcher
{
    NSString* playerStatsURLString = [playerStatsBaseUrl stringByAppendingString:pitcher.playerId];
    
    NSURL* playerStatsURL = [NSURL URLWithString:playerStatsURLString];
    NSData* data = [NSData dataWithContentsOfURL:playerStatsURL];
    
    //Make a dictionary out of what just came back
    NSError* error = nil;
    NSDictionary* jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSDictionary* bodyDictionary = [jsonResponse objectForKey:@"body"];
    NSDictionary* playerStats = [bodyDictionary objectForKey:@"player_stats"];
    NSDictionary* stats = [playerStats objectForKey:pitcher.playerId];
    
    if([stats valueForKey:@"W"] != nil) {
        pitcher.wins = [stats valueForKey:@"W"];
    }
    if([stats valueForKey:@"L"] != nil) {
        pitcher.loses = [stats valueForKey:@"L"];
    }
    if([stats valueForKey:@"S"] != nil) {
        pitcher.saves = [stats valueForKey:@"S"];
    }
    if([stats valueForKey:@"ERA"] != nil) {
        pitcher.era = [NSString stringWithFormat:@"%.2f", [[stats valueForKey:@"ERA"] doubleValue]];
    }
    if([stats valueForKey:@"K"] != nil) {
        pitcher.k = [stats valueForKey:@"K"];
    }
    if([stats valueForKey:@"BBI"] != nil) {
        pitcher.walks = [stats valueForKey:@"BBI"];
    }
    if([stats valueForKey:@"WHIP"] != nil) {
        pitcher.whip = [NSString stringWithFormat:@"%.2f", [[stats valueForKey:@"WHIP"] doubleValue]];
    }
    
    if(error) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
}

-(void)getStatisticsForPositionPlayer:(PositionPlayer*)player
{
    NSString* playerStatsURLString = [playerStatsBaseUrl stringByAppendingString:player.playerId];
    
    NSURL* playerStatsURL = [NSURL URLWithString:playerStatsURLString];
    NSData* data = [NSData dataWithContentsOfURL:playerStatsURL];
    
    //Make a dictionary out of what just came back
    NSError* error = nil;
    NSDictionary* jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSDictionary* bodyDictionary = [jsonResponse objectForKey:@"body"];
    NSDictionary* playerStats = [bodyDictionary objectForKey:@"player_stats"];
    NSDictionary* stats = [playerStats objectForKey:player.playerId];
    
    if([stats valueForKey:@"AB"] != nil) {
        player.ab = [stats valueForKey:@"AB"];
    }
    if([stats valueForKey:@"HR"] != nil) {
        player.hr = [stats valueForKey:@"HR"];
    }
    if([stats valueForKey:@"BA"] != nil) {
        player.avg = [NSString stringWithFormat:@"%.3f", [[stats valueForKey:@"BA"] doubleValue]];
    }
    if([stats valueForKey:@"RBI"] != nil) {
        player.rbi = [stats valueForKey:@"RBI"];
    }
    if([stats valueForKey:@"R"] != nil) {
        player.r = [stats valueForKey:@"R"];
    }
    if([stats valueForKey:@"SB"] != nil) {
        player.sb = [stats valueForKey:@"SB"];
    }
    
    if(error) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"moreInfoSegue"]) {
        BrewersPlayerWebViewController* dest = [segue destinationViewController];
        dest.url = [playerInfoBaseUrl stringByAppendingString:self.player.playerId];
    }
}

@end
