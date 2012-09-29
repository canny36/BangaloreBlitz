//
//  MainViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//
#import "RegisterNowViewController.h"
#import "MainViewController.h"
#import "AppNMediaAppDelegate.h"
#import "SpeakersViewController.h"
#import "SponsersViewController.h"
#import "LinksViewController.h"
#import "NewsViewController.h"
#import "PhotosViewController.h"
#import "VideosViewController.h"
#import "SocialViewController.h"
#import "NearbyViewController.h"
#import "AgendaListViewController.h"
#import "PartnersViewController.h"
#import "ExhibitorsViewController.h"
#import "MyFavotitesViewController.h"
#import "ContactUsViewController.h"
#import "AboutUsViewController.h"
#import "EventIntroViewController.h"
#import "SettingsViewController.h"
#import "FunFactsViewController.h"
#import "WebViewController.h"
#import "OrganisersViewController.h"
#import "SupportedViewController.h"
#import "SponsorCategoryController.h"
#import "ProgramViewController.h"
#import "ViewController.h"
#import "GalleryViewController.h"
@implementation UINavigationBar (UINavigationBarCategory)  

- (void)drawRect:(CGRect)rect  
{  
	
    UIImage *image = [UIImage imageNamed:@"inner-head.png"]; 
    //UIImage *image = [UIImage ima; 
   	[image drawInRect:rect];  
}  

@end  


@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)pageControlPageChanged:(id)sender
{
  
    UIPageControl *_pageControl = (UIPageControl*)sender;
    
     int curpage = _pageControl.currentPage;
    
    CGPoint offset = dashBordScrollView.contentOffset;
    offset.x  = curpage*320;
    [dashBordScrollView setContentOffset:offset animated:YES];
    
}



-(IBAction)mainViewButtonClicked:(UIButton *)sender
{
    
    if (sender  == agendaButton)
    {
        agendaListViewController = [[AgendaListViewController alloc] init];
        [self.navigationController pushViewController:agendaListViewController animated:YES];
    }
    else if (sender == programButton)
    {
        ProgramViewController *controller = [[ProgramViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (sender == speakersButton)
    {
        speakersViewController = [[SpeakersViewController alloc] init];
        [self.navigationController pushViewController:speakersViewController animated:YES];
    }
    else if (sender == sponsersButton)
    {
//        sponsersViewController = [[SponsersViewController alloc] init];
//        [self.navigationController pushViewController:sponsersViewController animated:YES];
        
      SponsorCategoryController *controller =   [[SponsorCategoryController alloc]initWithNibName:@"SponsorCategoryController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if (sender == eventIntroButton)
    {
        eventIntroViewController = [[EventIntroViewController alloc] init];
        [self.navigationController pushViewController:eventIntroViewController animated:YES];
    }

    else if (sender == myFavouriteButton)
    {
        myFavoritesViewController = [[MyFavotitesViewController alloc] init];
        [self.navigationController pushViewController:myFavoritesViewController animated:YES];
        
    }
    else if (sender == videosButton)
    {
        videosViewController = [[VideosViewController alloc]init];
        [self.navigationController pushViewController:videosViewController animated:YES];
    }
    else if (sender  == socialButton )
    {
        socialViewController = [[SocialViewController alloc] init];
        [self.navigationController pushViewController:socialViewController animated:YES];
    }
    else if (sender  == photosButton )
    {
      
        GalleryViewController *controller = [[GalleryViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    else if(sender == exhibitorsButton)
    {
        exhibitorsViewController =[[ExhibitorsViewController alloc] init];
        [self.navigationController pushViewController:exhibitorsViewController animated:YES];
    }
    else if(sender == partnersButton )
    {
        partnersViewController = [[PartnersViewController alloc] init];
        [self.navigationController pushViewController:partnersViewController animated:YES];
        
    }
    else if(sender ==  linksButton)
    {
        linksViewController = [[LinksViewController alloc] init];
        [self.navigationController pushViewController:linksViewController animated:YES];
        
    }
    else if(sender == contactUsButton)
    {
        contactUsViewController = [[ContactUsViewController alloc] init];
        [self.navigationController pushViewController:contactUsViewController animated:YES];
        
    }
    else if(sender ==  aboutButton )
    {
        aboutUsViewController = [[AboutUsViewController alloc] init];
        [self.navigationController pushViewController:aboutUsViewController animated:YES];
        
    }
    
    else if (sender == newsButton)
    {
        newsViewController = [[NewsViewController alloc] init];
        [self.navigationController pushViewController:newsViewController animated:YES];
    }
    
    else if (sender == nearbyButton)
    {
        nearbyViewController =[[NearbyViewController alloc] init];
        [self.navigationController pushViewController:nearbyViewController  animated:YES];
    }
    else if (sender == settingsButton)
    {
        settingsViewController =[[SettingsViewController alloc] init];
        [self.navigationController pushViewController:settingsViewController  animated:YES];
    }
    else if (sender == funFactsButton)
    {
        
        funFactsViewController = [[FunFactsViewController alloc] init];
        [self.navigationController pushViewController:funFactsViewController  animated:YES];
    }
    else if (sender == organizersButton)
    {
        
        organisersViewController = [[OrganisersViewController alloc] init];
        [self.navigationController pushViewController:organisersViewController  animated:YES];
    }
    else if (sender == supportedByButton)
    {
        
        supporterViewController = [[SupportedViewController alloc] init];
        [self.navigationController pushViewController:supporterViewController  animated:YES];
    }else if( sender == registerNowButton){
        RegisterNowViewController *controller  = [[RegisterNowViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
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
-(void)viewWillAppear:(BOOL)animated
{

       [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated{
     
}

-(void)hideNavigationBar
{
    [self.navigationController.navigationBar setHidden:YES]; 

}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO]; 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
    
     
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    [dashBordScrollView setContentSize:CGSizeMake(640, 250)];
    dashBordScrollView.showsHorizontalScrollIndicator = NO;
    dashBordScrollView.pagingEnabled = YES;
    [dashBordScrollView setClipsToBounds:YES];
    
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


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView 
{
     CGPoint offset =dashBordScrollView.contentOffset;
    
    [pageControl setCurrentPage:(offset.x/320)];
//    NSLog(@" CUrrent OFFset %f origin.x = %f  ", dashBordScrollView.contentOffset.x  , dashBordScrollView.frame.origin.x);

    
}


@end
