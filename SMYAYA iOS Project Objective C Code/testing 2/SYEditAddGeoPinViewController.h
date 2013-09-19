//
//  SYEditAddGeoPinViewController.h
//  SMYAYA
//
//  Created by chary on 12/09/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Geopin.h"
#import <CoreLocation/CoreLocation.h>

@interface SYEditAddGeoPinViewController : UIViewController<MKMapViewDelegate,UITextFieldDelegate> {
    CLGeocoder *_geocoder;
    IBOutlet MKMapView *geoPin;
    UIButton *dot;
}
- (IBAction)showGeoLocation:(id)sender;

- (IBAction)cancelGeoPin:(id)sender;

- (IBAction)saveGeoPin:(id)sender;

@property (strong, nonatomic) IBOutlet MKMapView *geoPin;
@property (strong, nonatomic) IBOutlet UITextField *street;
@property (strong, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutlet UITextField *country;
@property (strong, nonatomic) IBOutlet UITableView *addressTable;

@property (strong, nonatomic) NSString* latValue;
@property (strong, nonatomic) NSString* longValue;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (retain, nonatomic)IBOutlet UIActivityIndicatorView*  spinner;



@end
