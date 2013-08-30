//
//  STEditItemViewController.m
//  SMYAYA
//
//  Created by myeyesareblind on 8/30/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYEditItemViewController.h"

@interface SYEditItemViewController ()

@end

@implementation SYEditItemViewController
@synthesize item;

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
    textView.text = item[@"content"];
}

- (NSDictionary*)item {
    return item;
}

- (void)setItem:(NSDictionary *)item_ {
    item = item_;
    self.title = item[@"title"];
    if ([self isViewLoaded]) {
        textView.text = item[@"content"];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
