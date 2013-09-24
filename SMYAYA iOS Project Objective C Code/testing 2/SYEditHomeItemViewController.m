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
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,
                                                                     self.view.frame.size.height)];
    
  //  NSString *indexPath = [NSBundle pathForResource:@"hello" ofType:@"html" inDirectory:nil];
  //  [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:indexPath]]];
  //  [self.view addSubview:webView];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    NSError *error;
    NSString *contentString = [NSString stringWithContentsOfURL:url encoding:NSStringEncodingConversionAllowLossy error:&error];
    
     contentString = [contentString stringByReplacingOccurrencesOfString:@"<textarea></textarea>" withString:[NSString stringWithFormat:@"<textarea>%@</textarea>",_initialText]];
    NSURL *baseUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    

    [webView loadHTMLString:contentString baseURL:baseUrl];
   // [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]isDirectory:NO]]];
    
    [self.view addSubview:webView];
    
    
    
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

- (IBAction)saveHomeData:(id)sender{
    
    NSLog(@"editor content is %@",[webView stringByEvaluatingJavaScriptFromString:@"tinymce.activeEditor.getContent()"]);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)cancelHomeData:(id)sender{
   
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
