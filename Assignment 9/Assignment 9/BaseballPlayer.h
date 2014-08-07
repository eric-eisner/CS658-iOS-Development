//
//  BaseballPlayer.h
//  Rosters
//
//  Created by Eric L Eisner on 3/30/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseballPlayer : NSObject

@property(nonatomic, strong) NSString* firstName;
@property(nonatomic, strong) NSString* lastName;
@property(nonatomic, strong) NSString* position;
@property(nonatomic, strong) NSString* url;

-(id)init;
-(id)initWithFirstName:(NSString*)firstName lastName:(NSString*)lastName position:(NSString*)position;
-(NSString*)fullName;

@end
