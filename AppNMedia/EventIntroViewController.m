//
//  EventIntroViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 19/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "EventIntroViewController.h"
#import "AppNMediaAppDelegate.h"
#import "Util.h"

@implementation EventIntroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *)flattenHTML:(NSString *)html 
{
    
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) 
    {
        
        [theScanner scanUpToString:@"<" intoString:NULL] ; 
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //
    html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"&", text] withString:@""];
    html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"amp", text] withString:@""];
    html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"nbsp", text] withString:@""];
    html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@";", text] withString:@""];
    html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"quot", text] withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"&lt;<b" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"ltb" withString:@""];

    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet illegalCharacterSet]];

    
    return html;
}


-(void)assignStyles
{
    titleFontName =@"Helvetica-Bold";
    titleFontSize = @"14";
    
    subTitleFontName =@"Helvetica";
    subTitleFontSize = @"12";
    
   
    [eventIntroTxtView setFont:[UIFont fontWithName:[Util subTitleFontName] size:15]];
    eventIntroTxtView.textColor = [Util subTitleColor];
    
    if ([appDelegate.eventsArray count]>0)
    {
        NSMutableDictionary *tmpDict = [appDelegate.eventsArray objectAtIndex:appDelegate.selectedEvent];
        if ([tmpDict objectForKey:@"description"]!= nil)
        {
            NSString *descriptionStr = [tmpDict objectForKey:@"description"];
            descriptionStr = [self flattenHTML:descriptionStr];
            descriptionStr = [descriptionStr stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            eventIntroTxtView.text = descriptionStr;
        }
    }
    
    
}
-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)dealloc
{
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
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    self.title = @"Event Intro";
    [self assignStyles];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;
    
    eventIntroTxtView.showsVerticalScrollIndicator = NO;
    transparentImageView.frame = CGRectMake(30, 70, 260, 250);

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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
