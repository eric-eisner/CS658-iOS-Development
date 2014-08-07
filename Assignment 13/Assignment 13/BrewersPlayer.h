//
//  BrewersPlayer.h
//  Assignment 13
//
//  Created by Eric L Eisner on 5/1/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class BrewersHeadshot;

#define playerInfoBaseUrl @"http://www.cbssports.com/mlb/players/playerpage/"
#define playerStatsBaseUrl @"http://api.cbssports.com/fantasy/stats?version=3.0&SPORT=baseball&timeframe=2014&period=season&response_format=json&player_id="

typedef enum {
    NONE,
    STARTING_PITCHER,
    RELIEF_PITCHER,
    CATCHER,
    FIRST_BASE,
    SECOND_BASE,
    THIRD_BASE,
    SHORTSTOP,
    LEFT_FIELD,
    CENTER_FIELD,
    RIGHT_FIELD
} Position;

@interface BrewersPlayer : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSString * playerId;
@property (nonatomic, retain) BrewersHeadshot *headshot;

+(NSString*)nameForPosition:(Position)position;
+(NSString*)identifierForPosition:(Position)position;
-(NSString*)fullName;

@end