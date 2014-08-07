//
//  ViewController.m
//  Assignment 4
//
//  Created by Eric L Eisner on 2/18/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) CLPlacemark* placemark;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    self.geocoder = [[CLGeocoder alloc] init];
    [_label setText:@""];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)segControlChange:(id)sender
{
    if([_segControl selectedSegmentIndex] == 0) {
        [self.mapView setMapType:MKMapTypeStandard];
    }
    else if([_segControl selectedSegmentIndex] == 1) {
        [self.mapView setMapType:MKMapTypeSatellite];
    }
    else {
        [self.mapView setMapType:MKMapTypeHybrid];
    }
}

-(IBAction)buttonPress:(id)sender
{
    MapAnnotation* annotation = [[MapAnnotation alloc] initWithCoordinate:[_currentLocation coordinate] street:[_placemark name] city:[_placemark locality]];
    [_mapView addAnnotation:annotation];
}

- (void)reverseGeocodeLocation:(CLLocation*)location
{
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray* placemarks, NSError* error) {
        self.placemark = [placemarks objectAtIndex:0];
    }];
    [_label setText:[_placemark name]];
}

// MKMapViewDelegate
-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
}

// CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _currentLocation = [locations lastObject];
    [self reverseGeocodeLocation:_currentLocation];
}

@end
