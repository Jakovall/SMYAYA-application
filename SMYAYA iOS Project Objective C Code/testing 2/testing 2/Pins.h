//
//  Pins.h
//  SMYAYA V2
//
//  Created by Christopher Dollinger on 5/25/13.
//  Copyright (c) 2013 Christopher Dollinger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Pins : MKAnnotationView

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
