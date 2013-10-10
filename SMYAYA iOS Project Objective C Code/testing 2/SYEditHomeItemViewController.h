//
//  SYEditHomeItemViewController.h
//  SMYAYA
//
//  Created by chary on 18/09/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SYEditItemViewControllerTextChangedBlock)(NSString* newText);

@interface SYEditHomeItemViewController : UIViewController<UIWebViewDelegate>{
    
    __weak IBOutlet UITextView *_textView;
    UIWebView *webView;
   
    NSTimer* timer;
    BOOL isWebView;
    
}
@property (readwrite, copy) SYEditItemViewControllerTextChangedBlock textChangedBlock;
@property (readwrite, copy) NSString*   initialText;
@property (readwrite, copy) NSString*   rowTitle;
@property (readwrite, copy) NSIndexPath *rowIndex;
@property (readwrite, copy) NSTimer* timer;

- (IBAction)saveHomeData:(id)sender;
- (IBAction)cancelHomeData:(id)sender;
@end
