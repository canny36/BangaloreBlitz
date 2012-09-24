//
//  ContactUsViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 08/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "ContactUsViewController.h"
#import "AppNMediaAppDelegate.h"
#import "WebViewController.h"
#import "Util.h"

@implementation ContactUsViewController

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

-(IBAction)buttonClicked:(UIButton *)sender
{
    if (sender.tag == 0)
    {
        [self callMailCraetionMethod];  
    }
    else if(sender.tag == 1)
    {
        NSMutableDictionary *tmpDict = [appDelegate.eventsArray objectAtIndex:appDelegate.selectedEvent];
        NSString *strPhoneNumber = [tmpDict objectForKey:@"contactphone"] ;
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]])
        {
           // NSLog(@"%@",strPhoneNumber);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", strPhoneNumber ]]];
        } 
        else 
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You can't call from this device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
  
    }
}


-(void)callMailCraetionMethod
{
    MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
    mail.mailComposeDelegate = self;
    if ([MFMailComposeViewController canSendMail]) 
    {
        //Present the mail view controller
        NSMutableDictionary *tmpDict = [appDelegate.eventsArray objectAtIndex:appDelegate.selectedEvent];
        
        if ([tmpDict objectForKey:@"contactemail"]  != nil)
        {
            NSArray *toRecipients = [NSArray arrayWithObject:[tmpDict objectForKey:@"contactemail"]]; 
            [mail setToRecipients:toRecipients];
        }
        [self presentModalViewController:mail animated:YES];
        
    }
    //release the mail
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissModalViewControllerAnimated:YES];
    if (result == MFMailComposeResultFailed)
    {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@”Message Failed!” message:@”Your email has failed to send” delegate:self cancelButtonTitle:@”Dismiss” otherButtonTitles:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message Failed" message:@"Your email has failed to send" delegate:self cancelButtonTitle:@"Ok"  otherButtonTitles:nil];
        [alert show];
    }
}

-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)assignStyles
{
    titleFontName = [Util subTitleFontName];
    titleFontSize = @"15";
    subTitleFontName = [Util detailTextFontName];
    subTitleFontSize = @"15";
       
    [emailidLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    emailidLabel.textColor = [UIColor whiteColor];
    
    [emailidDataTextView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    emailidDataTextView.textColor = [UIColor whiteColor];
    
    [phoneNoLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    phoneNoLabel.textColor = [UIColor whiteColor];
    
    [phoneNoDataLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    phoneNoDataLabel.textColor = [UIColor whiteColor];
    
    [addressLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    addressLabel.textColor = [UIColor whiteColor];
    
    [urlLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
     urlLabel.textColor = [UIColor blueColor];
    
    [clientNameLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    clientNameLabel.textColor = [UIColor  whiteColor];
    
    [addressTextView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    addressTextView.textColor = [UIColor whiteColor];
    
    [urlTxtView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    urlTxtView.textColor = [UIColor whiteColor];
    
    NSMutableDictionary *tmpDict = [appDelegate.eventsArray objectAtIndex:appDelegate.selectedEvent];
        
    if ([tmpDict objectForKey:@"contactemail"]  != nil)
    {
        emailidDataTextView.text = [tmpDict objectForKey:@"contactemail"];
    }
    if ([tmpDict objectForKey:@"contactphone"] ) 
    {
        [phoneButton setTitle:[tmpDict objectForKey:@"contactphone"] forState:UIControlStateNormal];
        phoneNoDataLabel.text = [tmpDict objectForKey:@"contactphone"] ;
    }
    if ([tmpDict objectForKey:@"url"] ) 
    {
        urlTxtView.text = [tmpDict objectForKey:@"url"] ;
    }
    
    if ([tmpDict objectForKey:@"location"] ) 
    {
        addressTextView.text = [tmpDict objectForKey:@"location"] ;
    }
    
   // NSLog(@"%@",[appDelegate.eventsArray objectAtIndex:0]);
    if ([[[appDelegate.mainResponseDictionary objectForKey:@"root"] objectForKey:@"client"] objectForKey:@"clientname"]) 
    {
        clientNameLabel.text = [[[appDelegate.mainResponseDictionary objectForKey:@"root"] objectForKey:@"client"] objectForKey:@"clientname"] ;
    }


    urlTxtView.textColor = [UIColor whiteColor];
    
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    [textView resignFirstResponder];
    if (textView.tag == 0)
    {
        [self callMailCraetionMethod];  
    }
    else
    {
         NSMutableDictionary *tmpDict = [appDelegate.eventsArray objectAtIndex:appDelegate.selectedEvent];
        if ([tmpDict objectForKey:@"url"] ) 
        {
//            NSString *urlString = [tmpDict objectForKey:@"url"];
//            if (webViewController != nil)
//            {
//                webViewController = [[WebViewController alloc] init];
//
//            }
//            
//            
//            webViewController.urlString = urlString;
//            
//            [self presentModalViewController:webViewController animated:YES];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[tmpDict objectForKey:@"url"]]];

        }
    }
    return NO;
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

    self.title = @"Contact Us";
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;

    contactUsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    if ([[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"contactus"]  isKindOfClass:[NSDictionary class]]) 
    {
        [contactUsArray addObject:[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"contactus"] ];
    }
    else
    {
        [contactUsArray addObjectsFromArray:[[appDelegate.mainResponseDict objectForKey:@"event"]  objectForKey:@"contactus"]];
    }  
    [self assignStyles];
    
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
