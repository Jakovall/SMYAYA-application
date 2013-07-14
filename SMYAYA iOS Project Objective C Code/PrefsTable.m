//
//  PrefsTable.m
//  testing 2
//
//  Created by Christopher Dollinger on 6/8/13.
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

#import "PrefsTable.h"

@interface PrefsTable ()

@end

@implementation PrefsTable

@synthesize BackgroundPref;

int UnivNumberofRows;
int rownum = 1;

NSArray *themePath;
NSString *themeFilePath;
NSString *documentDirPath;

NSIndexPath *oldIndex = nil;
UITableViewCell *cell;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView //edits the number of sections in the tableview
{
    //Potentially incomplete method implementation.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section //edits the number of rows in each section
{
    //Incomplete method implementation.
    NSLog(@"Me! Me!");
    
    UnivNumberofRows = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:[documentDirPath stringByAppendingPathComponent:@"Themes"] error:nil]
                        count];
    
    return UnivNumberofRows; //No files are downloaded naturally, therefore, this does not have a value on startup, therefore, no rows, therefore... NO. DOWNLOADING. FILES... AND NO.... ANYTHING!!!!!!!!!!!
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath //edits what each cell displays
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    if (rownum <= UnivNumberofRows - 1)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[documentDirPath stringByAppendingPathComponent:@"Themes" ] error:nil][rownum]];
        rownum++;
    }
    
    else if (rownum > UnivNumberofRows - 1)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"Download More Themes"];
        rownum = 1;
    }
    
    if (cell.textLabel.text == [[NSUserDefaults standardUserDefaults] valueForKey:@"ThemePref"])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        oldIndex = indexPath;
    }
    
    NSLog(@"No, I do!");
    
    return cell;
}

- (void)viewWillAppear:(BOOL)animated
{
    documentDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    // create directory named "test"
    [[NSFileManager defaultManager] createDirectoryAtPath:[documentDirPath stringByAppendingPathComponent:@"Themes"] withIntermediateDirectories:YES attributes:nil error:nil];
    // retrieved all directories
    NSLog(@"%@", [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[documentDirPath stringByAppendingPathComponent:@"Themes" ] error:nil]);
    
    NSLog(@"I appear first!");
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
    cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    if(indexPath.row != (UnivNumberofRows - 1))
    {
        UITableViewCell *oldcell = [tableView cellForRowAtIndexPath:oldIndex];
        oldcell.accessoryType = UITableViewCellAccessoryNone;
    
        oldIndex = indexPath;
    
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.selected = NO;
        [[NSUserDefaults standardUserDefaults] setValue:cell.textLabel.text forKey:@"ThemePref"];
    }
    else if(indexPath.row == (UnivNumberofRows - 1))
    {
        [self performSegueWithIdentifier:@"toThemeDownload" sender:self];
    }
}
@end
