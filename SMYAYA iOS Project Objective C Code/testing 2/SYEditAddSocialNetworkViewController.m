//
//  SYEditAddSocialNetworkViewController.m
//  SMYAYA
//
//  Created by myeyesareblind on 9/3/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYEditAddSocialNetworkViewController.h"
#import "SYTextFieldCell.h"

@interface SYEditAddSocialNetworkViewController () {
    NSArray* _networks;
}
-(void)cancelButtonHandle:(id)cancelBarButton;
@end

@implementation SYEditAddSocialNetworkViewController
@synthesize cancelBlock;

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
    UIBarButtonItem* addBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                                         style:UIBarButtonItemStyleDone
                                                                        target:nil
                                                                        action:nil];
    self.navigationItem.rightBarButtonItem = addBarButtonItem;
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(cancelButtonHandle:)];
    _networks = @[@"Twitter",@"Facebook",@"Instagram",@"YouTube",@"Google+",@"Tumblr"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)cancelButtonHandle:(id)cancelBarButton
{
    NSAssert(cancelBlock, @"cancelBlock must be set");
    cancelBlock();
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return _networks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* const BYRootBasicCellID = @"BasicCell";
    NSString* const BYRootNameCellID  = @"SYTextFieldCell";
    BOOL nameCell = !indexPath.section && !indexPath.row;
    
    NSString* cellIdentifier = nameCell ? BYRootNameCellID : BYRootBasicCellID;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        if (nameCell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SYTextFieldCell"
                                                  owner:self
                                                options:nil] lastObject];
        }
        else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:cellIdentifier];
            UIButton* plusButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
            cell.accessoryView = plusButton;
        }
    }
    if (nameCell) {
        SYTextFieldCell* textFieldCell = (SYTextFieldCell*)cell;
        textFieldCell.textField.text   = @"Example Name";
        textFieldCell.labelTitle.text  = @"Username";
    }
    else {
        cell.textLabel.text = _networks[indexPath.row];
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
