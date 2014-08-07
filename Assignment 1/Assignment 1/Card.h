//
//  Card.h
//  Assignment 1
//
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {Clubs, Diamonds, Hearts, Spades} Suit;

@interface Card : NSObject

@property(nonatomic) int value;
@property(nonatomic) Suit suit;


@end
