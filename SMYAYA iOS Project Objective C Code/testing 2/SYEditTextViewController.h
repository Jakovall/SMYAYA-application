//
//  SYEditTextViewController.h
//  SMYAYA
//
//  Created by myeyesareblind on 9/1/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SYEditItemViewControllerTextChangedBlock)(NSString* newText);

@interface SYEditTextViewController : UIViewController {
    __weak IBOutlet UITextView *_textView;
}

@property (readwrite, copy) SYEditItemViewControllerTextChangedBlock textChangedBlock;
@property (readwrite, copy) NSString*   initialText;

@end
