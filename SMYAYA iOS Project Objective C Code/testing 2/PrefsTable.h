//
//  PrefsTable.h
//  testing 2
//
//  Created by Christopher Dollinger on 6/8/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrefsTable : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *BackgroundPref;
}
@property (strong, nonatomic) IBOutlet UITableView *BackgroundPref;

@end
