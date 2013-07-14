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

#define SPAN 0.05f;

@implementation smyayaViewController

@synthesize pinSetter;

NSArray *docDirect;
NSString *docPath;
NSString *themePath;
NSString *geoPath;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
    docDirect = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //document directory
    docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]; //document path
    themePath = [NSString stringWithFormat:@"%@/%@", docPath, @"Theme1.zip"];
    geoPath = [NSString stringWithFormat:@"%@/%@", themePath, @"geo.json"];

    if ([[NSFileManager defaultManager] fileExistsAtPath:geoPath] == YES)
    {
        NSData *myData = [[NSData alloc]initWithContentsOfFile:geoPath]; //takes the data from the file in the "FeedURLPath" directory
        NSDictionary *myJSON = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil]; //makes a dictionary (kinda like an array ({}) using the data from "myData")
        NSArray *Geolocations = [myJSON objectForKey:@"geolocations"]; //makes a multidimensional array using one of the arrays from the JSON file
        NSArray *jsonArray = (NSArray *)Geolocations; //necessary, for some reason
        NSLog(@"%i", [jsonArray count]); //outputs the number of arrays in "jsonArray"

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

        [pinSetter removeAnnotations:pinSetter.annotations];

        for (int counter = 0; counter < [Geolocations count]; counter++)
        {
        NSDictionary *InGeolocations = [Geolocations objectAtIndex:counter];

        pinGroup = [[Pins alloc] init];
        location.latitude = [[InGeolocations objectForKey:@"geolat"] doubleValue];
        location.longitude = [[InGeolocations objectForKey:@"geolong"] doubleValue];
        pinGroup.coordinate = location;
        pinGroup.title = [InGeolocations objectForKey:@"title"];
        pinGroup.subtitle = [InGeolocations objectForKey:@"subtitle"];
        [locations addObject:pinGroup];

        }

        [self.pinSetter addAnnotations:locations];
    }



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary    *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    //process the JSON Foundation object to the view.
    [self processData:json];
} */

/*-(void)processData:(NSDictionary *) JSONObject{
    NSString        *AppBgColor = [JSONObject valueForKey:@"AppBgColor"];
    NSString        *AppName    = [JSONObject valueForKey:@"AppName"];
    NSString        *AppVersion = [JSONObject valueForKey:@"AppVersion"];
    NSString        *developerName =[JSONObject valueForKey:@"developerName"];
    NSString        *contact =[JSONObject valueForKey:@"contact"];
    NSLog(@"AppBgColor: %@", AppBgColor);
    NSLog(@"AppName: %@", AppName);
    NSLog(@"AppVersion: %@",AppVersion);
    NSLog(@"developerName: %@",developerName);
    NSLog(@"contact: %@",contact);
    AppBgColorLabel.text =AppBgColor;
    AppNameLabel.text =AppName;
    AppVersionLabel.text = AppVersion;
    developerNameLabel.text=developerName;
    contactLabel.text=contact;
    self.view.backgroundColor =[UIColor greenColor];
} */

@end
