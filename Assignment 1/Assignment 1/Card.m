//
//  Card.m
//  Assignment 1
//
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "Card.h"

@implementation Card

-(NSString*)description
{
    return [NSString stringWithFormat:@"%@ of %@", [self nameForValue], [self nameForSuit]];
}

-(NSString*)nameForValue
{
    if(_value < 10) {
        return [NSString stringWithFormat:@"%d", _value];
    } else if(_value == 11) {
        return @"Jack";
    } else if (_value == 12) {
        return @"Queen";
    } else if (_value == 13) {
        return @"King";
    } else {
        return @"Ace";
    }
}

-(NSString*)nameForSuit
{
    if(_suit == Clubs) {
        return @"Clubs";
    } else if(_suit == Diamonds) {
        return @"Diamonds";
    } else if(_suit == Hearts) {
        return @"Hearts";
    } else {
        return @"Spades";
    }
}

@end
