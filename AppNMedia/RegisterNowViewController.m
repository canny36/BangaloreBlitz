//
//  RegisterNowViewController.m
//  AppNMedia
//
//  Created by Srinivas on 21/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "RegisterNowViewController.h"

@interface RegisterNowViewController ()

@end

@implementation RegisterNowViewController

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
    
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Register Now";
    
    webview.backgroundColor = [UIColor grayColor] ;
    
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"tbl html"]];
    [webview loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.view addSubview:webview];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
