//
//  BrewersSettingsTableViewController.h
//  Assignment 12
//
//  Created by Eric L Eisner on 4/22/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BrewersSettings <NSObject>

-(void)settingsDidChange;
-(void)refreshPlayers;

@end

@interface BrewersSettingsTableViewController : UITableViewController

@property(nonatomic, weak) IBOutlet UISwitch* offlineModeSwitch;
@property(nonatomic, weak) IBOutlet UIButton* refreshPlayersButton;
@property(nonatomic, retain) id<BrewersSettings> delegate;

-(IBAction)switchChangedState;
-(IBAction)refreshPlayers;

@end
