//
//  SpeakersViewDetailsController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "SpeakersViewDetailsController.h"
#import "AppNMediaAppDelegate.h"
#import "SpeakersViewController.h"
#import "WebViewController.h"
#import "UIImage+scale.h"
#import "Util.h"

@implementation SpeakersViewDetailsController
@synthesize selectedDict;
@synthesize selectedRow;
@synthesize svc;
@synthesize addedToMyfavorites;
@synthesize fromSearchTable;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)favoritesButtonClicked:(id)sender
{
    if (fromSearchTable == NO)
    {
        if (buttonSelected == NO)
        {
            buttonSelected = YES;
            [favoritesButton setImage:[UIImage imageNamed:@"gold_star.png"] forState:UIControlStateNormal];
            [svc addOrDeleteFromMyFavorites:selectedRow checkMark:buttonSelected fromSearchTable:fromSearchTable];
        }
        else
        {
            buttonSelected = NO;
            [favoritesButton setImage:[UIImage imageNamed:@"gray_star.png"] forState:UIControlStateNormal];
            [svc addOrDeleteFromMyFavorites:selectedRow checkMark:buttonSelected fromSearchTable:fromSearchTable];
        }

    }
    else
    {
        if (buttonSelected == NO)
        {
            buttonSelected = YES;
            [favoritesButton setImage:[UIImage imageNamed:@"gold_star.png"] forState:UIControlStateNormal];
            [svc myFavoritesAddingFromSearchResultsTableDetailsController:selectedDict checkMark:YES];
        }
        else
        {
            buttonSelected = NO;
            [favoritesButton setImage:[UIImage imageNamed:@"gray_star.png"] forState:UIControlStateNormal];
            [svc myFavoritesAddingFromSearchResultsTableDetailsController:selectedDict checkMark:NO];
        }
    }
    
}

-(IBAction)viewProfileButtonClicked:(id)sender
{
    
//    //weblink
//    if ([selectedDict objectForKey:@"weblink"]!= nil)
//    {
//        NSString *webUrl = [selectedDict objectForKey:@"weblink"];
//        webView = [[WebViewController alloc] init];
//        
//        webView.urlString = webUrl;
//        
//        [self presentModalViewController:webView animated:YES];  
//        
//    }
//    else
//    {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No details available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
//    }
    
    
    
    if ([selectedDict objectForKey:@"weblink"] != nil) 
    {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[selectedDict objectForKey:@"weblink"]]])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[selectedDict objectForKey:@"weblink"]]];
        }

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No details available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
     
}

-(void)loadSpeakerImage
{
    NSString *logo = [selectedDict objectForKey:@"speakerphoto"];
    
    
    if (logo == nil || [logo isEqualToString:@""]) {
        
        return;
    }

    NSMutableString *mainlogo = [NSMutableString stringWithString:BASE_URL];
    [mainlogo appendString:logo];
    NSLog(@" URL AT  %@  ",  mainlogo);
      
    ImageDownloader *downloader = [ImageDownloader shareInstance];
    
    UIImage *image = [downloader getImage:mainlogo];
    if (image != nil) {
         NSLog(@" HIT AT  %@  ",  mainlogo);
        speakerImageView.image = image;
        
    }else{
        
        ImageLoader *loader = [[ImageLoader alloc]initWithUrl:mainlogo withSize: CGSizeZero delegate:self];
       [downloader addOperation:loader];
                               
    }
    

                           
//    if ([svc.offlineSpeakersImagesArr count] >0)
//    {
//        if (selectedRow < [svc.offlineSpeakersImagesArr count])
//        {
//            speakerImageView.image = [UIImage imageWithData:[svc.offlineSpeakersImagesArr objectAtIndex:selectedRow]]; 
//        } 
//        else
//        {
//        speakerImageView.image = [UIImage imageNamed:@"NoImage.png"];
//        }
//    }
//    else
//    {
//        NSString *baseUrl =   BASE_URL;
//    if ([selectedDict objectForKey:@"speakerphoto"] != nil) 
//    {
//        NSString *imageUrl = [selectedDict objectForKey:@"speakerphoto"];
//        baseUrl = [baseUrl stringByAppendingString:imageUrl];
//        
//    }
//    NSURL *url=[NSURL URLWithString:baseUrl];
//    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
//    if(img)
//    {
//        speakerImageView.image = img;
//    }
//    else
//    {
//        speakerImageView.image = [UIImage imageNamed:@"NoImage.png"];
//    }
//    }

}
           
 -(void)onDownloadCompletion:(UIImage*)image : (ImageLoader*)imageLoader{
          
     [self performSelectorOnMainThread:@selector(updateCell) withObject:imageLoader waitUntilDone:NO];
  }


