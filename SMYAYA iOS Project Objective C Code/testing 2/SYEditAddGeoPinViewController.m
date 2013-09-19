//
//  SYEditAddGeoPinViewController.m
//  SMYAYA
//
//  Created by chary on 12/09/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYEditAddGeoPinViewController.h"
#import "SocialNetworkItem.h"
#import "SYEditGeoItemViewController.h"
#import "Utility.h"
#import "SYEditForwardGeoMapViewController.h"

#define SPAN 0.2f;

@interface SYEditAddGeoPinViewController ()

@end

@implementation SYEditAddGeoPinViewController

@synthesize geoPin,street,city,country,latValue,longValue;
@synthesize geocoder = _geocoder,addressTable,spinner;

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
    latValue = @"";
    longValue = @"";
    
    spinner.hidden =YES;
   
    	
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"self is %@",self);
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"dissaper");
    NSLog(@"self is dis%@",self);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [dot removeFromSuperview];
    dot = nil;
 //  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
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
    if (!cell) {
        if(indexPath.section == 0){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier:cellIdentifier];
            street = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, 215, 35)];
            street.adjustsFontSizeToFitWidth = YES;
            street.textColor = [UIColor blackColor];
            
            street.placeholder = @"Street Name";
            street.returnKeyType = UIReturnKeyDone;
            
            street.backgroundColor = [UIColor clearColor];
            street.autocorrectionType = UITextAutocorrectionTypeNo;
            street.autocapitalizationType = UITextAutocapitalizationTypeNone;
            street.tag = 0;
            [street addTarget:self
                              action:@selector(textFieldFinished:)
                    forControlEvents:UIControlEventEditingDidEndOnExit];
            street.clearButtonMode = UITextFieldViewModeNever;
            street.text = [Utility getStreet];
            [street setEnabled: YES];
            [street becomeFirstResponder];
            [cell.contentView addSubview:street];
            cell.textLabel.text = @"Street";
            //cell.detailTextLabel.text= @"example Name";
            
            
        }
        else if(indexPath.section==1){
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier:cellIdentifier];
            city = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, 215, 35)];
            city.adjustsFontSizeToFitWidth = YES;
            city.textColor = [UIColor blackColor];
            
            city.placeholder = @"City Name";
            city.returnKeyType = UIReturnKeyDone;
            
            city.backgroundColor = [UIColor clearColor];
            city.autocorrectionType = UITextAutocorrectionTypeNo;
            city.autocapitalizationType = UITextAutocapitalizationTypeNone;
            city.tag = 0;
            [city addTarget:self
                              action:@selector(textFieldFinished:)
                    forControlEvents:UIControlEventEditingDidEndOnExit];
            city.clearButtonMode = UITextFieldViewModeNever;
            [city setEnabled: YES];
            city.text = [Utility getCity];
            
            [cell.contentView addSubview:city];
            cell.textLabel.text = @"City";

        }
        else{
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier:cellIdentifier];
            country = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, 215, 35)];
            country.adjustsFontSizeToFitWidth = YES;
            country.textColor = [UIColor blackColor];
            
            country.placeholder = @"Country Name";
            country.returnKeyType = UIReturnKeyDone;
            
            country.backgroundColor = [UIColor clearColor];
            country.autocorrectionType = UITextAutocorrectionTypeNo;
            country.autocapitalizationType = UITextAutocapitalizationTypeNone;
            country.tag = 0;
            [country addTarget:self
                              action:@selector(textFieldFinished:)
                    forControlEvents:UIControlEventEditingDidEndOnExit];
            country.clearButtonMode = UITextFieldViewModeNever;
            [country setEnabled: YES];
            country.text = [Utility getCountry];
            [cell.contentView addSubview:country];
            cell.textLabel.text = @"Country";

            
        }
        
    }

    
    return cell;
}



- (void)keyboardWillShow:(NSNotification *)note {
    
	   
    [self performSelector:(@selector(checkKeyBoard)) withObject:nil afterDelay:0];

    
}


