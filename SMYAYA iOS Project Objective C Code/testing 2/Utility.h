//
//  Utility.h
//  SMYAYA
//
//  Created by chary on 10/09/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocialNetworkItem.h"

@interface Utility : NSObject


-(void)adddata:(SocialNetworkItem*)data;
-(NSMutableArray*)getdataval;

+(void)addStreet:(NSString*)data;
+(NSString*)getStreet;

+(void)addCity:(NSString*)data;
+(NSString*)getCity;

+(void)addCountry:(NSString*)data;
+(NSString*)getCountry;

+(void)addLatitude:(NSString*)data;
+(NSString*)getLatitude;

+(void)addLongitude:(NSString*)data;
+(NSString*)getLongitude;

@end
