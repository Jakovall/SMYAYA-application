//
//  SYEditGeoItemViewController.h
//  SMYAYA
//
//  Created by myeyesareblind on 9/2/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYEditGeoItemViewController : UIViewController {
    
    __weak IBOutlet UITextField *_titleTextfield;
    __weak IBOutlet UITextField *_subtitleTextfield;
}

@property (readwrite, copy) void(^cancelBlock)();
@property (readwrite, strong) NSDictionary* geoItem;
@property (readwrite, copy)   void(^editCompletedBlock)(NSString* newTitleText, NSString* newSubtitle);


@end

