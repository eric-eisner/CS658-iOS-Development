//
//  ViewController.h
//  Assignment 4
//
//  Created by Eric L Eisner on 2/18/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapAnnotation.h"

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property(nonatomic, weak) IBOutlet UILabel* label;
@property(nonatomic, weak) IBOutlet UIButton* button;
@property(nonatomic, weak) IBOutlet UISegmentedControl* segControl;
@property(nonatomic, weak) IBOutlet MKMapView* mapView;
@property(nonatomic, strong) CLLocationManager* locationManager;
@property(nonatomic, strong) CLLocation* currentLocation;
@property(nonatomic, strong) CLGeocoder* geocoder;

-(IBAction)segControlChange:(id)sender;
-(IBAction)buttonPress:(id)sender;

@end
