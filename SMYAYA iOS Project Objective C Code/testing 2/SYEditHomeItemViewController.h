//
//  SYEditHomeItemViewController.h
//  SMYAYA
//
//  Created by chary on 18/09/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SYEditItemViewControllerTextChangedBlock)(NSString* newText);

@interface SYEditHomeItemViewController : UIViewController{
    
    __weak IBOutlet UITextView *_textView;
}
@property (readwrite, copy) SYEditItemViewControllerTextChangedBlock textChangedBlock;
@property (readwrite, copy) NSString*   initialText;
@end
