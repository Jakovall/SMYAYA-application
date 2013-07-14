//
//  FunView.m
//  SMYAYA V2
//
//  Created by Christopher Dollinger on 5/25/13.
//  Copyright (c) 2013 Christopher Dollinger. All rights reserved.
//

#import "FunView.h"

@interface FunView ()

@end

@implementation FunView

@synthesize FunWeb;

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
    //[FunWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"file://localhost/Users/soprolife/Desktop/Independent%20Projects/xCode/Reposits/SMYAYA-application/testing%202/test.html"]]];
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"html" inDirectory:@"www"]];
    [FunWeb loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
