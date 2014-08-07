//
//  Table.m
//  Assignment 1
//
//  Created by Eric L Eisner on 1/28/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "Table.h"

@implementation Table

-(id)init
{
    self = [super init];
    if(self) {
        _cards = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addCard:(Card*)card
{
    //NSLog(@"%@", card);
    [_cards addObject:card];
}

-(NSMutableArray*)removeCards
{
    NSMutableArray* toReturn = [[NSMutableArray alloc] init];
    toReturn = [_cards copy];
    [self clearTable];
    //NSLog(@"%@ ", toReturn);
    return toReturn;
}

-(void)clearTable
{
    [_cards removeAllObjects];
}

-(void)logTable
{
    NSLog(@"Table has:\n");
    for(int i = 0; i < [_cards count]; ++i) {
        NSLog(@"\t%@", [_cards objectAtIndex:i]);
    }
    NSLog(@"\n");
}

@end
