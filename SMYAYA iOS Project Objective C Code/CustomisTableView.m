//
//  CustomisTableView.m
//  testing 2
//
//  Created by Christopher Dollinger on 6/29/13.
/*  This objective C Coding completed by Chris Dollinger.
Except where code is from snippets or other examples, this
original code by Chris Dollinger is hereby released under
GNU General Public License.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

TEAM:
John Amoratis, Project Founder
Chris Dollinger, Lead Programmer
Kurt Floyd, Lead Graphic Designer
*/

#import "CustomisTableView.h"
#import "SYEditRootViewController.h"

@interface CustomisTableView ()
-(void)updateEditButton;
-(void)editButtonHandle:(id)editButton;
@end

@implementation CustomisTableView

NSArray *menuitems;
NSDictionary *TitleLoop;
NSString *menuPath;

int itemCount;

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
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"schemaToDownload"];
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}


- (void) viewWillAppear:(BOOL)animated
{
    NSArray *docsDirect = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [docsDirect objectAtIndex:0];
    NSString *themePath = [NSString stringWithFormat:@"%@/%@", docsPath, @"Theme1.zip"];
    menuPath = [NSString stringWithFormat:@"%@/%@", themePath, @"menuItems.json"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:menuPath ] == YES)
    {
        NSData *jsonData = [[NSData alloc] initWithContentsOfFile:menuPath];
        NSDictionary *menuDiction = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        menuitems = [menuDiction objectForKey:@"menuitems"];

        itemCount = [menuitems count];
    }
    
    else
    {
        UIAlertView *noFiles = [[UIAlertView alloc] initWithTitle:@"You have no files!" message:@"Thank you for downloading SMYAYA! You are probably asking yourself, 'What am I supposed to do with this blank app?' Good question. Touch the 4th tab on the bottom, and download a schema. This app is a blank slate. When you download a schema, the app will fill with content that is relevant to you. Visit schemas.smyaya.com to create your own schema!" delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles:nil, nil];
        
        [noFiles show];
    }
    [self updateEditButton];
    
    [self.tableView reloadData];
    
    NSLog(@"Me First, right?");   
}


-(void)updateEditButton {
    if (! menuitems.count) {
        self.navigationItem.rightBarButtonItem = nil;
        return ;
    }
    
    
    UIBarButtonItem* editBarButtonItem     = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                           target:self
                                                                                           action:@selector(editButtonHandle:)];
    self.navigationItem.rightBarButtonItem = editBarButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)editButtonHandle:(id)editButton
{
    [self performSegueWithIdentifier:@"toEditViewController" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toEditViewController"]) {
        UINavigationController* navigationController = segue.destinationViewController;
        SYEditRootViewController* edidTableViewController = navigationController.viewControllers[0];
        edidTableViewController.dismissBlock = ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        };
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{   
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return itemCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomisCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //if ([[NSFileManager defaultManager] fileExistsAtPath:@"menuPath"] == YES)
    //{
    TitleLoop = [menuitems objectAtIndex:indexPath.row];
    NSLog(@"Dictionary: %@", TitleLoop);
    
    NSString *Title = [TitleLoop objectForKey:@"title"];
    NSLog(@"Title: %@", Title);
    
    cell.textLabel.text = Title;
    //}
    
    //else if ([[NSFileManager defaultManager] fileExistsAtPath:@"menuPath"] == NO)
    //{
    //    if (indexPath.row == 0)
    //    {
    //        cell.textLabel.text = [NSString stringWithFormat:@"Read Me!"];
    //    }
    //}
    
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TitleLoop = [menuitems objectAtIndex:indexPath.row];
    NSString *selectedDetails = [TitleLoop objectForKey:@"content"];
    [[NSUserDefaults standardUserDefaults] setValue:selectedDetails forKey:@"SelectedContent"];
    
    [self performSegueWithIdentifier:@"toDetail" sender:self];
}

@end
