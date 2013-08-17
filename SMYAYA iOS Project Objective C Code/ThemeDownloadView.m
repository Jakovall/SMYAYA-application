//
//  ThemeDownloadView.m
//  testing 2
//
//  Created by Christopher Dollinger on 6/20/13.
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

#import "ThemeDownloadView.h"

@interface ThemeDownloadView ()

@end

@implementation ThemeDownloadView
@synthesize table,urlstr,title,keyArray,keyMutableArray,dict;

NSArray *paths;
NSArray *uzipPath;
NSString *filePath;
NSString *uzipFilePath;
NSString *appendedPath;
NSURL *url;
NSData *urlData;

NSString *urlLink;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    UIImage *normalImage = [[UIImage imageNamed:@"infoImage"] //the image that would be displayed
                            stretchableImageWithLeftCapWidth:1.0 //when the button is not depressed
                            topCapHeight:0.0];
    UIImage *pressedImage = [[UIImage imageNamed:@"infoImage"]
                             stretchableImageWithLeftCapWidth:1.0
                             topCapHeight:0.0]; //the image that will be displayed when the user pushes the button
    keyMutableArray = [[NSMutableArray alloc] init];
    
    self.table.layer.borderWidth = 2;
    
    //gives the button the images declared above
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated
{
    urlLink = [[NSUserDefaults standardUserDefaults] objectForKey:@"schemaToDownload"];
    
    if (urlLink != nil)
    {
        UIAlertView *Confirm = [[UIAlertView alloc] initWithTitle:nil message:@"Are you sure you want to download this schema?" delegate:self cancelButtonTitle:@"Yes!" otherButtonTitles:@"No!", nil];
        [Confirm show];
    }

    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"schemaToDownload"];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSLog([NSString stringWithFormat:@"%ld", (long)buttonIndex]);
        
        self.DownloadLink.text = urlLink;
        [self DownloadAction:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)DownloadAction:(id)sender
{
    // Determile cache file path
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    filePath = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0],@"Themes"];
    [[NSFileManager defaultManager] createDirectoryAtPath:[filePath stringByAppendingPathComponent:@"Theme1.zip"] withIntermediateDirectories:YES attributes:nil error:nil];
    filePath = [NSString stringWithFormat:@"%@/%@", [filePath stringByAppendingPathComponent:@"Theme1.zip"],@"Theme1.zip"];
    
    // Download and write to file
    url = [NSURL URLWithString:self.DownloadLink.text];
    urlData = [NSData dataWithContentsOfURL:url];
    [urlData writeToFile:filePath atomically:YES];
    
    uzipPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //This is the path to the "Documents" folder of the app
    uzipFilePath = [NSString stringWithFormat:@"%@/%@", [uzipPath objectAtIndex:0], @"Theme1.zip"]; //this is the directory to the folder "Theme1.zip" (Documents/Theme1.zip is the string value being declared)
    
    ZipArchive *za = [[ZipArchive alloc] init];
    
    if( [za UnzipOpenFile:filePath] )
    {
        if( [za UnzipFileTo:uzipFilePath overWrite:YES] != NO )
        {
            //unzip data success
            //do something
        }

        [za UnzipCloseFile];
    }
    
    NSString *FeedURLPath = [NSString stringWithFormat:@"%@/%@", uzipFilePath, @"now.txt"]; //this is the directory to the file "now.txt" (Documents/Theme1.zip/now.txt)
    NSString *contentOfFile = [NSString stringWithContentsOfFile:FeedURLPath encoding:NSUTF8StringEncoding error:nil]; //makes a string value with the contents of the file in the directory "FeedURLPath"
    NSString *titlePath = [NSString stringWithFormat:@"%@/%@", uzipFilePath, @"title.txt"]; //this is the directory to the file "now.txt" (Documents/Theme1.zip/now.txt)
    
    NSString *titleofFile = [NSString stringWithContentsOfFile:titlePath encoding:NSUTF8StringEncoding error:nil]; //makes a string value with the contents of the file in the directory "FeedURLPat

    [[NSUserDefaults standardUserDefaults] setValue:contentOfFile forKey:@"NewsURL"];
    dict =[[NSMutableDictionary alloc] init];
    if(![[NSUserDefaults standardUserDefaults] valueForKey:@"urltitle"])
    {
        dict = [[NSUserDefaults standardUserDefaults] valueForKey:@"urltitle"];
    }
    //[dict setObject:contentOfFile forKey:titleofFile];
    
    [dict setObject:self.DownloadLink.text forKey:titleofFile];
    [[NSUserDefaults standardUserDefaults] setValue:self.DownloadLink.text forKey:titleofFile];
    
    [[NSUserDefaults standardUserDefaults] setValue:dict forKey:@"urltitle"];
    [keyMutableArray addObject:titleofFile];
    [table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return keyMutableArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    
    cell.textLabel.text = [keyMutableArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *stringVal = [[NSUserDefaults standardUserDefaults] valueForKey:[keyMutableArray objectAtIndex:indexPath.row]];
    
    NSLog(@"string value is :%@",stringVal);
    self.DownloadLink.text = stringVal;
    
    [self DownloadAction:stringVal];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (IBAction)LowerKeyboard:(id)sender
{
    [sender resignFirstResponder];
}

@end
