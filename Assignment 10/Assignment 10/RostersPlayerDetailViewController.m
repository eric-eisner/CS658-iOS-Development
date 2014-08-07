//
//  RostersPlayerDetailViewController.m
//  Rosters
//
//  Created by Eric L Eisner on 3/30/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "RostersPlayerDetailViewController.h"
#import "BaseballPlayer.h"
#import "RostersAddEditPlayerViewController.h"
#import "RostersPlayerWebViewController.h"

@interface RostersPlayerDetailViewController ()

@end

@implementation RostersPlayerDetailViewController

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
    self.firstNameLabel.text = self.player.firstName;
    self.lastNameLabel.text = self.player.lastName;
    self.positionLabel.text = self.player.position;
    if(self.player.url == nil || [self.player.url isEqualToString:@""]) {
        self.moreInfoButton.enabled = NO;
    } else {
        self.moreInfoButton.enabled = YES;
    }
    if(self.player.headshotUrl == nil || [self.player.headshotUrl isEqualToString:@""]) {
        NSString* headshotImagePath = [[NSBundle mainBundle] pathForResource:@"unknown_hat" ofType:@"gif"];
        self.headshotImageView.image = [[UIImage alloc] initWithContentsOfFile:headshotImagePath];
    } else {
        NSURL* url = [NSURL URLWithString:self.player.headshotUrl];
        self.headshotImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"editPlayerSegue"]) {
        RostersAddEditPlayerViewController* dest = [segue destinationViewController];
        dest.player = self.player;
    } else if ([segue.identifier isEqualToString:@"moreInfoSegue"]) {
        RostersPlayerWebViewController* dest = [segue destinationViewController];
        dest.playerUrl = self.player.url;
    }
}

@end
