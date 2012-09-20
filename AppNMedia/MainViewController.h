//
//  MainViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
@class AppNMediaAppDelegate;
@class AgendaListViewController;
@class SpeakersViewController;
@class SponsersViewController;
@class LinksViewController;
@class NewsViewController;
@class PhotosViewController;
@class VideosViewController;
@class SocialViewController;
@class NearbyViewController;
@class ExhibitorsViewController;
@class PartnersViewController;
@class MyFavotitesViewController;
@class AboutUsViewController;
@class ContactUsViewController;
@class EventIntroViewController;
@class SettingsViewController;
@class FunFactsViewController;
@class WebViewController;
@class OrganisersViewController;
@class SupportedViewController;

@interface MainViewController : UIViewController <UIScrollViewDelegate>
{
    IBOutlet UIImageView *mainBgView;
    
    
    IBOutlet UIScrollView *dashBordScrollView;
    IBOutlet UIPageControl *pageControl;
    /////////////////////////////
    IBOutlet UIButton *agendaButton;
    IBOutlet UIButton *speakersButton;
    IBOutlet UIButton *sponsersButton;
    IBOutlet UIButton *linksButton;
    IBOutlet UIButton *newsButton;
    IBOutlet UIButton *photosButton;
    IBOutlet UIButton *videosButton;
    IBOutlet UIButton *socialButton;
    IBOutlet UIButton *nearbyButton;
    IBOutlet UIButton *exhibitorsButton;
    IBOutlet UIButton *partnersButton;
    IBOutlet UIButton *myFavouriteButton;
    IBOutlet UIButton *aboutButton;
    IBOutlet UIButton *contactUsButton;
    IBOutlet UIButton *searchButton;
    IBOutlet UIButton *eventIntroButton;
    IBOutlet UIButton *registerNowButton;
    IBOutlet UIButton *settingsButton;
    IBOutlet UIButton *funFactsButton;
    IBOutlet UIButton *organizersButton;
    IBOutlet UIButton *supportedByButton;
 
    IBOutlet UIButton *programButton;
    int setOfIconImages;
    /////////////// View controllers
    AppNMediaAppDelegate      *appDelegate;
    AgendaListViewController  *agendaListViewController;
    SpeakersViewController    *speakersViewController;
    SponsersViewController    *sponsersViewController;
    LinksViewController       *linksViewController;
    NewsViewController        *newsViewController;
    PhotosViewController      *photosViewController;
    VideosViewController      *videosViewController;
    SocialViewController      *socialViewController;
    NearbyViewController      *nearbyViewController;
    ExhibitorsViewController  *exhibitorsViewController;
    PartnersViewController    *partnersViewController;
    MyFavotitesViewController *myFavoritesViewController;
    AboutUsViewController     *aboutUsViewController;
    ContactUsViewController   *contactUsViewController;
    EventIntroViewController  *eventIntroViewController;
    SettingsViewController    *settingsViewController;
    FunFactsViewController    *funFactsViewController;
    WebViewController         *webViewController;
    OrganisersViewController  *organisersViewController;
    SupportedViewController   *supporterViewController;
    ////////////////////////
  
    
}
-(IBAction)mainViewButtonClicked:(UIButton *)sender;
-(IBAction)pageControlPageChanged:(id)sender;
-(void)assignStyles;
@end
