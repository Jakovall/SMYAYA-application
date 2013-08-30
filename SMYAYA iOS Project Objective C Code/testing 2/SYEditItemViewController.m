//
//  STEditItemViewController.m
//  SMYAYA
//
//  Created by myeyesareblind on 8/30/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYEditItemViewController.h"

@interface SYEditItemViewController () {
    NSString* _initialContent;
}
@end

@implementation SYEditItemViewController
@synthesize item, textChangedBlock;

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
    self.title = item[@"title"];
    NSString* content = item[@"content"];
    textView.text = content;
    _initialContent = [content copy];
}


- (void)viewWillDisappear:(BOOL)animated {
    if (![_initialContent isEqualToString:textView.text]) {
        textChangedBlock(textView.text);
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
