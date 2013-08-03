//
//  OpenXMLView.h
//  testing 2
//
//  Created by Christopher Dollinger on 6/22/13.
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

@interface OpenXMLView : UIViewController //HELLO WORLD!!!!
{
    IBOutlet UILabel *AppBgColorLabel;
    IBOutlet UILabel *AppNameLabel;
    IBOutlet UILabel *AppVersionLabel;
    IBOutlet UILabel *developerNameLabel;
    IBOutlet UILabel *contactLabel;
}


- (IBAction)openXML:(id)sender;
- (void)fetchedData:(NSData *)responseData;
- (void)processData:(NSDictionary *) JSONObject;


@end
