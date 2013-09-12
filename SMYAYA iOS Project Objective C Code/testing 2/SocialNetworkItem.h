//
//  SocialNetworkItem.h
//  SMYAYA
//
//  Created by chary on 10/09/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocialNetworkItem : NSObject{
    
    NSString* username;
    NSString* network;
}
@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* network;


@end
