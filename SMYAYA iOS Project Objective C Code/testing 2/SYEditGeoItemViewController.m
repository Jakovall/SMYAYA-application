//
//  SYEditGeoItemViewController.m
//  SMYAYA
//
//  Created by myeyesareblind on 9/2/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYEditGeoItemViewController.h"
#import "Utility.h"
#import "SYDataProvider.h"


@interface SYEditGeoItemViewController ()
-(void)cancelButtonHandle:(id)cancelBarButton;

@end

@implementation SYEditGeoItemViewController
@synthesize geoItem, editCompletedBlock;
@synthesize cancelBlock,street,city,country,latitude,longitude,addressInfo,tableViews,titles,subTitle;


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
    /*
     {
     geolat = "38.8976831";
     geolong = "-77.0364972";
     subtitle = "presidents residence";
     title = "white house";
     },
     */
    //NSAssert(geoItem, @"no geoItem to edit");
//    _latitudeLabel.text     = geoItem[@"geolat"];
//    _longtitudeLabel.text   = geoItem[@"geolong"];
    if(geoItem){
        _subtitleTextfield.text = geoItem[@"subtitle"];
        _titleTextfield.text    = geoItem[@"title"];
        self.title              = geoItem[@"title"];
    }else{
        UIBarButtonItem* addBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(saveButtonHandle:)];
        self.navigationItem.rightBarButtonItem = addBarButtonItem;
        self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(cancelButtonHandle:)];
        _subtitleTextfield.text = @"";
        _titleTextfield.text    = @"";
        self.title              = @"";
    }

}

- (void) viewWillAppear:(BOOL)animated{
    
    //SocialNetworkItem* info;
    
    // street = [info getdataval];
    
    // Utility* info;
    if(geoItem){
        street = [geoItem valueForKey:@"street"];
        city = [geoItem valueForKey:@"city"];
        country = [geoItem valueForKey:@"country"];
        latitude = [geoItem valueForKey:@"geolat"];
        longitude = [geoItem valueForKey:@"geolong"];
    
    }else{
        
        street = [Utility getStreet];
        city = [Utility getCity];
        country = [Utility getCountry];
        latitude = [Utility getLatitude];
        longitude = [Utility getLongitude];
    }
    
    
    
    
    addressInfo.hidden = YES;
    if([street length]!=0 || [city length]!=0 || [country length]!=0 || [latitude length]!=0 || [longitude length]!=0){
        addressInfo.hidden = NO;
        addressInfo.text = [NSString stringWithFormat:@"street:%@\ncity:%@\ncountry:%@\nlatitude:%@\nlongitude%@",street,city,country,latitude,longitude];
    }
    NSLog(@"street value is %@,city%@,country%@,lat %@,lon %@", [geoItem valueForKey:@"street"],city,country,latitude,longitude);
  // [self.tableViews reloadSections:0 withRowAnimation:UITableViewRowAnimationNone];
    [tableViews reloadData];
   
}


