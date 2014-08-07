//
//  Table.h
//  Assignment 1
//
//  Created by Eric L Eisner on 1/28/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Card;

@interface Table : NSObject

@property(nonatomic, strong) NSMutableArray* cards;

-(void)addCard:(Card*)card;
-(NSMutableArray*)removeCards;
-(void)clearTable;
-(void)logTable;

@end
