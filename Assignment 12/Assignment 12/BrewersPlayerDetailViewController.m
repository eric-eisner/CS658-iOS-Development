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
#import "BrewersPositionTableViewController.h"

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
    if(self.player.infoUrl == nil || [self.player.infoUrl isEqualToString:@""] || [[NSUserDefaults standardUserDefaults] boolForKey:OfflineMode]) {
        self.moreInfoButton.enabled = NO;
    } else {
        self.moreInfoButton.enabled = YES;
    }
    
    UIImage* headshot = [UIImage imageWithData:self.player.headshot];
    self.headshotImageView.image = headshot;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"moreInfoSegue"]) {
        BrewersPlayerWebViewController* dest = [segue destinationViewController];
        dest.url = self.player.infoUrl;
    }
}

@end
