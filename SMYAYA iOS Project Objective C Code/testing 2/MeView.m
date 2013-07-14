//
//  MeView.m
//  testing 2
//
//  Created by Christopher Dollinger on 6/1/13.
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

#import "MeView.h"

@interface MeView ()

@end

@implementation MeView
@synthesize PrefsListTable;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"PrefsList"];
    
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"Theme";
            break;
        //case 1:
            //cell.textLabel.text = @"Schema";
            //break;
        case 1:
            cell.textLabel.text = @"User Info";
            break;
        case 2:
            cell.textLabel.text = @"Personal Info";
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"toThemeDownload" sender:self];
            break;
        //case 1:
         //   [self performSegueWithIdentifier:@"toSchemaPick" sender:self];
         //   break;
        case 1:
            [self performSegueWithIdentifier:@"toUserProfileSettings" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"toName" sender:self];
            break;
            
        default:
            break;
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    int myColorInteger = [[NSUserDefaults standardUserDefaults] integerForKey:@"colorPreference"]; //calls the default value
    
    switch (myColorInteger) {
        case 0:
            [self.backgroundImage setImage:[UIImage imageNamed:@"kurt1.png"]];
            break;
        case 1:
            [self.backgroundImage setImage:[UIImage imageNamed:@"kurt2.png"]];
            break;
        case 2:
            [self.backgroundImage setImage:[UIImage imageNamed:@"kurt3.png"]];
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
