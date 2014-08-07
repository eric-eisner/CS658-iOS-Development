//
//  RostersEditPlayerViewController.h
//  Rosters
//
//  Created by Eric L Eisner on 3/30/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseballPlayer;

@protocol RostersAddPlayerDelegate <NSObject>
-(void)doneAddPlayer;
-(void)cancelAddPlayer;
@optional

@end

@interface RostersAddEditPlayerViewController : UIViewController <UITextFieldDelegate>

@property(nonatomic, weak) IBOutlet UITextField* firstNameTextField;
@property(nonatomic, weak) IBOutlet UITextField* lastNameTextField;
@property(nonatomic, weak) IBOutlet UILabel* positionLabel;
@property(nonatomic, weak) IBOutlet UITextField* urlTextField;
@property(nonatomic, weak) BaseballPlayer* player;
@property(nonatomic, weak) id <RostersAddPlayerDelegate> delegate;

-(IBAction)cancel;
-(IBAction)done;

@end
