//
//  SYEditHomeItemsTableViewController.h
//  SMYAYA
//
//  Created by myeyesareblind on 8/30/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SYDismissBlock)();
@interface SYEditHomeItemsTableViewController : UITableViewController

@property (strong, readwrite) NSArray*          menuItems;
@property (readwrite,   copy) SYDismissBlock    dismissBlock;

@end
