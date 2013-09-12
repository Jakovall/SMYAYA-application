//
//  SYEditAddSocialNetworkViewController.h
//  SMYAYA
//
//  Created by myeyesareblind on 9/3/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYTextFieldCell.h"
#import "Utility.h"

@interface SYEditAddSocialNetworkViewController : UITableViewController{
    
    UIButton* plusButton;
    SYTextFieldCell* textFieldCell;
    NSString* networkSelected;
    NSMutableArray* uarray;
    Utility* networkItems;
}
@property (readwrite, copy) void(^cancelBlock)();
@end
