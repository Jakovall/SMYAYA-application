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
