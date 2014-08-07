//
//  Pitcher.h
//  Assignment 13
//
//  Created by Eric L Eisner on 5/2/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BrewersPlayer.h"


@interface Pitcher : BrewersPlayer

@property (nonatomic, retain) NSString * walks;
@property (nonatomic, retain) NSString * era;
@property (nonatomic, retain) NSString * k;
@property (nonatomic, retain) NSString * loses;
@property (nonatomic, retain) NSString * saves;
@property (nonatomic, retain) NSString * whip;
@property (nonatomic, retain) NSString * wins;

@end
