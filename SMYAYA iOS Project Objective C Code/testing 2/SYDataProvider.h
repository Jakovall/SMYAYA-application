//
//  SYDataProvider.h
//  SMYAYA
//
//  Created by myeyesareblind on 9/1/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYDataProvider : NSObject
+(instancetype)sharedDataProvider;


@property (readonly) NSArray*   menuItems;
@property (readonly) NSArray*   geoItems;
@property (readonly) NSString*  title;
@property (readonly) NSURL*     nowURL;


@end
