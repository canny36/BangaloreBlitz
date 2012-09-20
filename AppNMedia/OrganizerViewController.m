//
//  OrganizerViewController.m
//  AppNMedia
//
//  Created by Srinivas on 10/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "OrganizerViewController.h"
#import "Organizer.h"

@interface OrganizerViewController ()

@end

@implementation OrganizerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [Organizer collection];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
