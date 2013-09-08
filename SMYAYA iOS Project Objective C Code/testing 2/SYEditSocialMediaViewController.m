//
//  SYEditSocialMediaViewController.m
//  SMYAYA
//
//  Created by myeyesareblind on 9/3/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYEditSocialMediaViewController.h"
#import "SYEditAddSocialNetworkViewController.h"

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
