//
//  SYEditHomeItemsTableViewController.m
//  SMYAYA
//
//  Created by myeyesareblind on 8/30/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYEditHomeItemsTableViewController.h"
#import "SYEditTextViewController.h"
#import "SYDataProvider.h"
#import "Utility.h"

@interface SYEditHomeItemsTableViewController () {
    NSDictionary*   _selectedItem;
}

@property (readwrite, strong) NSMutableArray*  menuItems;
@property (readwrite, strong) void(^updateMenuItemsBlock) (NSArray* newHomeItems);

- (void)openEditViewControllerForItem:(NSDictionary*)item;

@end

@implementation SYEditHomeItemsTableViewController
@synthesize menuItems = _menuItems;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _menuItems = [[SYDataProvider sharedDataProvider] menuItems];
    __weak SYEditHomeItemsTableViewController* weakSelf = self;
    self.updateMenuItemsBlock = ^(NSArray* newItemsBlock) {
        weakSelf.menuItems = newItemsBlock;
        /// write to SYDataProvider
    };
    self.tableView.editing = YES;
    self.tableView.allowsSelectionDuringEditing = YES;
    self.title = @"Home Items";
    [Utility addHomeItemsCount:[_menuItems count]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return _menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomisCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary* item = _menuItems[indexPath.row];
    NSString *title = [item objectForKey:@"title"];
    cell.textLabel.text = title;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [btn addTarget:self
            action:@selector(disclosureButtonHandler:withEvent:)
  forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = btn;

    
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
        NSMutableArray* mutableItems = [NSMutableArray arrayWithArray:_menuItems];
        [mutableItems removeObjectAtIndex:indexPath.row];
        self.updateMenuItemsBlock(mutableItems);
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSMutableArray* mutableItems = [NSMutableArray arrayWithArray:_menuItems];
    NSDictionary* movedItem = mutableItems[fromIndexPath.row];
    [mutableItems removeObject:movedItem];
    [mutableItems insertObject:movedItem
                       atIndex:toIndexPath.row];
    self.updateMenuItemsBlock(mutableItems);
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
-(void)disclosureButtonHandler:(UIButton*)btn withEvent:(UIEvent*)event {
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint: [[[event touchesForView:btn] anyObject] locationInView:self.tableView]];
    if ( indexPath == nil )
        return;
    [self openEditViewControllerForItem:_menuItems[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self openEditViewControllerForItem:_menuItems[indexPath.row]];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toEditHomeItemViewController"]) {
        SYEditTextViewController* editItemViewController = segue.destinationViewController;
        editItemViewController.title = _selectedItem[@"title"];
        editItemViewController.initialText = _selectedItem[@"content"];
        editItemViewController.textChangedBlock = ^(NSString* newText) {
            NSMutableDictionary* mutableItem = [NSMutableDictionary dictionaryWithDictionary:_selectedItem];
            [mutableItem setObject:newText forKey:@"content"];
            NSMutableArray* mutableItems = [NSMutableArray arrayWithArray:_menuItems];
            [mutableItems replaceObjectAtIndex:[mutableItems indexOfObject:_selectedItem]
                                    withObject:mutableItem];
            self.updateMenuItemsBlock(mutableItems);
        };
    }
}


- (void)openEditViewControllerForItem:(NSDictionary*)item
{
    _selectedItem = item;
    [self performSegueWithIdentifier:@"toEditHomeItemViewController" sender:self];
}

- (IBAction)addHomeItems:(id)sender{
    [Utility addHomeItemsCount:[_menuItems count]];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:@"New" forKey: @"content"];
    [dic setObject: @"New" forKey: @"title"];
    [_menuItems addObject:dic];
    
    [self.tableView reloadData];

}

@end
