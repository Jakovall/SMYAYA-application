//
//  SYEditHomeItemsTableViewController.m
//  SMYAYA
//
//  Created by myeyesareblind on 8/30/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYEditHomeItemsTableViewController.h"
#import "SYEditItemViewController.h"

@interface SYEditHomeItemsTableViewController () {
    NSMutableArray* _mutableMenuItems;
    NSDictionary* _selectedItem;
}
- (void)doneButtonHandle:(id)doneButton;
- (void)saveButtonHandle:(id)saveButton;
- (void)openEditViewControllerForItem:(NSDictionary*)item;
@end

@implementation SYEditHomeItemsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setMenuItems:(NSArray *)menuItems {
    _mutableMenuItems = [NSMutableArray arrayWithArray:menuItems];
}

- (NSArray*)menuItems {
    return _mutableMenuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                          target:self
                                                                                          action:@selector(doneButtonHandle:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                           target:self
                                                                                           action:@selector(saveButtonHandle:)];
    self.tableView.editing = YES;
    self.tableView.allowsSelectionDuringEditing = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)doneButtonHandle:(id)doneButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveButtonHandle:(id)saveButton
{
    /// empty so far
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _mutableMenuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomisCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //if ([[NSFileManager defaultManager] fileExistsAtPath:@"menuPath"] == YES)
    //{
    NSDictionary* item = _mutableMenuItems[indexPath.row];
    NSString *title = [item objectForKey:@"title"];
    cell.textLabel.text = title;
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_mutableMenuItems removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSDictionary* movedItem = _mutableMenuItems[fromIndexPath.row];
    [_mutableMenuItems removeObject:movedItem];
    [_mutableMenuItems insertObject:movedItem
                            atIndex:toIndexPath.row];
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self openEditViewControllerForItem:_mutableMenuItems[indexPath.row]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toEditItemViewController"]) {
        SYEditItemViewController* editItemViewController = segue.destinationViewController;
        editItemViewController.item = _selectedItem;
    }
}

- (void)openEditViewControllerForItem:(NSDictionary*)item {
    _selectedItem = item;
    [self performSegueWithIdentifier:@"toEditItemViewController" sender:self];
}

@end
