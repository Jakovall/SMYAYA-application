//
//  SYEditTextViewController.m
//  SMYAYA
//
//  Created by myeyesareblind on 9/1/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYEditTextViewController.h"

@interface SYEditTextViewController ()

@end

@implementation SYEditTextViewController
@synthesize initialText = _initialText, textChangedBlock = _textChangedBlock;


- (void)viewDidLoad
{
    [super viewDidLoad];
    _textView.text = _initialText;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewWillDisappear:(BOOL)animated {
    if (![_initialText isEqualToString:_textView.text]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _textChangedBlock(_textView.text);
        });
    }
}


@end
