//
//  ThemeDownloadView.h
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

#import <UIKit/UIKit.h>
#import "ZipArchive.h"
#import <QuartzCore/QuartzCore.h>

@interface ThemeDownloadView : UIViewController <UIAlertViewDelegate>
{
    NSMutableData *_responseData;
    UIActivityIndicatorView*  spinner;
}

@property (strong, nonatomic) IBOutlet UITextField *DownloadLink;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (retain, nonatomic) NSString *title;
@property (retain, nonatomic) NSString *urlstr;
@property (retain, nonatomic) NSArray *keyArray;
@property (retain, nonatomic) NSMutableArray *keyMutableArray;
@property (retain, nonatomic) NSMutableDictionary *dict;


@property (retain, nonatomic) NSArray *allTitles;
@property (retain, nonatomic)IBOutlet UIActivityIndicatorView*  spinner;

- (IBAction)DownloadAction:(id)sender;
- (void)fetchedData;
- (void)processData;
- (IBAction)LowerKeyboard:(id)sender;

@end
