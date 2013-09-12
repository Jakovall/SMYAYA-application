//
//  SYEditSocialMediaViewController.m
//  SMYAYA
//
//  Created by myeyesareblind on 9/3/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYEditSocialMediaViewController.h"
#import "SYEditAddSocialNetworkViewController.h"
#import "SocialNetworkItem.h"

@interface SYEditSocialMediaViewController ()
- (void)addBarButtonHandle:(id)barButton;
@end

@implementation SYEditSocialMediaViewController

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
    UIBarButtonItem* editBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:nil
                                                                         action:nil];
    UIBarButtonItem* plusBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                       target:self
                                                                                       action:@selector(addBarButtonHandle:)];
    self.navigationItem.rightBarButtonItems = @[plusBarButtonItem,editBarButtonItem];
    self.title = @"Social Networks";
}

- (void)addBarButtonHandle:(id)barButton {
    [self performSegueWithIdentifier:@"toEditAddSocialNetworkViewController" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toEditAddSocialNetworkViewController"]) {
        UINavigationController* navigationController = segue.destinationViewController;
        SYEditAddSocialNetworkViewController* addSocialNetworkViewController = (SYEditAddSocialNetworkViewController*)navigationController.viewControllers[0];
        addSocialNetworkViewController.cancelBlock =
        ^{[self dismissViewControllerAnimated:YES
                                   completion:nil];
        };
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    // if(!str){
    Utility* info = [[Utility alloc] init];
    networkItems = [info getdataval];
    
    
    // NSLog(@"test %@",str);
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [networkItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    SocialNetworkItem* info = [networkItems objectAtIndex:indexPath.row];
    
    cell.textLabel.text = info.username;
    cell.detailTextLabel.text = info.network;
    // Configure the cell...
    
    return cell;
}

@end
