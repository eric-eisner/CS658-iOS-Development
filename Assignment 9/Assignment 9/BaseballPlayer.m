//
//  BaseballPlayer.m
//  Rosters
//
//  Created by Eric L Eisner on 3/30/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "BaseballPlayer.h"

@implementation BaseballPlayer

-(id)init
{
    return [self initWithFirstName:@"" lastName:@"" position:@""];
}

-(id)initWithFirstName:(NSString*)firstName lastName:(NSString*)lastName position:(NSString*)position
{
    self = [super init];
    if(self) {
        _firstName = firstName;
        _lastName = lastName;
        _position = position;
    }
    return self;
}

-(NSString*)fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

@end
