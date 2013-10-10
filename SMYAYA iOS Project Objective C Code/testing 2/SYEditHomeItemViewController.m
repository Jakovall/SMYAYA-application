//
//  SYEditHomeItemViewController.m
//  SMYAYA
//
//  Created by chary on 18/09/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYEditHomeItemViewController.h"
#import "SYDataProvider.h"

@interface SYEditHomeItemViewController ()
@property (readwrite, strong) NSMutableArray*  menuItems;
@end

@implementation SYEditHomeItemViewController
@synthesize initialText = _initialText, textChangedBlock = _textChangedBlock;
@synthesize menuItems = _menuItems,timer,rowIndex,rowTitle = _rowTitle;

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
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]isDirectory:NO]]];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(contentLoadMethod:)
                                   userInfo:nil
                                    repeats:YES];
    webView.delegate=self;
    [self.view addSubview:webView];
    
    
    
}
-(void)contentLoadMethod:(id)sender{
    if(webView.loading){
 
        [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"setStringToDisplay('%@')",_initialText]];
        NSString* contentData =  [webView stringByEvaluatingJavaScriptFromString:@"getStringToSave()"];
        if(contentData.length >0){
            [timer invalidate];
            timer =nil;
        }
       

    }
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
    _menuItems = [SYDataProvider getHomeItem];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:[webView stringByEvaluatingJavaScriptFromString:@"getStringToSave()"] forKey: @"content"];
    [dic setObject: _rowTitle forKey: @"title"];
    [_menuItems replaceObjectAtIndex:rowIndex.row
                            withObject:dic];
    [self dismissViewControllerAnimated:YES completion:nil];
       
}

- (IBAction)cancelHomeData:(id)sender{
   
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
