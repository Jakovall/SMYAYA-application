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
@synthesize initialText = _initialText, textChangedBlock = _textChangedBlock,nowUrl;


- (void)viewDidLoad
{
    [super viewDidLoad];
   // _textView.text = _initialText;
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
       return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* const BYRootBasicCellID = @"BasicCell";
    NSString* const BYRootNameCellID  = @"SYTextFieldCell";
    BOOL nameCell = !indexPath.section && !indexPath.row;
    
    NSString* cellIdentifier = nameCell ? BYRootNameCellID : BYRootBasicCellID;
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
     
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier:cellIdentifier];
            nowUrl = [[UITextField alloc] initWithFrame:CGRectMake(70, 10, 215, 35)];
            nowUrl.adjustsFontSizeToFitWidth = YES;
            nowUrl.textColor = [UIColor blackColor];
            
            nowUrl.placeholder = @"Now Url";
            nowUrl.text = _initialText;
            nowUrl.returnKeyType = UIReturnKeyDone;
            
            nowUrl.backgroundColor = [UIColor clearColor];
            nowUrl.autocorrectionType = UITextAutocorrectionTypeNo;
            nowUrl.autocapitalizationType = UITextAutocapitalizationTypeNone;
            nowUrl.tag = 0;
            [nowUrl addTarget:self
                       action:@selector(textFieldFinished:)
             forControlEvents:UIControlEventEditingDidEndOnExit];
            nowUrl.clearButtonMode = UITextFieldViewModeNever;
            [nowUrl setEnabled: YES];
            
            [cell.contentView addSubview:nowUrl];
            cell.textLabel.text = @"URL";
        
     
    }
    
    
    
    return cell;
}

- (IBAction)textFieldFinished:(id)sender
{
    [sender resignFirstResponder];
}

-(IBAction)previewUrl:(id)sender{
NSURL *url = [NSURL URLWithString:nowUrl.text];
[_webView loadRequest:[NSURLRequest requestWithURL:url]];
}

@end