- (void)viewWillDisappear:(BOOL)animated {
    if(geoItem){
    NSString* originSubtitle = geoItem[@"subtitle"];
    NSString* originTitle    = geoItem[@"title"];
    NSString* newTitle       = _titleTextfield.text;
    NSString* newSubtitle    = _subtitleTextfield.text;
    
    if (![originSubtitle isEqualToString:newSubtitle] || ![originTitle isEqualToString:newTitle]) {
        editCompletedBlock(newTitle, newSubtitle);
    }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)cancelButtonHandle:(id)cancelBarButton
{
    cancelBlock();
}

-(void)saveButtonHandle:(id)sender{
    if([street length]!=0 || [city length]!=0 || [country length]!=0 || [latitude length]!=0 || [longitude length]!=0){
        addressInfo.hidden = NO;
        addressInfo.text = [NSString stringWithFormat:@"street:%@\ncity:%@\ncountry:%@\nlatitude:%@\nlongitude%@",street,city,country,latitude,longitude];
    }
    
    if(([addressInfo.text length] != 0) && ([titles.text length] !=0) && ([subTitle.text length] !=0)){
    NSLog(@"saved data %@",titles.text);
    NSMutableDictionary* geoLocationItems = [[NSMutableDictionary alloc]init];
        if(street == nil){
            
            street =@"";
        }
        if(city == nil){
            city =@"";
        }
        if(country == nil ){
            
            country = @"";
        }
    [geoLocationItems setObject:[Utility getLatitude]  forKey:@"geolat"];
    [geoLocationItems setObject:[Utility getLongitude]  forKey:@"geolong"];
    [geoLocationItems setObject:titles.text  forKey:@"subtitle"];
    [geoLocationItems setObject:subTitle.text  forKey:@"title"];
    [geoLocationItems setObject:street  forKey:@"street"];
    [geoLocationItems setObject:city  forKey:@"city"];
    [geoLocationItems setObject:country  forKey:@"country"];
        
    
    NSLog(@"geolocations %@", geoLocationItems);
    
    [SYDataProvider addGeolocations:(NSMutableArray*)geoLocationItems];
    [self.parentViewController dismissViewControllerAnimated:YES
                             completion:nil];
    }
    else{
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Please select a location, a title, and a subtitle." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
    }
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell*)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* const BYRootBasicCellID = @"BasicCell";
    NSString* const BYRootNameCellID  = @"SYTextFieldCell";
    BOOL nameCell = !indexPath.section && !indexPath.row;
    
    NSString* cellIdentifier = nameCell ? BYRootNameCellID : BYRootBasicCellID;
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //if (!cell) {
        if(indexPath.section == 0){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier:cellIdentifier];
                 
            cell.textLabel.text = @"Set Pin...";
            if([street length]!=0 || [city length]!=0 || [country length]!=0 || [latitude length]!=0 || [longitude length]!=0){
            cell.detailTextLabel.text = addressInfo.text;
            cell.detailTextLabel.font=[UIFont fontWithName:@"Arial" size:15.0];
            cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
            cell.detailTextLabel.numberOfLines = 5;
            }else{
                
                cell.detailTextLabel.text = @"";
            }

        }
        else if(indexPath.section==1){
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier:cellIdentifier];
            titles = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, 215, 35)];
            titles.adjustsFontSizeToFitWidth = YES;
            titles.textColor = [UIColor blackColor];
            
            titles.placeholder = @"Title Name";
            titles.returnKeyType = UIReturnKeyDone;
            titles.text = _titleTextfield.text;
            titles.backgroundColor = [UIColor clearColor];
            titles.autocorrectionType = UITextAutocorrectionTypeNo;
            titles.autocapitalizationType = UITextAutocapitalizationTypeNone;
            titles.tag = 0;
            [titles addTarget:self
                     action:@selector(textFieldFinished:)
           forControlEvents:UIControlEventEditingDidEndOnExit];
            titles.clearButtonMode = UITextFieldViewModeNever;
            [titles setEnabled: YES];
            
            [cell.contentView addSubview:titles];
            cell.textLabel.text = @"Title";
            cell.textLabel.backgroundColor = [UIColor clearColor];
            
        }
        else{
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier:cellIdentifier];
            subTitle = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, 215, 35)];
            subTitle.adjustsFontSizeToFitWidth = YES;
            subTitle.textColor = [UIColor blackColor];
            
            subTitle.placeholder = @"Subtitle Name";
            subTitle.returnKeyType = UIReturnKeyDone;
            
            subTitle.backgroundColor = [UIColor clearColor];
            subTitle.autocorrectionType = UITextAutocorrectionTypeNo;
            subTitle.autocapitalizationType = UITextAutocapitalizationTypeNone;
            subTitle.tag = 0;
            [subTitle addTarget:self
                        action:@selector(textFieldFinished:)
              forControlEvents:UIControlEventEditingDidEndOnExit];
            subTitle.clearButtonMode = UITextFieldViewModeNever;
            [subTitle setEnabled: YES];
            subTitle.text = _subtitleTextfield.text;
            [cell.contentView addSubview:subTitle];
            cell.textLabel.text = @"SubTitle";
            cell.textLabel.backgroundColor = [UIColor clearColor];
            
            
        }
        
   // }
    
    
    return cell;
}


- (IBAction)textFieldFinished:(id)sender
{
    [sender resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TitleLoop = [menuitems objectAtIndex:indexPath.row];
   // NSString *selectedDetails = [TitleLoop objectForKey:@"content"];
   // [[NSUserDefaults standardUserDefaults] setValue:selectedDetails forKey:@"SelectedContent"];
    [Utility addStreet:[geoItem valueForKey:@"street"]];
    [Utility addCity:[geoItem valueForKey:@"city"]];
    [Utility addCountry:[geoItem valueForKey:@"country"]];

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self performSegueWithIdentifier:@"isAddGeoPinViewController" sender:self];
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    
	if(indexPath.section == 0){
        
        return 100.0;
    }
    return 40;
}


@end
