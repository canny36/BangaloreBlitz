//
//  AboutUsViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 08/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AppNMediaAppDelegate.h"


@implementation AboutUsViewController
- (NSString *)dataFilePathForEventsInfo
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"events.plist"];
}

- (NSString *)dataFilePathForRunOfflineOnline
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"onlineOffline.plist"];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)makeaMap
{
    if ([appDelegate.eventsArray count]>0)
    {
        NSMutableDictionary *tmpDict = [appDelegate.eventsArray objectAtIndex:appDelegate.selectedEvent];
        
           NSString *tmpStr = @"";     
        if ([tmpDict objectForKey:@"location"]!=nil)
        {
            tmpStr = [tmpDict objectForKey:@"location"];
        }
  
    openMap = [[mapViews alloc] init];
    
    openMap.urlString = tmpStr;
    
    [self presentModalViewController:openMap animated:YES];
    }
}



-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)assignStyles
{


    titleFontName =@"Helvetica-Bold";
    titleFontSize = @"14";
    
    subTitleFontName =@"Helvetica";
    subTitleFontSize = @"12";


    
    [lastUpDatedLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    lastUpDatedLabel.textColor = [UIColor whiteColor];
    
    [appCurrentModeLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    appCurrentModeLabel.textColor = [UIColor whiteColor];
    
    [appCurrentModeDataLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    appCurrentModeDataLabel.textColor = [UIColor whiteColor];
    
    
    [lastUpDatedtextView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    lastUpDatedtextView.textColor = [UIColor whiteColor];
    
    
    
    [eventName setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    eventName.textColor = [UIColor darkGrayColor];
    
    [seeSettingsLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    seeSettingsLabel.textColor = [UIColor darkGrayColor];

    
    [locationTextView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    locationTextView.textColor = [UIColor darkGrayColor];
    
    
    [addressTextView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    addressTextView.textColor = [UIColor whiteColor];
    
   
    
    NSString *filePath = [self dataFilePathForEventsInfo];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        if ([tmpDict objectForKey:@"lastUpdatedTimeAndDate"]!=nil)
        {
            lastUpDatedtextView.text = [tmpDict objectForKey:@"lastUpdatedTimeAndDate"];

        }
        
        
    }
    
    
    if ([appDelegate.eventsArray count]>0)
    {
        NSMutableDictionary *tmpDict = [appDelegate.eventsArray objectAtIndex:appDelegate.selectedEvent];
        
        if ([tmpDict objectForKey:@"typename"]!=nil)
        {
            eventName.text = [tmpDict objectForKey:@"typename"];
        }
        
        if ([tmpDict objectForKey:@"location"]!=nil)
        {
            locationTextView.text = [tmpDict objectForKey:@"location"];
        }
        
        NSString *addressString=@"";
        
        if ([tmpDict objectForKey:@"address1"]!=nil)
        {
            addressString=[addressString stringByAppendingString:[tmpDict objectForKey:@"address1"]];

           addressString= [addressString stringByAppendingString:@", "]; 

        }
                      
        if ([tmpDict objectForKey:@"address2"]!= nil)
        {
           addressString= [addressString stringByAppendingString:[tmpDict objectForKey:@"address2"]]; 
           addressString= [addressString stringByAppendingString:@", "]; 
        }
        
        if ([tmpDict objectForKey:@"city"]!= nil)
        {
            addressString=[addressString stringByAppendingString:[tmpDict objectForKey:@"city"]]; 
            addressString=[addressString stringByAppendingString:@", "]; 
        }
        if ([tmpDict objectForKey:@"state"]!= nil)
        {
            addressString=[addressString stringByAppendingString:[tmpDict objectForKey:@"state"]]; 
            addressString=[addressString stringByAppendingString:@", "];
        }      
        if ([tmpDict objectForKey:@"zipcode"]!= nil)
        {
            addressString=[addressString stringByAppendingString:[tmpDict objectForKey:@"zipcode"]]; 
        }
           addressTextView.text = addressString;
   }
    
    
    
    
    NSString *onlineOfflinefilePath = [self dataFilePathForRunOfflineOnline];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:onlineOfflinefilePath];
        NSString *tmpStr = [tmpDict objectForKey:@"runAppInOffline"];
        
        
        if ([tmpStr isEqualToString:@"YES"])
        {
            appCurrentModeDataLabel.text = @"Offline";
        }
        else
        {
           appCurrentModeDataLabel.text = @"Online"; 
        }
    }
    else
    {
        appCurrentModeDataLabel.text = @"Online";
    }
    
    
        
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
    self.title = @"About";

    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;
    [self assignStyles];
    
    infoScrollView.frame = CGRectMake(10, 50, 300, 250);
    infoScrollView.contentSize = CGSizeMake(300, 250);
    infoScrollView.showsVerticalScrollIndicator= NO;
    
    
    UITapGestureRecognizer *txtTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeaMap)];
    [addressTextView addGestureRecognizer:txtTapGesture];
    addressTextView.userInteractionEnabled = YES;
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
