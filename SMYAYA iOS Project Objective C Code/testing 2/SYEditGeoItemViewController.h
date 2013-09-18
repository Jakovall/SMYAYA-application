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

@property (readwrite, strong) NSString* street;
@property (readwrite, strong) NSString* city;
@property (readwrite, strong) NSString* country;
@property (readwrite, strong) NSString* latitude;
@property (readwrite, strong) NSString* longitude;

@property (readwrite, strong) IBOutlet UITextView* addressInfo;
@property (readwrite, strong) IBOutlet UITableView* tableViews;
@property (readwrite, strong)UITextField* titles;
@property (readwrite, strong)UITextField*  subTitle;


@end

