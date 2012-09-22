//
//  AppNMediaAppDelegate.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import <iAd/iAd.h>
#import "Reachability.h"

#define BASE_URL @"http://conferenceapps.net/"

@class MainParserClass;
@class MainViewController;
@class EventsListViewController;
@class EventsParserClass;
@interface AppNMediaAppDelegate : NSObject <UIApplicationDelegate,UIAlertViewDelegate, ADBannerViewDelegate> 
{
    //Reachability *reachability;
    Reachability *internetReach;
    
    UINavigationController *mainNavigationViewController;
    MainViewController *mainViewController;
    EventsListViewController *eventsListViewController;
    MainParserClass *mainParser;
    
    NSURL *responseUrl;
    BOOL isNetworkIsAvailable;
    
    ///////////////// Common UI
    UIImageView *poweredByBgView;
    UIImageView *logoImageView;
    UILabel *poweredByLabel;
    UILabel *tmLabel;
    UILabel *eventNameLabel;
    UITextView *eventNameTxtView;
    int selectedEvent;
    UIActivityIndicatorView *activityIndicator;
    
    UIImageView *poweredImageView;
    
       
    //////////// 26/06/2012 offline images 

    NSMutableDictionary *offLineImagesDict;
    NSMutableArray *speakersArray;
    NSMutableArray *sponsersArray;
    NSMutableArray *socialArray;
    NSMutableArray *newsArray;
    NSMutableArray *linksArray;
    NSMutableArray *exhibitorsArray;
    NSMutableArray *nearbyArray;
    NSMutableArray *partnersArray;
    NSMutableArray *photosArray;
    NSMutableArray *funFactsArray;
    NSMutableArray *vedioesArray;
    
    //////// new requirements
    BOOL runAppInOffline;
    
    //////////// 25/06/2012
    NSMutableDictionary *mainResponseDict;
    NSDictionary *mainResponseDictionary;
    NSMutableArray *eventsArray;
    NSMutableArray *allEventsInfoArray;
    //////////////////// Custom UI styles
//    NSMutableDictionary *customStylesDict;
    NSMutableDictionary *tmpStylesDict;
    /////// IAdds
    ADBannerView *bannerView;
    NSString *tokenId;
    //////// data synch timer
    NSTimer *timer;
    BOOL fromDataSynchMethod;
    EventsParserClass *eventParserClass;
     NSString *mainDeviceToken;
    
    BOOL isNetworkAvailable;
    
//    NSCache *imageCache;
    NSMutableDictionary *imageCache;
    UIImageView *footerView;

   
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property  BOOL isNetworkIsAvailable;
@property int selectedEvent;
@property(nonatomic,retain)UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain)UINavigationController *mainNavigationViewController;
/////// new requirements
@property BOOL runAppInOffline;
//////////// 25/06/2012
//@property(nonatomic,retain)NSMutableDictionary *customStylesDict;
@property(nonatomic,retain)NSMutableArray *allEventsInfoArray;
@property(nonatomic,retain)NSMutableDictionary *mainResponseDict;
@property(nonatomic,retain) NSDictionary *mainResponseDictionary;
@property(nonatomic,retain) NSMutableArray *eventsArray;
@property(nonatomic,retain) NSString *tokenId;
@property(nonatomic,retain) NSMutableDictionary *offLineImagesDict;
@property  BOOL fromDataSynchMethod;
@property(nonatomic,retain)NSString *mainDeviceToken;
-(void)callWebServices;
-(BOOL)networkCheckingMethod;
-(void)createCommonUI;
-(void)createCustomStyleDict;
-(void)callMainViewCreationMethod;
-(void)offLineAppMethod;
-(void)offLimeImagesStoringMethod;
-(NSString *)offlineImagesFilePath;
-(void)loadCompleteOffLineImages;
-(void)appStartMethod;
-(void)nodataResponseMethod;
- (void)layoutAnimated:(BOOL)animated;
/////// 25/06/2012
-(void)mainMethod;
-(void)tokenIdMethodStoreMethod;
-(void)dataSynchMethod :(NSString *)selectedTime;
-(void)callDataSynchMethod;
-(void)callDataSynchMethodAfterloadingTheApplication;
-(void)callOrNotDataSynchMethod;
-(void)pushNotifications;
-(void)dataSynchRestoreMethod;
//-(NetworkStatus)internetStatus;
//-(NetworkStatus)localWifi;
- (BOOL)updateReachabilityStatus:(Reachability *)reachability;
-(BOOL)isNetWorkAvailable;
-(BOOL)reachabilityChanged:(NSNotification*)note;


-(void)cacheImage:(NSData*)imageData withKey :(NSString*)urlKey;
-(void)clearCache;
-(UIImage*)getImageWithUrl:(NSString*)url;

@end
