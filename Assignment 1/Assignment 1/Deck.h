//
//  Deck.h
//  Assignment 1
//
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Card;

@interface Deck : NSObject

@property(nonatomic, strong, readonly) NSMutableArray* cards;

-(Card*)dealCard;
-(BOOL)hasCards;

@end
