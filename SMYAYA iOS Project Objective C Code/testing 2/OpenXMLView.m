//
//  OpenXMLView.m
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

#import "OpenXMLView.h"

@interface OpenXMLView ()

@end

@implementation OpenXMLView

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openXML:(id)sender
{
    //Getting the file path from the local bundle.
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"jsonText2" ofType:@"txt"];
    //Convert the content of file to NSData
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    //fetch the data to the JSON Foundation opject.
    [self performSelectorOnMainThread:@selector(fetchedData:)
                           withObject:data waitUntilDone:YES];
    
   /* NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPaths lastObject];
    
    NSXMLDocument* doc = [[NSXMLDocument alloc] initWithContentsOfURL: [NSURL fileURLWithPath:documentPath] options:0 error:NULL];
    
    NSMutableArray* objects = [[NSMutableArray alloc] initWithCapacity:10];
    NSMutableArray* descriptions = [[NSMutableArray alloc] initWithCapacity:10];
    
    NSXMLElement* root  = [doc rootElement];
    NSArray* objectElements = [root nodesForXPath:@"//object" error:nil];
    for(NSXMLElement* xmlElement in objectElements)
        [objects addObject:[xmlElement stringValue]];
    
    NSArray* descElements = [root nodesForXPath:@"//description" error:nil];
    for(NSXMLElement* xmlElement in descElements)
        [descriptions addObject:[xmlElement stringValue]];
    
    NSLog(@"%@", objects);
    NSLog(@"%@", descriptions);
    
    [doc release];
    [objects release];
    [descriptions release]; */
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary  *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    //process the JSON Foundation object to the view.
    [self processData:json];
}

-(void)processData:(NSDictionary *) JSONObject{
    
    NSString *AppBgColor = [JSONObject valueForKey:@"AppBgColor"];
    NSString *AppName    = [JSONObject valueForKey:@"AppName"];
    NSString *AppVersion = [JSONObject valueForKey:@"AppVersion"];
    NSString        *developerName =[JSONObject valueForKey:@"developerName"];
    NSString        *contact =[JSONObject valueForKey:@"contact"];
    NSLog(@"AppBgColor: %@", AppBgColor);
    NSLog(@"AppName: %@", AppName);
    NSLog(@"AppVersion: %@",AppVersion);
    NSLog(@"developerName: %@",developerName);
    NSLog(@"contact: %@",contact);
    AppBgColorLabel.text =AppBgColor;
    AppNameLabel.text =AppName;
    AppVersionLabel.text = AppVersion;
    developerNameLabel.text=developerName;
    contactLabel.text=contact;
    self.view.backgroundColor =[UIColor greenColor];
}
@end