- (BOOL) findKeyboard:(UIView *) superView;
{
    UIView *currentView;
    if ([superView.subviews count] > 0) {
        for(int i = 0; i < [superView.subviews count]; i++)
        {
            
            currentView = [superView.subviews objectAtIndex:i];
            if([[currentView description] hasPrefix:@"<UIKeyboard"] == YES)
            {
                
               
                dot = [UIButton buttonWithType:UIButtonTypeCustom];
				dot.frame = CGRectMake(228, 167, 106, 53);
				[dot setImage:[UIImage imageNamed:@"find.PNG"] forState:UIControlStateNormal];
				[dot setImage:[UIImage imageNamed:@"find.PNG"] forState:UIControlStateHighlighted];
				[currentView addSubview:dot];
				[dot addTarget:self action:@selector(showGeoLocation:)  forControlEvents:UIControlEventTouchUpInside];
                
                return YES;
            }
            if ([self findKeyboard:currentView]) return YES;
        }
    }
    
    return NO;
    
}


-(void) checkKeyBoard {
    UIWindow* tempWindow;
    
    for(int c = 0; c < [[[UIApplication sharedApplication] windows] count]; c ++)
    {
        tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:c];
        if ([self findKeyboard:tempWindow])
            NSLog(@"Finally, I found it");
    }
}







- (IBAction)textFieldFinished:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)showGeoLocation:(id)sender{
   
    
    [self performSegueWithIdentifier:@"toEditForwardGeoMapViewController" sender:self];
    //[street resignFirstResponder];
   // [city resignFirstResponder];
   // [country resignFirstResponder];
   /* [spinner setHidden:NO];
    [spinner startAnimating];
    
    if (!self.geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    NSString *address = [NSString stringWithFormat:@"%@ %@ %@", street.text, city.text, country.text];
    
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            CLLocation *location = placemark.location;
            CLLocationCoordinate2D center = location.coordinate;
            latValue = [NSString stringWithFormat:@"%f", center.latitude];
            longValue = [NSString stringWithFormat:@"%f", center.longitude];
            MKCoordinateRegion startupRegion;
            
            MKCoordinateSpan span;
            span.latitudeDelta = SPAN;
            span.longitudeDelta = SPAN;
            
            startupRegion.center = center;
            startupRegion.span = span;
            [self.geoPin setMapType:MKMapTypeStandard];
            [self.geoPin setRegion:startupRegion animated:YES];
            [self.geoPin regionThatFits:startupRegion];
            
            Geopin *addAnnotation = [[Geopin alloc] init];
            addAnnotation.title = street.text;
            addAnnotation.subtitle = city.text;
            addAnnotation.coordinate = center;
            [self.geoPin addAnnotation:addAnnotation];
            [spinner setHidden:YES];
            [spinner stopAnimating];

        }else{
            [spinner setHidden:YES];
            [spinner stopAnimating];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Sorry! No placemark found." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            
            
        }
           }];*/
    
  
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toEditForwardGeoMapViewController"]) {
        [Utility addStreet:street.text];
        [Utility addCity:city.text];
        [Utility addCountry:country.text];
       // SYEditForwardGeoMapViewController* editForwardGeoMapViewController = segue.destinationViewController;
       // editForwardGeoMapViewController.street = street.text;
        
           }
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == 1) {
		//OK clicked
	} else {
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelGeoPin:(id)sender{
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (IBAction)saveGeoPin:(id)sender{
    
  /*  SocialNetworkItem* info = [[SocialNetworkItem alloc] init];
    
   // info.street = street.text;
    [info adddata:street.text];
    NSLog(@"street set value1 %@",street.text);
    NSLog(@"street set value %@",[info getdataval]);*/
   // Utility* info;
    
    [Utility addStreet:street.text];
    [Utility addCity:city.text];
    [Utility addCountry:country.text];
    [Utility addLatitude:latValue];
    [Utility addLongitude:longValue];
    [self dismissViewControllerAnimated:YES
                             completion:nil];
       
}

-(void) dealloc {
   // [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
