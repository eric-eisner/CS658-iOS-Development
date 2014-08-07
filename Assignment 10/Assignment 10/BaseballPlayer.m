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

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self) {
        _firstName = [aDecoder decodeObjectForKey:@"firstname"];
        _lastName = [aDecoder decodeObjectForKey:@"lastname"];
        _position = [aDecoder decodeObjectForKey:@"position"];
        _url = [aDecoder decodeObjectForKey:@"url"];
        _headshotUrl = [aDecoder decodeObjectForKey:@"headshot"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.firstName forKey:@"firstname"];
    [aCoder encodeObject:self.lastName forKey:@"lastname"];
    [aCoder encodeObject:self.position forKey:@"position"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.headshotUrl forKey:@"headshot"];
}

@end
