//
//  Deck.m
//  Assignment 1
//
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "Deck.h"
#import "Card.h"

@implementation Deck

-(id)init
{
    self = [super init];
    if(self) {
        _cards = [[NSMutableArray alloc] init];
        [self initializeCards];
        [self shuffleCards];
    }
    return self;
}

-(Card*)dealCard
{
    Card* card = [_cards objectAtIndex:0];
    [_cards removeObjectAtIndex:0];
    return card;
}

-(BOOL)hasCards
{
    return [_cards count] > 0;
}

-(void)initializeCards
{
    Card* card;
    for (int i=2; i<15; ++i) {
        for (int j=0; j<4; ++j) {
            card = [[Card alloc] init];
            [card setValue:i];
            [card setSuit:j];
            [_cards addObject:card];
        }
    }
}

-(void)shuffleCards
{
    Card* card;
    for (int i=0; i<1000; ++i) {
        NSUInteger first = arc4random_uniform((int) [_cards count]);
        NSUInteger second = arc4random_uniform((int) [_cards count]);
        card = [_cards objectAtIndex:first];
        
        [_cards setObject:[_cards objectAtIndex:second] atIndexedSubscript:first];
        [_cards setObject:card atIndexedSubscript:second];
    }
}

@end
