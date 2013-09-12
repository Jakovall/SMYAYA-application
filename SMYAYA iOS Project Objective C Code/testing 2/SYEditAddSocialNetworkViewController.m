//
//  SYEditAddSocialNetworkViewController.m
//  SMYAYA
//
//  Created by myeyesareblind on 9/3/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYEditAddSocialNetworkViewController.h"
#import "SYTextFieldCell.h"
#import "SocialNetworkItem.h"
#import "Utility.h"

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
                                                                        action:@selector(addButtonHandle:)];
    self.navigationItem.rightBarButtonItem = addBarButtonItem;
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(cancelButtonHandle:)];
    _networks = @[@"Twitter",@"Facebook",@"Instagram",@"YouTube",@"Google+",@"Tumblr"];
    uarray = [[NSMutableArray alloc] init];
    networkItems = [[Utility alloc] init];
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

-(void)addButtonHandle:(id)sender
{
    
    
    if([networkSelected isEqualToString:@""] || [textFieldCell.textField.text isEqualToString:@""] || textFieldCell.textField.text == NULL || networkSelected == NULL || textFieldCell.textField.text == nil){
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"A username and a social media service must be selected." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }else{
        
        SocialNetworkItem* info = [[SocialNetworkItem alloc] init];
        //uarray = [[NSMutableArray alloc] init];
        
        info.username = textFieldCell.textField.text;
        info.network = networkSelected;
        //[uarray addObject:textFieldCell.textField.text];
        
        //[info.username addObject:textFieldCell.textField.text];
        [networkItems adddata:info];
        cancelBlock();
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == 1) {
		//OK clicked
	} else {
	}
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
            
            //UIButton* plusButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
            //cell.accessoryView = plusButton;
            plusButton =[UIButton buttonWithType:UIButtonTypeCustom];
            [plusButton setFrame:CGRectMake(260, 5, 30, 30)];
            [plusButton setBackgroundImage:[[UIImage imageNamed:@"check.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
            [plusButton setBackgroundImage:[[UIImage imageNamed:@"check.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateSelected];
            [plusButton setTag:indexPath.row];
            // [cell addSubview:plusButton];
            cell.accessoryView = plusButton;
            
            cell.accessoryView.hidden = YES;

            
        }
    }
    if (nameCell) {
        textFieldCell = (SYTextFieldCell*)cell;
        textFieldCell.textField.text   = @"";
        textFieldCell.labelTitle.text  = @"Username";
    }
    else {
        cell.textLabel.text = _networks[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];

    networkSelected = _networks[indexPath.row];
    
    NSInteger sections = tableView.numberOfSections;
    for (int section = 0; section < sections; section++) {
        NSInteger rows =  [tableView numberOfRowsInSection:section];
        for (int row = 0; row < rows; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            UITableViewCell *cells = [self.tableView cellForRowAtIndexPath:indexPath];            cells.accessoryView.hidden= YES;
        }
    }
    
    cell.accessoryView.hidden = NO;
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
