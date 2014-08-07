//
//  MapAnnotation.m
//  Assignment 4
//
//  Created by Eric L Eisner on 2/18/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
                 street:(NSString*)street
                   city:(NSString*)city
{
    self = [super init];
    if(self){
        _coordinate = coordinate;
        _title = street;
        _subtitle = city;
    }
    return self;
}

-(id)init
{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(43.0758,-87.88628) street:@"Cramer" city:@"Milwaukee"];
}

@end
