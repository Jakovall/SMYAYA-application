//
//  SYEditGeoItemViewController.m
//  SMYAYA
//
//  Created by myeyesareblind on 9/2/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import "SYEditGeoItemViewController.h"

@interface SYEditGeoItemViewController ()
-(void)cancelButtonHandle:(id)cancelBarButton;

@end

@implementation SYEditGeoItemViewController
@synthesize geoItem, editCompletedBlock;
@synthesize cancelBlock;


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
        UIBarButtonItem* addBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:nil
                                                                            action:nil];
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

@end