-(void)onErrorLoadingImage:(ImageLoader*)imageLoader{
    
}
                           
                            
 -(void)updateCell:(ImageLoader*)loader{
     
     ImageDownloader *downloader = [ImageDownloader shareInstance];
     UIImage *image = [downloader getImage:loader.url];
     speakerImageView.image = image;
     
  }
                            
                           
-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)assignStyles
{
    titleFontName =@"Helvitica-Bold";
    titleFontSize = @"14";
    subTitleFontName = @"Helvitica";
    subTitleFontSize = @"12";


    
    speakerDescriptionTxtView.text  = [selectedDict objectForKey:@"description"]; 
    
    CGRect frame = speakerDescriptionTxtView.frame;
    int height = speakerDescriptionTxtView.contentSize.height;
    if (height > 130)
    {
        frame.size.height = 130;
    }
    else
    {
        frame.size.height = height;
    }
    speakerDescriptionTxtView.frame = frame;
    
    nameStr = [selectedDict objectForKey:@"firstname"];
    nameStr = [nameStr stringByAppendingString:@" "];
    if ([selectedDict objectForKey:@"lastname"] != nil)
    {
        nameStr = [nameStr stringByAppendingString:[selectedDict objectForKey:@"lastname"]];
    }
    
    speakerDeatilsTxtView.text = nameStr;
    [speakerDeatilsTxtView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    
    if ([selectedDict objectForKey:@"city"]!= nil)
    {
        byDataLabel.text = [selectedDict objectForKey:@"city"];
    }
    
    
    if ([selectedDict objectForKey:@"country"]!= nil)
    {
        countryDataLabel.text = [selectedDict objectForKey:@"country"];
    }
    
    if ([selectedDict objectForKey:@"title"]!= nil)
    {
        typeDataLabel.text = [selectedDict objectForKey:@"title"];
    }

    speakerDeatilsTxtView.textColor = [UIColor whiteColor];
    
    
    [speakerDescriptionTxtView setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];
    speakerDescriptionTxtView.textColor = [UIColor whiteColor];
    
    UIFont *labelFont = [UIFont fontWithName: [Util subTitleFontName] size:15  ];;
    UIColor *labelColor = [Util subTitleColor];
    
    [byLabel setFont:labelFont];
    byLabel.textColor = labelColor;
    
    [byDataLabel setFont:labelFont];
    byDataLabel.textColor = labelColor;
    
    [countryLabel setFont:labelFont];
    countryLabel.textColor = labelColor;
    
    [countryDataLabel setFont:labelFont];
    countryDataLabel.textColor = labelColor;
    
    [typeLabel setFont:labelFont];
    typeLabel.textColor = labelColor;
    
    [typeDataLabel setFont:labelFont];
    typeDataLabel.textColor = labelColor;
    
    [descriptionLabel setFont:labelFont];
    descriptionLabel.textColor = labelColor;
    
  
    
//    [self performSelectorInBackground:@selector(loadSpeakerImage) withObject:nil];

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
    
    backGroundColor = 1;
    [self assignStyles];
    
     UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
     self.navigationItem.rightBarButtonItem = homeButton;
    
    if (addedToMyfavorites == NO)
    {
        buttonSelected = NO;
        [favoritesButton setImage:[UIImage imageNamed:@"gray_star.png"] forState:UIControlStateNormal];
    }
    else
    {
        buttonSelected = YES;
        [favoritesButton setImage:[UIImage imageNamed:@"gold_star.png"] forState:UIControlStateNormal];
        
    }
   
    
    
       UIImage *image = [UIImage imageNamed:@"default_img.png"];
    
      CGSize size = image.size;
      CGSize itemSize = CGSizeMake(size.width/2, size.height/2);
      UIImage  *scaleimage  = [image scaleImageToSize:itemSize];
     speakerImageView.image = scaleimage;
    
    [self loadSpeakerImage];
    speakerScrollView.frame = CGRectMake(10, 10, 310, 270);
    speakerScrollView.contentSize = CGSizeMake(310, 400);
 

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
