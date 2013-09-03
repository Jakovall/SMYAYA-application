//
//  SYEditRootViewController.m
//  SMYAYA
//
//  Created by myeyesareblind on 9/1/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYEditRootViewController.h"
#import "SYEditHomeItemsTableViewController.h"
#import "SYEditTextViewController.h"
#import "SYDataProvider.h"
#import "SYTextFieldCell.h"
#import "SYEditSocialMediaViewController.h"
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>


typedef NS_ENUM(NSInteger, SYEditRootCell) {
    SYEditRootCellName,
    SYEditRootCellOrganizationType,
    SYEditRootCellHomeItems,
    SYEditRootCellNowPage,
    SYEditRootCellGeoItems,
    SYEditRootCellSocialMedia,
    SYEditRootCellContactInfo
};


@interface SYEditRootViewController () <ABPeoplePickerNavigationControllerDelegate, UINavigationControllerDelegate, ABNewPersonViewControllerDelegate> {
    ABPeoplePickerNavigationController* _peopleNavigationController;
}

- (void)disclosureButtonHandler:(UIButton*)btn withEvent:(UIEvent*)event;
- (void)cancelButtonHandle:(id)doneButton;
- (void)saveButtonHandle:(id)saveButton;
- (NSString*)cellTitleAtCell:(SYEditRootCell)cellType;
- (SYEditRootCell)cellTypeAtIndexPath:(NSIndexPath*)indexPath;

- (void)peoplePickerNavigationControllerCancelButtonHandle:(id)cancelBarButton;
- (void)peoplePickerNavigationControllerCancelAddPersonButtonHandle:(id)addPersonButtonHandle;
- (void)abNewPersonBackBarButtonHandle:(id)barButtonItem;
@end

@implementation SYEditRootViewController
@synthesize dismissBlock;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(cancelButtonHandle:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                           target:self
                                                                                           action:@selector(saveButtonHandle:)];
    self.title = @"Editor";
}


- (void)cancelButtonHandle:(id)doneButton
{
    [self.navigationController popViewControllerAnimated:YES];
    if (dismissBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            dismissBlock();
        });
    }
}


- (void)saveButtonHandle:(id)saveButton
{
    /// empty so far
}


- (void)disclosureButtonHandler:(UIButton*)btn withEvent:(UIEvent*)event {
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 3;
    }
    return 1;
}


- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* const BYRootBasicCellID = @"BasicCell";
    NSString* const BYRootNameCellID  = @"SYTextFieldCell";
    BOOL nameCell = !indexPath.section && !indexPath.row;
    
    NSString* cellIdentifier = nameCell ? BYRootNameCellID : BYRootBasicCellID;
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        if (nameCell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SYTextFieldCell"
                                                 owner:self
                                               options:nil] lastObject];
        }
        else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:cellIdentifier];
        }
    }
    
    if (nameCell) {
        SYTextFieldCell* textFieldCell = (SYTextFieldCell*)cell;
        textFieldCell.labelTitle.text  = @"Name";
        textFieldCell.textField.text   = @"Example Name";
    }
    else {
        cell.textLabel.text = [self cellTitleAtCell:[self cellTypeAtIndexPath:indexPath]];
        cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (NSString*)cellTitleAtCell:(SYEditRootCell)cellType {
    NSString* returnString = nil;
    switch (cellType) {
        case SYEditRootCellName:
            returnString = @"Name";
            break;
        case SYEditRootCellOrganizationType:
            returnString = @"Organization Type";
            break;
        case SYEditRootCellHomeItems:
            returnString = @"Home menu";
            break;
        case SYEditRootCellNowPage:
            returnString = @"Now Page";
            break;
        case SYEditRootCellGeoItems:
            returnString = @"Geo Items";
            break;
        case SYEditRootCellSocialMedia:
            returnString = @"Social Media";
            break;
        case SYEditRootCellContactInfo:
            returnString = @"Contacts Info";
            break;
        default:
            NSAssert(0x00, @"unreachable");
            break;
    }
    return returnString;
}

- (SYEditRootCell)cellTypeAtIndexPath:(NSIndexPath*)indexPath {
    if (indexPath.section == 0) {
        return SYEditRootCellName;
    }
    else if (indexPath.section == 1) {
        return SYEditRootCellOrganizationType;
    }
    else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return SYEditRootCellHomeItems;
        }
        else if (indexPath.row == 1) {
            return SYEditRootCellNowPage;
        }
        else {
            return SYEditRootCellGeoItems;
        }
    }
    else if (indexPath.section == 3) {
        return SYEditRootCellSocialMedia;
    }
    else if (indexPath.section == 4) {
        return SYEditRootCellContactInfo;
    }
    NSAssert(0x00, @"unreachable");
    return -1;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYEditRootCell cell = [self cellTypeAtIndexPath:indexPath];
    if (cell == SYEditRootCellName) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    else if (cell == SYEditRootCellOrganizationType) {
        [self performSegueWithIdentifier:@"toEditOrganizationTypeTableViewController" sender:self];
    }
    else if (cell == SYEditRootCellHomeItems) {
        [self performSegueWithIdentifier:@"toEditMenuItemsViewController" sender:self];
    }else if (cell == SYEditRootCellNowPage) {
        [self performSegueWithIdentifier:@"toEditNowPageViewController" sender:self];
    }else if (cell == SYEditRootCellGeoItems) {
        [self performSegueWithIdentifier:@"toEditGeoItemsTableViewController" sender:self];
    }else if (cell == SYEditRootCellSocialMedia) {
        [self performSegueWithIdentifier:@"toEditSocialMediaViewController" sender:self];
    }else if (cell == SYEditRootCellContactInfo) {
        _peopleNavigationController = [[ABPeoplePickerNavigationController alloc] init];
        _peopleNavigationController.peoplePickerDelegate = self;
        _peopleNavigationController.delegate             = self;
        // Display only a person's phone, email, and birthdate
        NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty],
                                   [NSNumber numberWithInt:kABPersonEmailProperty],
                                   [NSNumber numberWithInt:kABPersonBirthdayProperty], nil];
        
        
        _peopleNavigationController.displayedProperties = displayedItems;
        // Show the picker
        [self presentViewController:_peopleNavigationController animated:YES completion:nil];

    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toEditMenuItemsViewController"]) {
    } else if ([segue.identifier isEqualToString:@"toEditNowPageViewController"]) {
        SYEditTextViewController* textViewController = segue.destinationViewController;
        NSAssert2([textViewController isKindOfClass:[SYEditTextViewController class]],
                  @"wrong segue destination class, expected:%@, got:%@",
                  NSStringFromClass([SYEditTextViewController class]),
                  NSStringFromClass([textViewController class]));
        textViewController.initialText = [[[SYDataProvider sharedDataProvider] nowURL] absoluteString];
        textViewController.title       = @"Now URL";
        textViewController.textChangedBlock = ^(NSString* newText){
            /// write it to url.txt
        };
    }
    else if ([segue.identifier isEqualToString:@"toEditGeoItemsTableViewController"]) {

    }
    else if ([segue.identifier isEqualToString:@"toEditSocialMediaViewController"]) {
    }
}

#pragma mark - PeopleNavigationController
/// PeopleNavigationController doesn't support adding barButtons
/// this guide helps: http://www.scott-sherwood.com/ios5-removing-the-cancel-button-on-abpeoplepickernavigationcontroller/
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //set up the ABPeoplePicker controls here to get rid of he forced cacnel button on the right hand side but you also then have to
    // the other views it pcuhes on to ensure they have to correct buttons shown at the correct time.
    
    if([navigationController isKindOfClass:[ABPeoplePickerNavigationController class]]){
        UIViewController* topViewController = navigationController.topViewController;
        if ([topViewController isKindOfClass:[ABNewPersonViewController class]]) {
            topViewController.navigationItem.leftBarButtonItem
            = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                               style:UIBarButtonItemStyleBordered
                                              target:self
                                              action:@selector(abNewPersonBackBarButtonHandle:)];
        }
        else {
            topViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(peoplePickerNavigationControllerCancelAddPersonButtonHandle:)];
            
            topViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(peoplePickerNavigationControllerCancelButtonHandle:)];
        }
    }
}


- (void)peoplePickerNavigationControllerCancelButtonHandle:(id)cancelBarButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)peoplePickerNavigationControllerCancelAddPersonButtonHandle:(id)addPersonButtonHandle {
	ABNewPersonViewController *picker = [[ABNewPersonViewController alloc] init];
	picker.newPersonViewDelegate = self;
	
//	UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:picker];
    [_peopleNavigationController pushViewController:picker animated:YES];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    return YES;
}


- (void)newPersonViewController:(ABNewPersonViewController *)newPersonView
       didCompleteWithNewPerson:(ABRecordRef)person {
    
}

- (void)abNewPersonBackBarButtonHandle:(id)barButtonItem {
    [_peopleNavigationController popViewControllerAnimated:YES];
}

@end
