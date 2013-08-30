//
//  STEditItemViewController.h
//  SMYAYA
//
//  Created by myeyesareblind on 8/30/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYEditItemViewController : UIViewController {
    __weak IBOutlet UITextView *textView;
}

@property (readwrite, strong) NSDictionary* item;

@end
