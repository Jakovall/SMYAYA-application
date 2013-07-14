//
//  MeView.m
//  testing 2
//
//  Created by Christopher Dollinger on 6/1/13.
//  Copyright (c) 2013 John. All rights reserved.
//

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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"PrefsList"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %i", indexPath.row + 1];
    
    return cell;
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
    int myColorInteger = [[NSUserDefaults standardUserDefaults] integerForKey:@"colorPreference"];
    
    [self.myColorSelector setSelectedSegmentIndex:myColorInteger];
    self.nameValue.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"namePref"];
    
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
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeBackgroundColor {
    
    switch (self.myColorSelector.selectedSegmentIndex) {
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
    
    [[NSUserDefaults standardUserDefaults] setInteger:self.myColorSelector.selectedSegmentIndex forKey:@"colorPreference"];
}

- (IBAction)changeName {
    
    [[NSUserDefaults standardUserDefaults] setValue:self.nameValue.text forKey:@"namePref"];
}

@end
