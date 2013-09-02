//
//  SYEditRootViewController.m
//  SMYAYA
//
//  Created by myeyesareblind on 9/1/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYEditRootViewController.h"
#import "SYEditHomeItemsTableViewController.h"
#import "SYEditTextViewController.h"
#import "SYDataProvider.h"

typedef NS_ENUM(NSInteger, SYEditRootCell) {
    SYEditRootCellHomeItems,
    SYEditRootCellNowPage,
    SYEditRootCellGeoItems
};


@interface SYEditRootViewController ()

- (void)disclosureButtonHandler:(UIButton*)btn withEvent:(UIEvent*)event;
- (void)cancelButtonHandle:(id)doneButton;
- (void)saveButtonHandle:(id)saveButton;

@end

@implementation SYEditRootViewController
@synthesize dismissBlock;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(cancelButtonHandle:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                           target:self
                                                                                           action:@selector(saveButtonHandle:)];
    self.title = @"Editor";
}


- (void)cancelButtonHandle:(id)doneButton
{
    [self.navigationController popViewControllerAnimated:YES];
    if (dismissBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            dismissBlock();
        });
    }
}


- (void)saveButtonHandle:(id)saveButton
{
    /// empty so far
}


- (void)disclosureButtonHandler:(UIButton*)btn withEvent:(UIEvent*)event {
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/// static cells are used

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYEditRootCell cellIndex = indexPath.row;
    if (cellIndex == SYEditRootCellHomeItems) {
        [self performSegueWithIdentifier:@"toEditMenuItemsViewController" sender:self];
    }else if (cellIndex == SYEditRootCellNowPage) {
        [self performSegueWithIdentifier:@"toEditNowPageViewController" sender:self];
    }else if (cellIndex == SYEditRootCellGeoItems) {
        [self performSegueWithIdentifier:@"toEditGeoItemsTableViewController" sender:self];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toEditMenuItemsViewController"]) {
    } else if ([segue.identifier isEqualToString:@"toEditNowPageViewController"]) {
        SYEditTextViewController* textViewController = segue.destinationViewController;
        NSAssert2([textViewController isKindOfClass:[SYEditTextViewController class]],
                  @"wrong segue destination class, expected:%@, got:%@",
                  NSStringFromClass([SYEditTextViewController class]),
                  NSStringFromClass([textViewController class]));
        textViewController.initialText = [[[SYDataProvider sharedDataProvider] nowURL] absoluteString];
        textViewController.title       = @"Now URL";
        textViewController.textChangedBlock = ^(NSString* newText){
            /// write it to url.txt
        };
    } else if ([segue.identifier isEqualToString:@"toEditGeoItemsTableViewController"]) {

    }
}

@end
