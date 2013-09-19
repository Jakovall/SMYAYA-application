//
//  SYDataProvider.m
//  SMYAYA
//
//  Created by myeyesareblind on 9/1/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYDataProvider.h"

@interface SYDataProvider ()
-(NSString*)themePath;

@end

@implementation SYDataProvider


static NSMutableArray *Geolocations;

+(instancetype)sharedDataProvider {
    static dispatch_once_t onceToken;
    static SYDataProvider* sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SYDataProvider alloc] init];
    });
    return sharedInstance;
}


- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}


-(NSString*)themePath {
    NSArray *docsDirect = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [docsDirect objectAtIndex:0];
    NSString *themePath = [NSString stringWithFormat:@"%@/%@", docsPath, @"Theme1.zip"];
    return themePath;
}


-(NSArray*)menuItems {
    NSString *themePath = [self themePath];
    NSString *menuPath  = [NSString stringWithFormat:@"%@/%@", themePath, @"menuItems.json"];
    NSData *jsonData    = [[NSData alloc] initWithContentsOfFile:menuPath];
    if (! jsonData.length) {
        return nil;
    }
    NSDictionary *menuDiction = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return [menuDiction objectForKey:@"menuitems"];
}


-(NSArray*)geoItems {
    NSString* themePath = [self themePath];
    NSString* geoPath = [themePath stringByAppendingPathComponent:@"geo.json"];
    NSData *myData = [[NSData alloc]initWithContentsOfFile:geoPath]; //takes the data from the file in the "FeedURLPath" directory
    NSDictionary *myJSON = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil]; //makes a dictionary (kinda like an array ({}) using the data from "myData")
    if(Geolocations == nil){
        NSLog(@"sdafadsf");
        Geolocations = [[NSMutableArray alloc]init];
      Geolocations = [myJSON objectForKey:@"geolocations"]; //makes a multidimensional array using one of the arra
    }
    return Geolocations;
}

+(void)addGeolocations:(NSMutableArray*)data{
    
    [Geolocations addObject:data];
}
+(NSMutableArray*)getGeolocations{
    
    return Geolocations;
}

+(void)removeGeolocations:(NSIndexPath*)indexpath{
    
    [Geolocations removeObjectAtIndex:indexpath.row];
}


-(NSString*)title {
    return nil;
}


-(NSURL*)nowURL {
    NSString *URLString = [[NSUserDefaults standardUserDefaults] valueForKey:@"NewsURL"];
    NSURL *url = [NSURL URLWithString:URLString];
    return url;
}

@end
