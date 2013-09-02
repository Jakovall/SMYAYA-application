//
//  SYEditGeoItemViewController.m
//  SMYAYA
//
//  Created by myeyesareblind on 9/2/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYEditGeoItemViewController.h"

@interface SYEditGeoItemViewController ()

@end

@implementation SYEditGeoItemViewController
@synthesize geoItem, editCompletedBlock;

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
    /*
     {
     geolat = "38.8976831";
     geolong = "-77.0364972";
     subtitle = "presidents residence";
     title = "white house";
     },
     */
    NSAssert(geoItem, @"no geoItem to edit");
//    _latitudeLabel.text     = geoItem[@"geolat"];
//    _longtitudeLabel.text   = geoItem[@"geolong"];
    _subtitleTextfield.text = geoItem[@"subtitle"];
    _titleTextfield.text    = geoItem[@"title"];
    self.title              = geoItem[@"title"];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSString* originSubtitle = geoItem[@"subtitle"];
    NSString* originTitle    = geoItem[@"title"];
    NSString* newTitle       = _titleTextfield.text;
    NSString* newSubtitle    = _subtitleTextfield.text;
    
    if (![originSubtitle isEqualToString:newSubtitle] || ![originTitle isEqualToString:newTitle]) {
        editCompletedBlock(newTitle, newSubtitle);
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
