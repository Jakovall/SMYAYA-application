//
//  SYEditGeoItemsTableViewController.m
//  SMYAYA
//
//  Created by myeyesareblind on 9/2/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYEditGeoItemsTableViewController.h"
#import "SYDataProvider.h"
#import "SYEditGeoItemViewController.h"


@interface SYEditGeoItemsTableViewController () {
}

@property (readwrite, strong) NSArray*      geoItems;
@property (readwrite, strong) NSDictionary* selectedGeoItem;
@property (readwrite, strong) void(^updateGewItemsBlock) (NSArray* newGeoItems);
@end


@implementation SYEditGeoItemsTableViewController
@synthesize geoItems = _geoItems, selectedGeoItem = _selectedGeoItem, updateGewItemsBlock;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _geoItems = [[SYDataProvider sharedDataProvider] geoItems];
    __weak SYEditGeoItemsTableViewController* weakSelf = self;
    self.updateGewItemsBlock = ^(NSArray* newGeoItems){
        weakSelf.geoItems = newGeoItems;
        /// update datasource
    };
    
    self.tableView.editing = YES;
    self.tableView.allowsSelectionDuringEditing = YES;
    self.title = @"Geo items";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _geoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomisCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSAssert(cell, @"must be inited by storyboard");
    NSDictionary* singleItem = _geoItems[indexPath.row];
    cell.textLabel.text = singleItem[@"title"];
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
        NSMutableArray* mutableGeoItems = [NSMutableArray arrayWithArray:_geoItems];
        [mutableGeoItems removeObjectAtIndex:indexPath.row];
        self.updateGewItemsBlock(mutableGeoItems);
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSMutableArray* mutableGeoItems = [NSMutableArray arrayWithArray:_geoItems];
    NSDictionary*   geoItem         = mutableGeoItems[fromIndexPath.row];
    [mutableGeoItems removeObject:geoItem];
    [mutableGeoItems insertObject:geoItem atIndex:toIndexPath.row];
    self.updateGewItemsBlock(mutableGeoItems);
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedGeoItem = _geoItems[indexPath.row];
    [self performSegueWithIdentifier:@"toEditGeoItemViewController" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toEditGeoItemViewController"]) {
        SYEditGeoItemViewController* editGeoItemViewController = segue.destinationViewController;
        NSAssert([editGeoItemViewController isKindOfClass:[SYEditGeoItemViewController class]], @"wrong controller");
        
        __weak SYEditGeoItemsTableViewController* weakSelf = self;
        editGeoItemViewController.editCompletedBlock = ^(NSString* newTitle,NSString* newSubtitle){
            NSMutableDictionary* mutableGeoItem = [NSMutableDictionary dictionaryWithDictionary:_selectedGeoItem];
            [mutableGeoItem setObject:newTitle
                               forKey:@"title"];
            [mutableGeoItem setObject:newSubtitle
                               forKey:@"subtitle"];
            NSMutableArray* mutableGeoItems = [NSMutableArray arrayWithArray:weakSelf.geoItems];
            [mutableGeoItems replaceObjectAtIndex:[mutableGeoItems indexOfObject:_selectedGeoItem]
                                       withObject:mutableGeoItem];
            weakSelf.updateGewItemsBlock(mutableGeoItems);
        };
        NSAssert(_selectedGeoItem, @"selected geo item must be setted");
        editGeoItemViewController.geoItem = _selectedGeoItem;
    }
}

@end

