//
//  Player.m
//  Assignment 1
//
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "Player.h"

@implementation Player

-(id)init
{
    self = [super init];
    if(self) {
        _hand = [[NSMutableArray alloc] init];
        //[self setHand:[[NSMutableArray alloc] init]];
    }
    return self;
}

-(void)addCard:(Card*)card
{
    [_hand addObject:card];
}

-(void)addCards:(NSMutableArray*)cards
{
    [_hand addObjectsFromArray:cards];
}

-(Card*)getNextCard
{
    Card* card = [_hand objectAtIndex:0];
    [_hand removeObjectAtIndex:0];
    return card;
}

-(BOOL)hasCards
{
    return [_hand count] > 0;
}

-(int)numCards
{
    return (int)[_hand count];
}

-(NSString*)description
{
    return _name;
}

@end
