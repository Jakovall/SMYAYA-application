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
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UIWebView* _webView;
}

@property (readwrite, copy) SYEditItemViewControllerTextChangedBlock textChangedBlock;
@property (readwrite, copy) NSString*   initialText;
@property (strong, nonatomic) IBOutlet UITextField *nowUrl;


-(IBAction)previewUrl:(id)sender;

@end
