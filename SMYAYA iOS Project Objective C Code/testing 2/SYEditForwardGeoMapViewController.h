//
//  SYEditForwardGeoMapViewController.h
//  SMYAYA
//
//  Created by chary on 17/09/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Geopin.h"
#import <CoreLocation/CoreLocation.h>

@interface SYEditForwardGeoMapViewController : UIViewController<MKMapViewDelegate> {
    CLGeocoder *_geocoder;
    IBOutlet MKMapView *geoPin;
}



@property (strong, nonatomic) IBOutlet MKMapView *geoPin;
@property (strong, nonatomic) NSString *street;
@property (strong, nonatomic)  NSString *city;
@property (strong, nonatomic)  NSString *country;
@property (strong, nonatomic)  NSString *addressTable;

@property (strong, nonatomic) NSString* latValue;
@property (strong, nonatomic) NSString* longValue;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (retain, nonatomic)IBOutlet UIActivityIndicatorView*  spinner;

- (IBAction)reviseGeoPin:(id)sender;

- (IBAction)acceptGeoPin:(id)sender;

@end
