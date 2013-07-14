//
//  MeView.h
//  testing 2
//
//  Created by Christopher Dollinger on 6/1/13.
//  Copyright (c) 2013 John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeView : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *myColorSelector;
@property (strong, nonatomic) IBOutlet UITextField *nameValue;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;


- (IBAction)changeBackgroundColor;
- (IBAction)changeName;

@end
