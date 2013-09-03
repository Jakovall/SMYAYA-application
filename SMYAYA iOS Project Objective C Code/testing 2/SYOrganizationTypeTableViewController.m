//
//  SYOrganizationTypeTableViewController.m
//  SMYAYA
//
//  Created by myeyesareblind on 9/3/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYOrganizationTypeTableViewController.h"

@interface SYOrganizationTypeTableViewController () {
    NSArray*    _content;
    NSString*   _selectedContent;
}
@end

@implementation SYOrganizationTypeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _content = @[@"Diocese"
                 ,@"Parish"
                 ,@"College"
                 ,@"High School"
                 ,@"Grade School"
                 ,@"Other School"
                 ,@"Religious Order"
                 ,@"Ministy"
                 ,@"Company"
                 ,@"Individual"];
    self.title = @"Organization Type";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _content.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
        UIButton* plusButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        cell.accessoryView = plusButton;
    }
    NSString* title = _content[indexPath.row];
    cell.textLabel.text = title;
    
    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
