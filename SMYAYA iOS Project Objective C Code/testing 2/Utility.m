//
//  Utility.m
//  SMYAYA
//
//  Created by chary on 10/09/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "Utility.h"
#import "SocialNetworkItem.h"

@implementation Utility

static NSMutableArray *networkItems;

NSString *street;

NSString *city;

NSString *country;

NSString *latitude;
NSString *longitude;

+(void)addStreet:(NSString*)data{
    
    street = data;
}
+(NSString*)getStreet{
    
    return street;
}


+(void)addCity:(NSString*)data{
    city =data;
    
}
+(NSString*)getCity{
    return city;
}

+(void)addCountry:(NSString*)data{
    
    country =data;
}
+(NSString*)getCountry{
    return country;
}

+(void)addLatitude:(NSString*)data{
    latitude= data;
}
+(NSString*)getLatitude{
    return latitude;
}

+(void)addLongitude:(NSString*)data{
    longitude =data;
}
+(NSString*)getLongitude{
    return  longitude;
}



-(void) adddata:(SocialNetworkItem*)data{
    if(networkItems == nil){
        networkItems = [[NSMutableArray alloc] init];
    }
    [networkItems addObject:data];
}

-(NSMutableArray*)getdataval{
    return networkItems;
}

@end
