//
//  MyFavoritesDetailsViewontroller.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 08/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "MyFavoritesDetailsViewontroller.h"
//#import "AgendaDetailsViewController.h"
#import "AppNMediaAppDelegate.h"
#import "WebViewController.h"
@implementation MyFavoritesDetailsViewontroller
@synthesize agendaSelected;
@synthesize selectedDict;
@synthesize selectedIndex;

- (NSString *)dataFilePathForOfflineImages
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"offlineImages.plist"];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}
-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(IBAction)viewProfileButtonClicked:(id)sender
{
    if ([selectedDict objectForKey:@"weblink"]!= nil)
    {
        NSString *webUrl = [selectedDict objectForKey:@"weblink"];
        webView = [[WebViewController alloc] init];
        
        webView.urlString = webUrl;
        
        [self presentModalViewController:webView animated:YES];  
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No details available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

}

-(void)loadSpeakerImage
{
   
    NSString *baseUrl = BASE_URL;
    if ([selectedDict objectForKey:@"speakerphoto"] != nil) 
    {
        NSString *imageUrl = [selectedDict objectForKey:@"speakerphoto"];
        baseUrl = [baseUrl stringByAppendingString:imageUrl];
        
    }
    NSURL *url=[NSURL URLWithString:baseUrl];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    if(img)
    {
        speakerImageView.image = img;
    }
    else
    {
        speakerImageView.image = [UIImage imageNamed:@"NoImage.png"];
    }
}
-(void)makeaMap
{
    NSString *tmpStr = @"";     
    if ([selectedDict objectForKey:@"address"]!=nil)
    {
        tmpStr = [selectedDict objectForKey:@"address"];
    }
    
    openMap = [[mapViews alloc] init];
    
    openMap.urlString = tmpStr;
    
    [self presentModalViewController:openMap animated:YES];
}

-(void)assignData
{
    if (agendaSelected == YES)
    {
        if ([selectedDict objectForKey:@"agendaspeaker"] != nil)
        {
            agendaSpeakerDataLabel.text =[selectedDict objectForKey:@"agendaspeaker"]; 
        }
        
        if ([selectedDict objectForKey:@"title"] != nil)
        {
            AgendTitleDataTxtView.text = [selectedDict objectForKey:@"title"];  
        } 
        
        if ([selectedDict objectForKey:@"presenter_type"] != nil)
        {
            agendaTypeDataLabel.text = [selectedDict objectForKey:@"presenter_type"];  
        }
        
        if ([selectedDict objectForKey:@"address"] != nil)
        {
            AgendaAddressDataTxtView.text = [selectedDict objectForKey:@"address"];
        }
        
        if ([selectedDict objectForKey:@"description"] != nil)
        {
            AgendaDescriptionDataTxtView.text = [selectedDict objectForKey:@"description"];
        }
             
    }
    else
    {
      
        
        if ([selectedDict objectForKey:@"firstname"] != nil)
        {
            NSString *nameStr = [selectedDict objectForKey:@"firstname"];
            nameStr = [nameStr stringByAppendingString:@" "];
            
            if ([selectedDict objectForKey:@"lastname"] != nil)
            {
                nameStr = [nameStr stringByAppendingString:[selectedDict objectForKey:@"lastname"]];
            }

            nameTxtView.text =nameStr; 
        }
        
        
        if ([selectedDict objectForKey:@"city"]!= nil)
        {
            cityDataLabel.text = [selectedDict objectForKey:@"city"];
        }
        
        
        if ([selectedDict objectForKey:@"country"]!= nil)
        {
            countryDataLabel.text = [selectedDict objectForKey:@"country"];
        }
        
        if ([selectedDict objectForKey:@"title"] != nil)
        {
            titleDataLabel.text =[selectedDict objectForKey:@"title"]; 
        }
        
        if ([selectedDict objectForKey:@"description"] != nil)
        {
            descriptionTxtView.text =[selectedDict objectForKey:@"description"]; 
        }
        
        
    }
}

-(void)assignStyles
{
 
        titleFontName =@"Helvetica-Bold";
        titleFontSize = @"14";
        
        subTitleFontName =@"Helvetica";
        subTitleFontSize = @"12";
        
   

    
    [nameLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    nameLabel.textColor = [UIColor whiteColor];
    
    [titleLabel setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];
    titleLabel.textColor = [UIColor whiteColor];
    
    [titleDataLabel setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];
    titleDataLabel.textColor = [UIColor whiteColor];
    
    [cityLabel setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];
    cityLabel.textColor = [UIColor whiteColor];
    
    [cityDataLabel setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];
    cityDataLabel.textColor = [UIColor whiteColor];
    
    
    [countryLabel setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];
    countryLabel.textColor = [UIColor whiteColor];
    
    [countryDataLabel setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];
    countryDataLabel.textColor = [UIColor whiteColor];
    
       
    [descriptionLabel setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];
     descriptionLabel.textColor = [UIColor whiteColor];
    
    [nameTxtView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    nameTxtView.textColor = [UIColor whiteColor];
   
    [titleTxtView setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];
    titleTxtView.textColor = [UIColor whiteColor];
    
    [descriptionTxtView setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];
    descriptionTxtView.textColor = [UIColor whiteColor];
    
    [agendaSpeakerLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    agendaSpeakerLabel.textColor = [UIColor whiteColor];
    
    [agendaTitleLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    agendaTitleLabel.textColor = [UIColor whiteColor];
    
    [agendaDescriptionLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    agendaDescriptionLabel.textColor = [UIColor whiteColor];

    [agendaTypeLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    agendaTypeLabel.textColor = [UIColor whiteColor];
    
    [agendaAddressLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    agendaAddressLabel.textColor = [UIColor whiteColor];
    
    [agendaSpeakerDataLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    agendaSpeakerDataLabel.textColor = [UIColor whiteColor];
    
    [agendaTypeDataLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    agendaTypeDataLabel.textColor = [UIColor whiteColor];
    
    [agendaSpeakerLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    agendaSpeakerLabel.textColor = [UIColor whiteColor];
    
    [AgendaDescriptionDataTxtView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    AgendaDescriptionDataTxtView.textColor = [UIColor whiteColor];
    
    [AgendaAddressDataTxtView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    AgendaAddressDataTxtView.textColor = [UIColor whiteColor];
    
    [AgendTitleDataTxtView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    AgendTitleDataTxtView.textColor = [UIColor whiteColor];
  
    
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
    [self assignStyles];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;

    imagesArray = [[NSMutableArray alloc] init];
    
    if (agendaSelected == YES)
    {
        agendaScrollView.hidden = NO;
        speakersScrollView.hidden = YES;
        agendaScrollView.frame =CGRectMake(10, 50, 300, 280);
        [agendaScrollView setContentSize:CGSizeMake(300, 400)];
        agendaScrollView.showsVerticalScrollIndicator= NO;
    }
    else
    {
        agendaScrollView.hidden = YES;
        speakersScrollView.hidden = NO; 
        speakersScrollView.frame =CGRectMake(10, 50, 300, 280);
        [speakersScrollView setContentSize:CGSizeMake(300, 400)];
        speakersScrollView.showsVerticalScrollIndicator = NO;
        
        if (appDelegate.runAppInOffline == NO) 
        {
            [self performSelectorInBackground:@selector(loadSpeakerImage) withObject:nil];
        }
        else
        {
            NSString *filePath = [self dataFilePathForOfflineImages];
            if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
            {
                NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
                
                if ([tmpDict objectForKey:@"offLinespeakerImagesArr"]!= nil)
                {
                    [imagesArray addObjectsFromArray:[tmpDict objectForKey:@"offLinespeakerImagesArr"]];
                    
                    if (selectedIndex < [imagesArray count])
                    {
                        speakerImageView.image = [UIImage imageWithData:[imagesArray objectAtIndex:selectedIndex]];
                    }
                    else
                    {
                        speakerImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
  
                    }
                    
                }
                else
                {
                    speakerImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
   
                }
                
                
                
            }
            else
            {
                speakerImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
            }
        }
    }
    [self assignData];
    
    [subBgView setFrame:CGRectMake(10, 5, 300, 280)];
    
    UITapGestureRecognizer *txtTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeaMap)];
    [AgendaAddressDataTxtView addGestureRecognizer:txtTapGesture];
    

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
