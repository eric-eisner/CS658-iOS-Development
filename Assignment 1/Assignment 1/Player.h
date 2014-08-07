//
//  Player.h
//  Assignment 1
//
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Card;

@interface Player : NSObject

@property(nonatomic, strong) NSString* name;
@property(nonatomic, strong, readonly) NSMutableArray* hand;

-(void)addCard:(Card*)card;
-(void)addCards:(NSMutableArray*)cards;
-(Card*)getNextCard;
-(BOOL)hasCards;
-(int)numCards;

@end
