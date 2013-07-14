//
//  ViewController.m
//  SMYAYA V2
//
//  Created by Christopher Dollinger on 5/25/13.
//  Copyright (c) 2013 Christopher Dollinger. All rights reserved.
//

#import "smyayaViewController.h"

@interface smyayaViewController ()

@end

//Building coordinates
#define QOTW_LAT 41.420337;
#define QOTW_LONG -78.549356;

#define SCRDHRT_LAT 41.426532;
#define SCRDHRT_LONG -78.564973;

#define SMCCH_LAT 41.429222;
#define SMCCH_LONG -78.568919;

#define ICAFE_LAT 41.426831;
#define ICAFE_LONG -78.567252;

#define ECCHS_LAT 41.427745;
#define ECCHS_LONG -78.572034;

#define CHAP_LAT 41.398687;
#define CHAP_LONG -78.560894;

#define SPAN 0.05f;
@implementation smyayaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    MKCoordinateRegion startupRegion;
    
    CLLocationCoordinate2D center;
    center.latitude = 41.427926;
    center.longitude = -78.561001;
    
    MKCoordinateSpan span;
    span.latitudeDelta = SPAN;
    span.longitudeDelta = SPAN;
    
    startupRegion.center = center;
    startupRegion.span = span;
    
    [self.pinSetter setRegion:startupRegion animated:YES];
    
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    CLLocationCoordinate2D location;
    Pins *pinGroup;
    
    pinGroup = [[Pins alloc]init];
    location.latitude = QOTW_LAT;
    location.longitude = QOTW_LONG;
    pinGroup.coordinate = location;
    pinGroup.title = @"Queen of the World Church";
    pinGroup.subtitle = @"134 Queens Rd, St Marys, PA";
    [locations addObject:pinGroup];
    
    pinGroup = [[Pins alloc]init];
    location.latitude = SCRDHRT_LAT;
    location.longitude = SCRDHRT_LONG;
    pinGroup.coordinate = location;
    pinGroup.title = @"Sacred Heart Church";
    pinGroup.subtitle = @"337 Center Street, St Marys, PA";
    [locations addObject:pinGroup];
    
    pinGroup = [[Pins alloc]init];
    location.latitude = SMCCH_LAT;
    location.longitude = SMCCH_LONG;
    pinGroup.coordinate = location;
    pinGroup.title = @"Saint Marys Church";
    pinGroup.subtitle = @"315 Church Street, St Marys, PA";
    [locations addObject:pinGroup];
    
    pinGroup = [[Pins alloc]init];
    location.latitude = ICAFE_LAT;
    location.longitude = ICAFE_LONG;
    pinGroup.coordinate = location;
    pinGroup.title = @"iCafe";
    pinGroup.subtitle = @"139 Church Street, St Marys, PA";
    [locations addObject:pinGroup];
    
    pinGroup = [[Pins alloc]init];
    location.latitude = ECCHS_LAT;
    location.longitude = ECCHS_LONG;
    pinGroup.coordinate = location;
    pinGroup.title = @"Elk County Catholic High School";
    pinGroup.subtitle = @"600 Maurus Streey, St Marys, PA";
    [locations addObject:pinGroup];
    
    pinGroup = [[Pins alloc]init];
    location.latitude = CHAP_LAT;
    location.longitude = CHAP_LONG;
    pinGroup.coordinate = location;
    pinGroup.title = @"Decker's Chapel";
    pinGroup.subtitle = @"Million Dollar Highway, St Marys, PA";
    [locations addObject:pinGroup];
    
    
    [self.pinSetter addAnnotations:locations];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
