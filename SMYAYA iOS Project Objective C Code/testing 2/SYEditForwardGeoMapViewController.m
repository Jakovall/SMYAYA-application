//
//  SYEditForwardGeoMapViewController.m
//  SMYAYA
//
//  Created by chary on 17/09/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYEditForwardGeoMapViewController.h"
#import "Utility.h"
#import "SYEditGeoItemViewController.h"
#define SPAN 0.2f;


@interface SYEditForwardGeoMapViewController ()

@end

@implementation SYEditForwardGeoMapViewController
@synthesize geoPin,street,city,country,latValue,longValue;
@synthesize geocoder = _geocoder,addressTable,spinner;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"string value is %@",[Utility getStreet]);
    street = [Utility getStreet];
    country = [Utility getCountry];
    city = [Utility getCity];
    
    latValue = @"";
    longValue = @"";
    
    spinner.hidden =YES;
    [self showGeoLocation];
}


-(void)showGeoLocation{

     [spinner setHidden:NO];
     [spinner startAnimating];
     
     if (!self.geocoder) {
     self.geocoder = [[CLGeocoder alloc] init];
     }
     NSString *address = [NSString stringWithFormat:@"%@ %@ %@", street, city, country];
     
     [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
     if ([placemarks count] > 0) {
     CLPlacemark *placemark = [placemarks objectAtIndex:0];
     CLLocation *location = placemark.location;
     CLLocationCoordinate2D center = location.coordinate;
     latValue = [NSString stringWithFormat:@"%f", center.latitude];
     longValue = [NSString stringWithFormat:@"%f", center.longitude];
     MKCoordinateRegion startupRegion;
     
     MKCoordinateSpan span;
     span.latitudeDelta = SPAN;
     span.longitudeDelta = SPAN;
     
     startupRegion.center = center;
     startupRegion.span = span;
     [self.geoPin setMapType:MKMapTypeStandard];
     [self.geoPin setRegion:startupRegion animated:YES];
     [self.geoPin regionThatFits:startupRegion];
     
     Geopin *addAnnotation = [[Geopin alloc] init];
     addAnnotation.title = street;
     addAnnotation.subtitle = city;
     addAnnotation.coordinate = center;
     [self.geoPin addAnnotation:addAnnotation];
     [spinner setHidden:YES];
     [spinner stopAnimating];
     
     }else{
     [spinner setHidden:YES];
     [spinner stopAnimating];
     UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Sorry! No placemark found." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
     [alertView show];
     
     
     }
     }];
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == 1) {
		//OK clicked
	} else {
	}
}

- (IBAction)reviseGeoPin:(id)sender{
    
    [Utility addStreet:@""];
    [Utility addCity:@""];
    [Utility addCountry:@""];
    [Utility addLatitude:@""];
    [Utility addLongitude:@""];
    [self dismissViewControllerAnimated:YES
                             completion:nil];
   
}

- (IBAction)acceptGeoPin:(id)sender{
    
    [Utility addLatitude:latValue];
    [Utility addLongitude:longValue];
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
