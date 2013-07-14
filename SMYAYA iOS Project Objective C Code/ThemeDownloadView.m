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

NSArray *paths;
NSArray *uzipPath;
NSString *filePath;
NSString *uzipFilePath;
NSString *appendedPath;
NSURL *url;
NSData *urlData;

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
    
    //gives the button the images declared above
    [self.infoButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [self.infoButton setBackgroundImage:pressedImage forState:UIControlStateHighlighted];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    [[NSUserDefaults standardUserDefaults] setValue:contentOfFile forKey:@"NewsURL"];
}

- (IBAction)LowerKeyboard:(id)sender
{
    [sender resignFirstResponder];
}

@end
