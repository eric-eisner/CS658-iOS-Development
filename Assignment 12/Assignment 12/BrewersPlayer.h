//
//  BrewersPlayer.h
//  brewers
//
//  Created by Eric L Eisner on 4/20/14.
//  Copyright (c) 2014 Ryan Hardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum{
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
@property (nonatomic, retain) NSData * headshot;
@property (nonatomic, retain) NSString * infoUrl;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * position;

+(NSString*)nameForPosition:(Position)position;
+(NSString*)identifierForPosition:(Position)position;
-(NSString*)fullName;

@end
