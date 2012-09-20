//
//  WebViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 18/07/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController
@synthesize urlString;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)homeButtonClicked
{
     [self dismissModalViewControllerAnimated:YES];  
}
-(void) dismissMaps
{
    
    [self dismissModalViewControllerAnimated:YES];    
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    UINavigationItem *navTitle = [[UINavigationItem alloc] initWithTitle:@"Web"];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(dismissMaps)];
          
    [navBar pushNavigationItem:navTitle animated:YES];
    
    navTitle.leftBarButtonItem = cancelButton;
    
    [self.view addSubview:navBar];
    
    UIWebView *showMap = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, 320, 436)];
    
    
    [showMap loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    
    [self.view addSubview:showMap];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
