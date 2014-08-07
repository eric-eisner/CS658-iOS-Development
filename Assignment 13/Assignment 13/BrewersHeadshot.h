//
//  BrewersHeadshot.h
//  brewers
//
//  Created by Eric L Eisner on 4/29/14.
//  Copyright (c) 2014 Ryan Hardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class BrewersPlayer;

#define noHeadshotURL @"http://sports.cbsimg.net/images/players/unknown_hat.gif"

@interface BrewersHeadshot : NSManagedObject

@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSSet *players;
@end

@interface BrewersHeadshot (CoreDataGeneratedAccessors)

- (void)addPlayersObject:(BrewersPlayer *)value;
- (void)removePlayersObject:(BrewersPlayer *)value;
- (void)addPlayers:(NSSet *)values;
- (void)removePlayers:(NSSet *)values;

@end
