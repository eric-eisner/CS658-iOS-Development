//
//  MapAnnotation.h
//  Assignment 4
//
//  Created by Eric L Eisner on 2/18/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapAnnotation : NSObject <MKAnnotation>

@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString* title;
@property(nonatomic, copy) NSString* subtitle;

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
                 street:(NSString*)street
                   city:(NSString*)city;
-(id)init;

@end
