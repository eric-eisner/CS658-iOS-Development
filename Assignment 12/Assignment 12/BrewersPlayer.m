//
//  BrewersPlayer.m
//  brewers
//
//  Created by Eric L Eisner on 4/20/14.
//  Copyright (c) 2014 Ryan Hardt. All rights reserved.
//

#import "BrewersPlayer.h"


@implementation BrewersPlayer

@dynamic firstName;
@dynamic headshot;
@dynamic infoUrl;
@dynamic lastName;
@dynamic position;

+(NSString*)nameForPosition:(Position)position
{
    if(position == STARTING_PITCHER) {
        return @"Starting Pitcher";
    } else if(position == RELIEF_PITCHER) {
        return @"Relief Pitcher";
    } else if(position == CATCHER) {
        return @"Catcher";
    } else if(position == FIRST_BASE) {
        return @"First Base";
    } else if(position == SECOND_BASE) {
        return @"Second Base";
    } else if(position == THIRD_BASE) {
        return @"Third Base";
    } else if(position == SHORTSTOP) {
        return @"Shortstop";
    } else if(position == LEFT_FIELD) {
        return @"Left Field";
    } else if(position == CENTER_FIELD) {
        return @"Center Field";
    } else if(position == RIGHT_FIELD) {
        return @"Right Field";
    } else {
        return @"None";
    }
}

+(NSString*)identifierForPosition:(Position)position
{
    if(position == STARTING_PITCHER) {
        return @"SP";
    } else if(position == RELIEF_PITCHER) {
        return @"RP";
    } else if(position == CATCHER) {
        return @"C";
    } else if(position == FIRST_BASE) {
        return @"1B";
    } else if(position == SECOND_BASE) {
        return @"2B";
    } else if(position == THIRD_BASE) {
        return @"3B";
    } else if(position == SHORTSTOP) {
        return @"SS";
    } else if(position == LEFT_FIELD) {
        return @"LF";
    } else if(position == CENTER_FIELD) {
        return @"CF";
    } else if(position == RIGHT_FIELD) {
        return @"RF";
    } else {
        return @"NA";
    }
}

-(NSString*)fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

@end
