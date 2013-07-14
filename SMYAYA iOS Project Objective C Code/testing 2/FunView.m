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

NSArray *docsPath;
//NSString *schemaDirec;
NSString *themesDirec;
NSString *docsDirec;

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
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"html" inDirectory:@"www"]];
    [FunWeb loadRequest:[NSURLRequest requestWithURL:url]];
    
    docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDirec = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:[docsDirec stringByAppendingPathComponent:@"Themes"] withIntermediateDirectories:YES attributes:nil error:nil];
//    [[NSFileManager defaultManager] createDirectoryAtPath:[docsDirec stringByAppendingPathComponent:@"Schemas"] withIntermediateDirectories:YES attributes:nil error:nil];
    
//    schemaDirec = [NSString stringWithFormat:@"%@%@", [docsPath objectAtIndex:0], @"Schemas"];
    themesDirec = [NSString stringWithFormat:@"%@%@", [docsPath objectAtIndex:0], @"Themes"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
