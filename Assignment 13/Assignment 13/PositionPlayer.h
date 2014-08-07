//
//  PositionPlayer.h
//  Assignment 13
//
//  Created by Eric L Eisner on 5/2/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BrewersPlayer.h"


@interface PositionPlayer : BrewersPlayer

@property (nonatomic, retain) NSString * ab;
@property (nonatomic, retain) NSString * avg;
@property (nonatomic, retain) NSString * hr;
@property (nonatomic, retain) NSString * r;
@property (nonatomic, retain) NSString * rbi;
@property (nonatomic, retain) NSString * sb;

@end
