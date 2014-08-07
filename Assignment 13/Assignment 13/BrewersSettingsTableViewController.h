//
//  BrewersSettingsTableViewController.h
//  brewers
//
//  Created by Ryan Hardt on 4/10/14.
//  Copyright (c) 2014 Ryan Hardt. All rights reserved.
//

#import <UIKit/UIKit.h>

#define isOfflineModeEnabledKey @"isOfflineModeEnabledKey"

@protocol BrewersSettingsDelegate <NSObject>
-(void)retrieveAllPlayerData;
@end

@interface BrewersSettingsTableViewController : UITableViewController

@property(nonatomic, weak) IBOutlet UISwitch* isOfflineModeEnabledSwitch;
@property(nonatomic, weak) IBOutlet UIButton* refreshPlayersButton;
@property(nonatomic, weak) id<BrewersSettingsDelegate> delegate;
@property(nonatomic) BOOL didRetrieveAllPlayerData;

-(IBAction)switchToggled;
-(IBAction)refreshPlayersButtonPressed;

@end
