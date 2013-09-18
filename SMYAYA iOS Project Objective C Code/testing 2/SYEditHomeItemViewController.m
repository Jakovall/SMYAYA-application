//
//  SYEditHomeItemViewController.m
//  SMYAYA
//
//  Created by chary on 18/09/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYEditHomeItemViewController.h"

@interface SYEditHomeItemViewController ()

@end

@implementation SYEditHomeItemViewController
@synthesize initialText = _initialText, textChangedBlock = _textChangedBlock;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _textView.text = _initialText;
}

- (void)viewWillDisappear:(BOOL)animated {
    if (![_initialText isEqualToString:_textView.text]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _textChangedBlock(_textView.text);
        });
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
