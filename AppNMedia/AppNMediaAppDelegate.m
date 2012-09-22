  //
//  AppNMediaAppDelegate.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "AppNMediaAppDelegate.h"
#import "MainViewController.h"
#import "MainParserClass.h"
#import "EventsParserClass.h"
#import "EventsListViewController.h"
#import "Reachability.h"

@implementation AppNMediaAppDelegate


@synthesize window=_window;
@synthesize selectedEvent;
@synthesize activityIndicator;
@synthesize mainNavigationViewController;
@synthesize isNetworkIsAvailable;
//////////////////// Custom UI styles
//@synthesize customStylesDict;
@synthesize runAppInOffline;

//////25/06/2012
@synthesize eventsArray;
@synthesize mainResponseDictionary;
@synthesize tokenId;
@synthesize mainResponseDict;
@synthesize allEventsInfoArray;
@synthesize offLineImagesDict;
@synthesize fromDataSynchMethod;
@synthesize mainDeviceToken;

static NSString *cachedImageDir;

- (NSString *)dataFilePathForEventsInfo
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"events.plist"];
}

- (NSString *)dataFilePathForOfflineImages
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"offlineImages.plist"];
}
- (NSString *)dataFilePathForTokenId
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"tokenId.plist"];
}
- (NSString *)dataFilePathForRunOfflineOnline
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"onlineOffline.plist"];
}


- (NSString *)dataFilePathForDataSynchMethod
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"dataSynch.plist"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self pushNotifications];
   
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(reachabilityChanged:) 
//                                                 name:kReachabilityChangedNotification 
//                                               object:nil];
    
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    };
    
    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    };
    
    [reach startNotifier];
    
        
    //[self isNetWorkAvailable];
    //isNetworkAvailable = [self isNetWorkAvailable];
      
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    
    if (timer != nil)
    {
        [timer invalidate];
        timer = nil;
    }

}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
       
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    selectedEvent = 0;
    [self mainMethod];
    
  }

-(void)mainMethod
{
    
    //isNetworkAvailable = [self isNetWorkAvailable];
    
    fromDataSynchMethod = NO;

    if (mainResponseDict !=nil) 
    {
       
    }
    else
    {
        mainResponseDict= [[NSMutableDictionary alloc] initWithCapacity:0];
    }  
    
    if (allEventsInfoArray == nil)
    {
        allEventsInfoArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    
//    if (customStylesDict !=nil) 
//    {
//        
//    }
//    else
//    {
//        customStylesDict= [[NSMutableDictionary alloc] initWithCapacity:0];
//    }
    
    if (eventsArray == nil)
    {
   
       eventsArray = [[NSMutableArray alloc] initWithCapacity:0];
        
    }
    
    NSString *filePath = [self dataFilePathForRunOfflineOnline];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        NSString *tmpStr = [tmpDict objectForKey:@"runAppInOffline"];
        
        
        if ([tmpStr isEqualToString:@"YES"])
        {
            [self offLineAppMethod];
            
        }
        else
        {
                        
            if (isNetworkAvailable)
            {
                [self appStartMethod];
                
            }
            else
            {
                [self offLineAppMethod];
     
            }
            
        }
        
    }
    else
    {
                
        if ( isNetworkAvailable)
        {
            [self appStartMethod];
        
        }
        else
        {
            [self offLineAppMethod];
        }
        
    }
    
    [self callMainViewCreationMethod];
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

///////////////////////////////////////
-(void)createCommonUI
{
    
    if ([poweredByBgView isDescendantOfView:self.window])
    {
        [poweredByBgView removeFromSuperview];
        poweredByBgView.frame = CGRectMake(50, 400, 220, 30);
    }
    else
    {
        poweredByBgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 400, 220, 30)];
    }
    
    poweredByBgView.layer.cornerRadius = 10.0;
    poweredByBgView.layer.masksToBounds = YES;
    poweredByBgView.layer.borderColor = [UIColor clearColor].CGColor;
    poweredByBgView.layer.borderWidth = 0.5;
    poweredByBgView.image = [UIImage imageNamed:@"powered_by_bg.png"];
//    [self.window addSubview:poweredByBgView];
    
    
    if ([poweredByLabel isDescendantOfView:self.window])
    {
        [poweredByLabel removeFromSuperview];
        poweredByLabel.frame = CGRectMake(85, 403, 150, 20);
    }
    else
    {
        poweredByLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 403, 150, 20)];
    }
     
    NSString *tmpStr = @"Powered by APPlusMedia";
    poweredByLabel.font = [UIFont systemFontOfSize:12];
    poweredByLabel.backgroundColor = [UIColor clearColor];
    poweredByLabel.textColor = [UIColor whiteColor];
    poweredByLabel.textAlignment = UITextAlignmentCenter;
    poweredByLabel.text = tmpStr;
//    [self.window addSubview:poweredByLabel];
    UIImage *image  = [UIImage imageNamed:@"log_inner.png"];
    
    if ([poweredByBgView isDescendantOfView:self.window]) {
        [poweredByBgView removeFromSuperview];
        poweredByBgView.frame = CGRectMake(10,375, 300, 63);
    }else{
        poweredImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 375, 300, 63)];
        poweredImageView.image = image;
    }
    
//    [self.window addSubview:poweredImageView];
   
    
    
    if ([tmLabel isDescendantOfView:self.window])
    {
        [tmLabel removeFromSuperview];
        tmLabel.frame = CGRectMake(227, 408, 15, 5);
    }
    else
    {
        tmLabel = [[UILabel alloc] initWithFrame:CGRectMake(227, 408, 15, 5)];
    }
    
    
    NSString *tmStr = @"TM";
    tmLabel.font = [UIFont systemFontOfSize:8];
    tmLabel.backgroundColor = [UIColor clearColor];
    tmLabel.textColor = [UIColor whiteColor];
    tmLabel.textAlignment = UITextAlignmentCenter;
    tmLabel.text = tmStr;
//    [self.window addSubview:tmLabel];
    
    
    
    
    if ([eventNameTxtView isDescendantOfView:self.window])
    {
        [eventNameTxtView removeFromSuperview];
        eventNameTxtView.frame = CGRectMake(10, 345 , 300, 60);
    }
    else
    {
        eventNameTxtView = [[UITextView alloc] initWithFrame:CGRectMake(10, 345 , 300, 60)];
    }
    
    if ([eventsArray count]>0) {
        NSMutableDictionary *tmpDict  = [eventsArray objectAtIndex:0];
        NSString *eventName = [tmpDict objectForKey:@"eventtitle"];
        eventNameTxtView.editable = NO;
        eventNameTxtView.userInteractionEnabled = NO;
        eventNameTxtView.font = [UIFont systemFontOfSize:18];
        eventNameTxtView.backgroundColor = [UIColor clearColor];
        eventNameTxtView.textColor = [UIColor whiteColor];
        eventNameTxtView.textAlignment = UITextAlignmentCenter;
        eventNameTxtView.text = eventName;

    }
    
   //    [self.window addSubview:eventNameTxtView]; 
    
    
    
}


//////////// Network checking methods

//-(NetworkStatus)internetStatus
//{
//    reachability=[Reachability sharedReachability];
//	NetworkStatus internetStatus=[reachability internetConnectionStatus];
//	if(internetStatus==NotReachable)
//	{
//		
//	}
//	else {
//		
//		isNetworkIsAvailable=YES;
//	}
//    
//	return internetStatus;    
//}
//
//-(NetworkStatus)localWifi
//{
//	reachability=[Reachability sharedReachability];
//	NetworkStatus wifiStatus=[reachability localWiFiConnectionStatus];
//	
//	if(wifiStatus==NotReachable)
//	{
//		
//	}
//	else {
//		isNetworkIsAvailable =YES;
//	}
//    
//	return wifiStatus;
//}


-(BOOL)networkCheckingMethod
{
//    isNetworkIsAvailable=NO;
//    
//    
//    NSLog(@"network availble  = %d",isNetworkIsAvailable);
//    
//    if(isNetworkIsAvailable==NO)
//    {
//        return NO;
//    }
//    else
//    {
//        return YES;
//    }
    
    
    
//    internetReach = [Reachability reachabilityForInternetConnection] ;
//	[internetReach startNotifer];
//	if([self updateReachabilityStatus:internetReach])
//	{	
//		return YES;
//	}	
//	return NO;
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self 
//                                             selector:@selector(reachabilityChanged:) 
//                                                 name:kReachabilityChangedNotification 
//                                               object:nil];
//    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
//    
//    
//    
//    
//    
//    if (reach.isReachableViaWiFi) 
//    {
//        isNetworkAvailable = YES;
//    }
//    else
//    {
//        isNetworkAvailable = NO; 
//    }
//
//    return isNetworkAvailable;
//    
    
    
    //////////////////////
    Reachability *reachability = [Reachability reachabilityForInternetConnection];  
    NetworkStatus networkStatus = [reachability currentReachabilityStatus]; 
    return !(networkStatus == NotReachable);
}


-(void)callMainViewCreationMethod
{
    if ([mainNavigationViewController.view isDescendantOfView:self.window])
    {
        [mainNavigationViewController.view removeFromSuperview];
    }

    if ([eventsArray count]>1)
    {
        eventsListViewController = [[EventsListViewController alloc] init];
        mainNavigationViewController = [[UINavigationController alloc] initWithRootViewController:eventsListViewController];
        [self.window addSubview:mainNavigationViewController.view];
    }
    else
    {
        
        selectedEvent = 0;
        mainViewController = [[MainViewController alloc] init];
        mainNavigationViewController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
        [self.window addSubview:mainNavigationViewController.view];
        if ([allEventsInfoArray count]>0)
        {
            mainResponseDict = [allEventsInfoArray objectAtIndex:selectedEvent];
        }
 
    }
            

    [self layoutAnimated:YES];

    [self createCommonUI];
    [self tokenIdMethodStoreMethod];
    
    //[self loadCompleteOffLineImages];
    //[self performSelector:@selector(callOrNotDataSynchMethod) withObject:nil afterDelay:60];
    
   

}

-(void)callOrNotDataSynchMethod
{
    NSString *filePath = [self dataFilePathForRunOfflineOnline];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        NSString *tmpStr = [tmpDict objectForKey:@"runAppInOffline"];
        
        
        if ([tmpStr isEqualToString:@"YES"])
        {
                  
        }
        else
        {
            if ([self networkCheckingMethod])
            {
                [self callDataSynchMethodAfterloadingTheApplication];                
            }
            
        }
        
    }
    else
    {
        
        if ([self networkCheckingMethod])
        {
            [self callDataSynchMethodAfterloadingTheApplication];                
        }
        else
        {
           // NSLog(@"no net work ");
        }
        
    }

}


-(void)callWebServices
{
    
    if (mainParser != nil)
    {
    }
    
    mainParser = [[MainParserClass alloc] init];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = CGPointMake(160, 240);
    [activityIndicator startAnimating];
    [self.window addSubview:activityIndicator];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];

    
}

//-(void)createCustomStyleDict
//{
//    tmpStylesDict = [[mainResponseDictionary objectForKey:@"root"] objectForKey:@"client"] ;
//    
//    
//    /*
//
//    NSString *listHeadingFontName = @"";
//    listHeadingFontName = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"listheading"] objectForKey:@"style"];
//        
//    NSString *listHeadingFontSize =@"";
//    listHeadingFontSize = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"listheading"] objectForKey:@"size"];
//    
//    
//    NSMutableDictionary *listHeadingFontColorDict = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"listheading"] objectForKey:@"color"];
//    
//    
//    
//    NSString *listContentFontName =@"";
//    listContentFontName = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"listcontent"] objectForKey:@"style"];
//    
//    NSString *listContentFontSize=@"";
//    listContentFontSize = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"listcontent"] objectForKey:@"size"];
//    
//    NSMutableDictionary *listContentFontColorDict = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"listcontent"] objectForKey:@"color"];
//    
//    
//    NSString *webLinkFontName= @"";
//    webLinkFontName = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"listweblink"] objectForKey:@"style"];
//    
//    NSString *webLinkFontSize= @"";
//    webLinkFontSize = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"listweblink"] objectForKey:@"size"];
//    
//    NSMutableDictionary *webLinkFontColorDict = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"listweblink"] objectForKey:@"color"];
//
//    
//    NSString *titleFontName= @"";
//    titleFontName = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"heading"] objectForKey:@"style"];
//    NSString *titleFontSize = @"";
//    titleFontSize = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"heading"] objectForKey:@"size"];
//    
//    NSMutableDictionary *titleFontColorDict = [[[tmpStylesDict objectForKey:@"stylesheet"] objectForKey:@"heading"] objectForKey:@"color"];
//    
//    
//    NSString *subTitleFontName= @"";
//    subTitleFontName = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"subheading"] objectForKey:@"style"];
//    NSString *subTitleFontSize = @"";
//    
//    subTitleFontSize = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"subheading"] objectForKey:@"size"];
//    
//    NSMutableDictionary *subTitleFontColorDict = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"subheading"] objectForKey:@"color"];
//
//    NSString *iconFontName= @"";
//    iconFontName = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"menuname"] objectForKey:@"style"];
//    
//    NSString *iconFontSize=@"";
//    iconFontSize = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"menuname"] objectForKey:@"size"];
//    
//     NSMutableDictionary *iconFontColorDict = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"menuname"] objectForKey:@"color"];
//
//        
//    
//    NSString *pageHeadingFontName= @"";
//    pageHeadingFontName = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"heading"] objectForKey:@"style"];
//    
//    NSString *pageHeadingFontSize=@"";
//    pageHeadingFontSize = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"heading"] objectForKey:@"size"];
//    
//    NSMutableDictionary *pageHeadingFontColorDict = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"heading"] objectForKey:@"color"];
//    
//    
//    NSString *pageSubHeadingFontName= @"";
//    pageSubHeadingFontName = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"subheading"] objectForKey:@"style"];
//    
//    NSString *pageSubHeadingFontSize=@"";
//    pageSubHeadingFontSize = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"subheading"] objectForKey:@"size"];
//    
//    NSMutableDictionary *pageSubHeadingFontColorDict = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"subheading"] objectForKey:@"color"];
// 
//    
//    NSString *logoImageUrl = [[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"logo"];
//    
//    NSData *logoImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:logoImageUrl]];
//    
//    
//    NSString *bgImageUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//  
//    NSString *tmpStr = [[tmpStylesDict  objectForKey:@"stylesheet"]objectForKey:@"bg"];
//    
//    bgImageUrl = [bgImageUrl stringByAppendingString:tmpStr] ;
//
//    NSData *bgImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:bgImageUrl]];
//
//    NSString *subBgImageUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict  objectForKey:@"stylesheet"]objectForKey:@"subbg"];
//    
//    subBgImageUrl = [subBgImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *subBgImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:subBgImageUrl]];
//    
//    
//    NSString *footerImageUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict  objectForKey:@"stylesheet"]objectForKey:@"footerbg"];
//    
//    footerImageUrl = [footerImageUrl stringByAppendingString:tmpStr] ; 
//    
//    NSData *footerImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:footerImageUrl]];
//    
//    
//    NSString *agendaImageUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict  objectForKey:@"stylesheet"]objectForKey:@"agenda"];
//    
//    agendaImageUrl = [agendaImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *agendaImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:agendaImageUrl]];
//    
//    
//    NSString *speakerImageUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict objectForKey:@"stylesheet"]objectForKey:@"speakers"];
//    
//    speakerImageUrl = [speakerImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *speakersImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:speakerImageUrl]];
//
//    
//    NSString *sponserImageUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict  objectForKey:@"stylesheet"]objectForKey:@"sponsors"];
//    
//    sponserImageUrl = [sponserImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *sponsersImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:sponserImageUrl]];
//    
//    
//    NSString *linksImageUrl = [tmpStylesDict objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict  objectForKey:@"stylesheet"]objectForKey:@"links"];
//    
//    linksImageUrl = [linksImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *linksImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:linksImageUrl]];
//    
//    
//    NSString *newsImageUrl = [tmpStylesDict objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict  objectForKey:@"stylesheet"]objectForKey:@"news"];
//    
//    newsImageUrl = [newsImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *newsImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:newsImageUrl]];
//    
//    NSString *photosImageUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict objectForKey:@"stylesheet"]objectForKey:@"photos"];
//    
//    photosImageUrl = [photosImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *photosImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:photosImageUrl]];
//    
//    NSString *videosImageUrl = [tmpStylesDict objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict  objectForKey:@"stylesheet"]objectForKey:@"videos"];
//    
//    videosImageUrl = [videosImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *videosImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:videosImageUrl]];
//    
//    NSString *socialImageUrl = [tmpStylesDict objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict objectForKey:@"stylesheet"]objectForKey:@"social"];
//    
//    socialImageUrl = [socialImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *socialImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:socialImageUrl]];
//    
//    NSString *nearbyImageUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict  objectForKey:@"stylesheet"]objectForKey:@"nearby"];
//    
//    nearbyImageUrl = [nearbyImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *nearbyImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:nearbyImageUrl]];
//    
//    //////////////////////////
//    
//    NSString *myFavoriteImageUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict  objectForKey:@"stylesheet"]objectForKey:@"myfavorite"];
//    
//    myFavoriteImageUrl = [myFavoriteImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *myFavoriteData =[NSData dataWithContentsOfURL:[NSURL URLWithString:myFavoriteImageUrl]];
//    
//    
//    NSString *aboutImageUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict  objectForKey:@"stylesheet"]objectForKey:@"about"];
//    
//    aboutImageUrl = [aboutImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *aboutImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:aboutImageUrl]];
//    
//    
//    
//    
//    NSString *contactUsImageUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict  objectForKey:@"stylesheet"]objectForKey:@"contact"];
//    
//    contactUsImageUrl = [contactUsImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *contactUsImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:contactUsImageUrl]];
//    
//    
//    NSString *exhibitorsImageUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict  objectForKey:@"stylesheet"]objectForKey:@"exhibitor"];
//    
//    exhibitorsImageUrl = [exhibitorsImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *exhibitorsImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:exhibitorsImageUrl]];
//
//    
//    
//    NSString *partnersImageUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict  objectForKey:@"stylesheet"]objectForKey:@"partner"];
//    
//    partnersImageUrl = [partnersImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *partnersImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:partnersImageUrl]];
//    
//    
//    NSString *eventIntroImageUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict  objectForKey:@"stylesheet"]objectForKey:@"intro"];
//    
//    eventIntroImageUrl = [eventIntroImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *eventIntroImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:eventIntroImageUrl]];
//
//    
//    NSString *registerNowImageUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict  objectForKey:@"stylesheet"]objectForKey:@"register"];
//    
//    registerNowImageUrl = [registerNowImageUrl stringByAppendingString:tmpStr] ;
//
//    NSData *rigisterImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:registerNowImageUrl]];
//    
//    
//    NSString *settingsImageUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict  objectForKey:@"stylesheet"]objectForKey:@"settings"];    
//    settingsImageUrl = [settingsImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *settingsImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:settingsImageUrl]];
//    
//    
//    NSString *funFactsImageUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict  objectForKey:@"stylesheet"]objectForKey:@"funfacts"];    
//    funFactsImageUrl = [funFactsImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *funFactsImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:funFactsImageUrl]];
//    
//
//    NSString *transparentImageUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict  objectForKey:@"stylesheet"]objectForKey:@"transparentbg"];    
//    transparentImageUrl = [transparentImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *transparentImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:transparentImageUrl]];
//    
//    
//    NSString *listHeadingImageUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//    
//    tmpStr = [[tmpStylesDict objectForKey:@"stylesheet"]objectForKey:@"listheadbg"];
//    
//    listHeadingImageUrl = [listHeadingImageUrl stringByAppendingString:tmpStr] ;
//    
//    NSData *listHeadingImageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:listHeadingImageUrl]];
//       
//     NSString *baseUrl = [tmpStylesDict  objectForKey:@"baseurl"];
//    
//    [customStylesDict setObject:baseUrl forKey:@"baseUrl"];
//    
//    [customStylesDict setObject:listHeadingFontName forKey:@"listHeadingFontName"];
//    [customStylesDict setObject:listHeadingFontSize forKey:@"listHeadingFontSize"];
//    [customStylesDict setObject:listHeadingFontColorDict forKey:@"listHeadingFontColor"];
//    
//    [customStylesDict setObject:listContentFontName forKey:@"listContentFontName"];
//    [customStylesDict setObject:listContentFontSize forKey:@"listContentFontSize"];
//    [customStylesDict setObject:listContentFontColorDict forKey:@"listContentFontColor"];
//    
//    [customStylesDict setObject:webLinkFontName forKey:@"webLinkFontName"];
//    [customStylesDict setObject:webLinkFontSize forKey:@"webLinkFontSize"];
//    [customStylesDict setObject:webLinkFontColorDict forKey:@"webLinkFontColor"];
//    
//    [customStylesDict setObject:titleFontName forKey:@"titleFontName"];
//    [customStylesDict setObject:titleFontSize forKey:@"titleFontSize"];
//    [customStylesDict setObject:titleFontColorDict forKey:@"titleFontColor"];
//    
//    [customStylesDict setObject:subTitleFontName forKey:@"subTitleFontName"];
//    [customStylesDict setObject:subTitleFontSize forKey:@"subTitleFontSize"];
//    [customStylesDict setObject:subTitleFontColorDict forKey:@"subTitleFontColorDict"];
//    
//    
//    [customStylesDict setObject:iconFontName forKey:@"iconFontName"];
//    [customStylesDict setObject:iconFontSize forKey:@"iconFontSize"];
//    [customStylesDict setObject:iconFontColorDict forKey:@"iconFontColorDict"];
//    
//    [customStylesDict setObject:pageHeadingFontName forKey:@"pageHeadingFontName"];
//    [customStylesDict setObject:pageHeadingFontSize forKey:@"pageHeadingFontSize"];
//    [customStylesDict setObject:pageHeadingFontColorDict forKey:@"pageHeadingFontColorDict"];
//    
//    [customStylesDict setObject:pageSubHeadingFontName forKey:@"pageSubHeadingFontName"];
//    [customStylesDict setObject:pageSubHeadingFontSize forKey:@"pageSubHeadingFontSize"];
//    [customStylesDict setObject:pageSubHeadingFontColorDict forKey:@"pageSubHeadingFontColorDict"];
//    
//
//    [customStylesDict setObject:logoImageData forKey:@"logoImagedata"];
//    [customStylesDict setObject:bgImageData forKey:@"bgImageData"];
//    [customStylesDict setObject:subBgImageData forKey:@"subBgImageData"];
//    [customStylesDict setObject:footerImageData forKey:@"footerImageData"];
//    [customStylesDict setObject:agendaImageData forKey:@"agendaImageData"];
//    [customStylesDict setObject:speakersImageData forKey:@"speakersImageData"];
//    [customStylesDict setObject:sponsersImageData forKey:@"sponsersImageData"];  
//    [customStylesDict setObject:linksImageData forKey:@"linksImageData"];
//    [customStylesDict setObject:newsImageData forKey:@"newsImageData"];
//    [customStylesDict setObject:photosImageData forKey:@"photosImageData"];
//    [customStylesDict setObject:videosImageData forKey:@"videosImageData"];
//    [customStylesDict setObject:socialImageData forKey:@"socialImageData"];
//    [customStylesDict setObject:nearbyImageData forKey:@"nearbyImageData"];
//    [customStylesDict setObject:myFavoriteData forKey:@"myFavoriteImageData"];
//    [customStylesDict setObject:aboutImageData forKey:@"aboutImageData"];
//    [customStylesDict setObject:contactUsImageData forKey:@"contactUsImageData"];
//    [customStylesDict setObject:exhibitorsImageData forKey:@"exhibitorsImageData"];
//    [customStylesDict setObject:partnersImageData forKey:@"partnersImageData"];
//    [customStylesDict setObject:eventIntroImageData forKey:@"eventIntroImageData"];
//    [customStylesDict setObject:rigisterImageData forKey:@"rigisterImageData"];
//    [customStylesDict setObject:settingsImageData forKey:@"settingsImageData"];
//    [customStylesDict setObject:funFactsImageData forKey:@"funFactsImageData"];
//    [customStylesDict setObject:transparentImageData forKey:@"transparentImageData"];
//
//
//    [customStylesDict setObject:listHeadingImageData forKey:@"listHeadingImageData"];
//    
//    [self callMainViewCreationMethod];
//    
//     
//     */
//    
//    
//    
//    ///////////// 07/09/2012
//    NSString *listHeadingFontName = @"";
//    listHeadingFontName = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"listheading"] objectForKey:@"style"];
//    
//    NSString *listHeadingFontSize =@"";
//    listHeadingFontSize = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"listheading"] objectForKey:@"size"];
//    
//    
//    NSMutableDictionary *listHeadingFontColorDict = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"listheading"] objectForKey:@"color"];
//    
//    
//    
//    NSString *listContentFontName =@"";
//    listContentFontName = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"listcontent"] objectForKey:@"style"];
//    
//    NSString *listContentFontSize=@"";
//    listContentFontSize = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"listcontent"] objectForKey:@"size"];
//    
//    NSMutableDictionary *listContentFontColorDict = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"listcontent"] objectForKey:@"color"];
//    
//    
//    NSString *webLinkFontName= @"";
//    webLinkFontName = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"listweblink"] objectForKey:@"style"];
//    
//    NSString *webLinkFontSize= @"";
//    webLinkFontSize = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"listweblink"] objectForKey:@"size"];
//    
//    NSMutableDictionary *webLinkFontColorDict = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"listweblink"] objectForKey:@"color"];
//    
//    
//    NSString *titleFontName= @"";
//    titleFontName = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"heading"] objectForKey:@"style"];
//    NSString *titleFontSize = @"";
//    titleFontSize = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"heading"] objectForKey:@"size"];
//    
//    NSMutableDictionary *titleFontColorDict = [[[tmpStylesDict objectForKey:@"stylesheet"] objectForKey:@"heading"] objectForKey:@"color"];
//    
//    
//    NSString *subTitleFontName= @"";
//    subTitleFontName = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"subheading"] objectForKey:@"style"];
//    NSString *subTitleFontSize = @"";
//    
//    subTitleFontSize = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"subheading"] objectForKey:@"size"];
//    
//    NSMutableDictionary *subTitleFontColorDict = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"subheading"] objectForKey:@"color"];
//    
//    NSString *iconFontName= @"";
//    iconFontName = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"menuname"] objectForKey:@"style"];
//    
//    NSString *iconFontSize=@"";
//    iconFontSize = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"menuname"] objectForKey:@"size"];
//    
//    NSMutableDictionary *iconFontColorDict = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"menuname"] objectForKey:@"color"];
//    
//    
//    
//    NSString *pageHeadingFontName= @"";
//    pageHeadingFontName = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"heading"] objectForKey:@"style"];
//    
//    NSString *pageHeadingFontSize=@"";
//    pageHeadingFontSize = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"heading"] objectForKey:@"size"];
//    
//    NSMutableDictionary *pageHeadingFontColorDict = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"heading"] objectForKey:@"color"];
//    
//    
//    NSString *pageSubHeadingFontName= @"";
//    pageSubHeadingFontName = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"subheading"] objectForKey:@"style"];
//    
//    NSString *pageSubHeadingFontSize=@"";
//    pageSubHeadingFontSize = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"subheading"] objectForKey:@"size"];
//    
//    NSMutableDictionary *pageSubHeadingFontColorDict = [[[tmpStylesDict  objectForKey:@"stylesheet"] objectForKey:@"subheading"] objectForKey:@"color"];
//    
//    
//}
//


-(void)offLineAppMethod
{
    
    NSString *filePath = [self dataFilePathForEventsInfo];
      
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        
        if ([allEventsInfoArray count]==0)
        {
            [allEventsInfoArray addObjectsFromArray:[tmpDict objectForKey:@"allEventsInfoArray"]]; 
        }
        
        if ([eventsArray count]==0)
        {
            [eventsArray addObjectsFromArray:[tmpDict objectForKey:@"eventsArray"]]; 
        }

        
        runAppInOffline = YES;
        [self callMainViewCreationMethod];
        
       
        
    }
    else
    {
        BOOL network = [self networkCheckingMethod];
        
        if (network == YES)
        {
            [self callWebServices]; 
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Check your network" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
 
        }
    }
     
}

-(void)nodataResponseMethod
{
    if ([allEventsInfoArray count]<=0)
    {
        NSString *filePath = [self dataFilePathForEventsInfo];
        
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        
        if ([tmpDict objectForKey:@"allEventsInfoArray"]!= nil)
        {
            [allEventsInfoArray addObjectsFromArray:[tmpDict objectForKey:@"allEventsInfoArray"]];
        }
        
        
    }

}

-(void)offLimeImagesStoringMethod
{
    NSString *imagesFilePath  = [self dataFilePathForOfflineImages];
    [offLineImagesDict writeToFile:imagesFilePath atomically:YES];
    
}
-(NSString *)offlineImagesFilePath
{
    NSString *imagesFilePath  = [self dataFilePathForOfflineImages];
    return imagesFilePath;
}

-(void)iAddMethods
{
    
//        bannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];
//        [bannerView setDelegate:self];
    
    if (![footerView isDescendantOfView:self.window]) {
        
        NSLog(@" FOOTER VIEW ");
       footerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 376, 320, 42)];
        footerView.image = [UIImage imageNamed:@"footer_add.png"];
        [self.window addSubview:footerView];
    }else{
        
         NSLog(@" FOOTER VIEW  FRAME FRAME FRAME");
        
        footerView.frame = CGRectMake(0, 376, 320, 42);
    }
  
}

#pragma mark - offline iamges loading
-(void)loadCompleteOffLineImages
{
    if (offLineImagesDict != nil)
    {
    }
    else
    {
        offLineImagesDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    
    
    
    BOOL loadImages = NO;
    
    NSString *filePath = [self dataFilePathForRunOfflineOnline];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        NSString *tmpStr = [tmpDict objectForKey:@"runAppInOffline"];
        
        if ([tmpStr isEqualToString:@"YES"])
        {
          loadImages = NO;  
        }
        else
        {
            if ([self networkCheckingMethod])
            {
                loadImages = YES;
                
            }
            else
            {
                loadImages = NO;
            }
            
        }
        
    }
    else
    {
        
        if ([self networkCheckingMethod])
        {
            loadImages = YES;  
        }
        else
        {
            loadImages = NO;  
        }
        
    }
    
    
    if (loadImages == YES)
    {
    
    if (speakersArray != nil)
    {
    }
    else
    {
        speakersArray = [[NSMutableArray alloc] initWithCapacity:0];
        if ([[[[mainResponseDict objectForKey:@"event"] objectForKey:@"speakerslist"] objectForKey:@"speaker"] isKindOfClass:[NSDictionary class]]) 
        {
            [speakersArray addObject:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"speakerslist"] objectForKey:@"speaker"]];
        }
        else
        {
            [speakersArray addObjectsFromArray:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"speakerslist"] objectForKey:@"speaker"]];
        } 
 
    }
    
    if (newsArray != nil)
    {
    }
    else
    {
        newsArray = [[NSMutableArray alloc] initWithCapacity:0];
        if ([[[[mainResponseDict objectForKey:@"event"] objectForKey:@"newslist"] objectForKey:@"news"] isKindOfClass:[NSDictionary class]]) 
        {
            [newsArray addObject:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"newslist"] objectForKey:@"news"]];
        }
        else
        {
            [newsArray addObjectsFromArray:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"newslist"] objectForKey:@"news"]];
        }   
  
    }
    
    if (linksArray != nil)
    {
    }
    else
    {
        linksArray = [[NSMutableArray alloc] initWithCapacity:0];
        if ([[[[mainResponseDict objectForKey:@"event"] objectForKey:@"linkslist"] objectForKey:@"link"] isKindOfClass:[NSDictionary class]]) 
        {
            [linksArray addObject:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"linkslist"] objectForKey:@"link"]];
        }
        else
        {
            [linksArray addObjectsFromArray:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"linkslist"] objectForKey:@"link"]];
        }    
 
    }
    
    if (sponsersArray != nil)
    {
    }
    else
    {
        sponsersArray = [[NSMutableArray alloc] initWithCapacity:0];
        if ([[[[mainResponseDict objectForKey:@"event"] objectForKey:@"sponsorslist"] objectForKey:@"sponsor"] isKindOfClass:[NSDictionary class]]) 
        {
            [sponsersArray addObject:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"sponsorslist"] objectForKey:@"sponsor"]];
        }
        else
        {
            [sponsersArray addObjectsFromArray:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"sponsorslist"] objectForKey:@"sponsor"]];
        } 
 
    }
    
    if (nearbyArray != nil)
    {
    }
    else
    {
        nearbyArray = [[NSMutableArray alloc] initWithCapacity:0];
        if ([[[[mainResponseDict objectForKey:@"event"] objectForKey:@"nearbylist"] objectForKey:@"nearby"] isKindOfClass:[NSDictionary class]]) 
        {
            [nearbyArray addObject:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"nearbylist"] objectForKey:@"nearby"]];
        }
        else
        {
            [nearbyArray addObjectsFromArray:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"nearbylist"] objectForKey:@"nearby"]];
        }   
 
    }
    
    if (socialArray != nil)
    {
    }
    else
    {
        socialArray = [[NSMutableArray alloc] initWithCapacity:0];
        if ([[[[mainResponseDict objectForKey:@"event"] objectForKey:@"sociallist"] objectForKey:@"social"] isKindOfClass:[NSDictionary class]]) 
        {
            [socialArray addObject:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"sociallist"] objectForKey:@"social"]];
        }
        else
        {
            [socialArray addObjectsFromArray:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"sociallist"] objectForKey:@"social"]];
        } 
        
  
    }
    
    if (exhibitorsArray != nil)
    {
    }
    else
    {
        exhibitorsArray = [[NSMutableArray alloc] initWithCapacity:0];
        if ([[[[mainResponseDict objectForKey:@"event"] objectForKey:@"exhibitorslist"] objectForKey:@"exhibitor"] isKindOfClass:[NSDictionary class]]) 
        {
            [exhibitorsArray addObject:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"exhibitorslist"] objectForKey:@"exhibitor"]];
        }
        else
        {
            [exhibitorsArray addObjectsFromArray:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"exhibitorslist"] objectForKey:@"exhibitor"]];
        }  
  
    }
        
    partnersArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    if ([[[[mainResponseDict objectForKey:@"event"] objectForKey:@"partnerslist"] objectForKey:@"partner"] isKindOfClass:[NSDictionary class]]) 
    {
        [partnersArray addObject:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"partnerslist"] objectForKey:@"partner"]];
    }
    else
    {
        [partnersArray addObjectsFromArray:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"partnerslist"] objectForKey:@"partner"]];
    }       
        
    photosArray = [[NSMutableArray alloc] initWithCapacity:0];
    if ([[[[mainResponseDict objectForKey:@"event"] objectForKey:@"photoslist"] objectForKey:@"photo"] isKindOfClass:[NSDictionary class]]) 
    {
        [photosArray addObject:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"photoslist"] objectForKey:@"photo"]];
    }
    else
    {
        [photosArray addObjectsFromArray:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"photoslist"] objectForKey:@"photo"]];
    }        
    
        funFactsArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        if ([[[[mainResponseDict objectForKey:@"event"] objectForKey:@"funfactslist"] objectForKey:@"funfact"]  isKindOfClass:[NSDictionary class]]) 
        {
            [funFactsArray addObject:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"funfactslist"] objectForKey:@"funfact"] ];
        }
        else
        {
            [funFactsArray addObjectsFromArray:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"funfactslist"] objectForKey:@"funfact"]];
        }  
        
        
        
        
    vedioesArray = [[NSMutableArray alloc] initWithCapacity:0];
    if ([[[[mainResponseDict objectForKey:@"event"] objectForKey:@"videoslist"] objectForKey:@"video"] isKindOfClass:[NSDictionary class]]) 
    {
        [vedioesArray addObject:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"videoslist"] objectForKey:@"video"]];
    }
    else
    {
        [vedioesArray addObjectsFromArray:[[[mainResponseDict objectForKey:@"event"] objectForKey:@"videoslist"] objectForKey:@"video"]];
    }   
        


    [self performSelectorInBackground:@selector(offLineExhibitorsImagesStoring) withObject:nil];   

    [self performSelectorInBackground:@selector(offLineSponserImagesStoring) withObject:nil];   
    [self performSelectorInBackground:@selector(offLineSpeakerImagesStoring) withObject:nil];   

    [self performSelectorInBackground:@selector(offLineLinksImagesStoring) withObject:nil];   

    [self performSelectorInBackground:@selector(offLineSocialImagesStoring) withObject:nil];   

    [self performSelectorInBackground:@selector(offLineNewsImagesStoring) withObject:nil];   

    [self performSelectorInBackground:@selector(offLineNearByImagesStoring) withObject:nil];   
        
   [self performSelectorInBackground:@selector(offLinePartnersImagesStoring) withObject:nil];   
   
    [self performSelectorInBackground:@selector(offLinePhotoStoring) withObject:nil];   
       
    [self performSelectorInBackground:@selector(offLineFunFactsImagesStoring) withObject:nil];   

    [self performSelectorInBackground:@selector(offLineVedioesImagesStoring) withObject:nil];   

    }

}

-(void)offLineVedioesImagesStoring
{
    @autoreleasepool {
    NSMutableArray *offlineImagesArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i<[vedioesArray count]; i++)
    {
        NSMutableDictionary *tmpDict = [vedioesArray objectAtIndex:i];
        NSString *baseUrl = BASE_URL;
        if ([tmpDict objectForKey:@"logo"] != nil) 
        {
            NSString *imageUrl = [tmpDict objectForKey:@"logo"];
            baseUrl = [baseUrl stringByAppendingString:imageUrl];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:baseUrl]];
            if (data!= nil) 
            {
                [offlineImagesArr addObject:data];
                
                
            }
            else
            {
                UIImage *img = [UIImage imageNamed:@"NoImage.png"];
                NSData *data = UIImagePNGRepresentation(img);
                [offlineImagesArr addObject:data]; 
                
            }
            
            
        }
        else
        {
            UIImage *img = [UIImage imageNamed:@"NoImage.png"];
            NSData *data = UIImagePNGRepresentation(img);
            [offlineImagesArr addObject:data];
            
            
        }
        
    }
    
    
    NSString *filePath = [self dataFilePathForOfflineImages];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) 
    {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        [tmpDic setObject:offlineImagesArr forKey:@"offlineVediosImagesArray"];
        [tmpDic writeToFile:filePath atomically:YES];
        
    }
    else
    {
        [offLineImagesDict setObject:offlineImagesArr forKey:@"offlineVediosImagesArray"];
        [self offLimeImagesStoringMethod];
        
    }
    
    }
    
}



-(void)offLineSpeakerImagesStoring
{
    @autoreleasepool {
    NSMutableArray *offlineImagesArr = [[NSMutableArray alloc] initWithCapacity:0];

    for (int i = 0; i<[speakersArray count]; i++)
    {
        NSMutableDictionary *tmpDict = [speakersArray objectAtIndex:i];
        NSString *baseUrl = BASE_URL;
        if ([tmpDict objectForKey:@"speakerphoto"] != nil)
        {
            NSString *imageUrl = [tmpDict objectForKey:@"speakerphoto"];
            baseUrl = [baseUrl stringByAppendingString:imageUrl];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:baseUrl]];
            if (data!= nil) 
            {
                [offlineImagesArr addObject:data];

                
            }
            else
            {
                UIImage *img = [UIImage imageNamed:@"NoImage.png"];
                NSData *data = UIImagePNGRepresentation(img);
                [offlineImagesArr addObject:data]; 

            }
            
            
        }
        else
        {
            UIImage *img = [UIImage imageNamed:@"NoImage.png"];
            NSData *data = UIImagePNGRepresentation(img);
            [offlineImagesArr addObject:data];
            
            
        }
        
    }

    
    NSString *filePath = [self dataFilePathForOfflineImages];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) 
    {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        [tmpDic setObject:offlineImagesArr forKey:@"offLinespeakerImagesArr"];
        [tmpDic writeToFile:filePath atomically:YES];
        
    }
    else
    {
        [offLineImagesDict setObject:offlineImagesArr forKey:@"offLinespeakerImagesArr"];
        [self offLimeImagesStoringMethod];
        
    }
    
    }
    

    
}

-(void)offLineSponserImagesStoring
{
@autoreleasepool {
    NSMutableArray *offlineImagesArr = [[NSMutableArray alloc] initWithCapacity:0];

    for (int i = 0; i<[sponsersArray count]; i++)
    {
        NSMutableDictionary *tmpDict = [sponsersArray objectAtIndex:i];
        NSString *baseUrl = BASE_URL;
        if ([tmpDict objectForKey:@"logo"] != nil) 
        {
            NSString *imageUrl = [tmpDict objectForKey:@"logo"];
            baseUrl = [baseUrl stringByAppendingString:imageUrl];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:baseUrl]];
            if (data!= nil) 
            {
                [offlineImagesArr addObject:data];

                
            }
            else
            {
                UIImage *img = [UIImage imageNamed:@"NoImage.png"];
                NSData *data = UIImagePNGRepresentation(img);
                [offlineImagesArr addObject:data]; 

            }
        }
        else
        {
            UIImage *img = [UIImage imageNamed:@"NoImage.png"];
            NSData *data = UIImagePNGRepresentation(img);
            [offlineImagesArr addObject:data];
            
        }
        
    }

    
    NSString *filePath = [self dataFilePathForOfflineImages];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) 
    {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        [tmpDic setObject:offlineImagesArr forKey:@"offlineSponserImagesArr"];
        [tmpDic writeToFile:filePath atomically:YES];
        
    }
    else
    {
        [offLineImagesDict setObject:offlineImagesArr forKey:@"offlineSponserImagesArr"];
        [self offLimeImagesStoringMethod];
        
    }
}
}

-(void)offLineLinksImagesStoring
{
@autoreleasepool {
    NSMutableArray *offlineImagesArr = [[NSMutableArray alloc] initWithCapacity:0];

    for (int i = 0; i<[linksArray count]; i++)
    {
        NSMutableDictionary *tmpDict = [linksArray objectAtIndex:i];
        NSString *baseUrl = BASE_URL;
        if ([tmpDict objectForKey:@"logo"] != nil) 
        {
            NSString *imageUrl = [tmpDict objectForKey:@"logo"];
            baseUrl = [baseUrl stringByAppendingString:imageUrl];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:baseUrl]];
            if (data!= nil) 
            {
                [offlineImagesArr addObject:data];

                
            }
            else
            {
                UIImage *img = [UIImage imageNamed:@"NoImage.png"];
                NSData *data = UIImagePNGRepresentation(img);
                [offlineImagesArr addObject:data]; 

            }
            
            
        }
        else
        {
            UIImage *img = [UIImage imageNamed:@"NoImage.png"];
            NSData *data = UIImagePNGRepresentation(img);
            [offlineImagesArr addObject:data];
            
        }
        
    }

    
    NSString *filePath = [self dataFilePathForOfflineImages];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) 
    {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        [tmpDic setObject:offlineImagesArr forKey:@"offlineLinksImagesArr"];
        [tmpDic writeToFile:filePath atomically:YES];
        
    }
    else
    {
        [offLineImagesDict setObject:offlineImagesArr forKey:@"offlineLinksImagesArr"];
        [self offLimeImagesStoringMethod];
        
    }
}

    
    
}

-(void)offLineNewsImagesStoring
{
@autoreleasepool {
    NSMutableArray *offlineImagesArr = [[NSMutableArray alloc] initWithCapacity:0];

    for (int i = 0; i<[newsArray count]; i++)
    {
        NSMutableDictionary *tmpDict = [newsArray objectAtIndex:i];
        NSString *baseUrl = BASE_URL;
        if ([tmpDict objectForKey:@"logo"] != nil) 
        {
            NSString *imageUrl = [tmpDict objectForKey:@"logo"];
            baseUrl = [baseUrl stringByAppendingString:imageUrl];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:baseUrl]];
            if (data!= nil) 
            {
                [offlineImagesArr addObject:data];

                
            }
            else
            {
                UIImage *img = [UIImage imageNamed:@"NoImage.png"];
                NSData *data = UIImagePNGRepresentation(img);
                [offlineImagesArr addObject:data]; 

            }
            
            
        }
        else
        {
            UIImage *img = [UIImage imageNamed:@"NoImage.png"];
            NSData *data = UIImagePNGRepresentation(img);
            [offlineImagesArr addObject:data];
            
        }
        
    }
    
    NSString *filePath = [self dataFilePathForOfflineImages];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) 
    {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        [tmpDic setObject:offlineImagesArr forKey:@"offlineNewsImagesArr"];
        [tmpDic writeToFile:filePath atomically:YES];
        
    }
    else
    {
        [offLineImagesDict setObject:offlineImagesArr forKey:@"offlineNewsImagesArr"];
        [self offLimeImagesStoringMethod];
        
    }
    
}
    
}


-(void)offLineSocialImagesStoring
{
@autoreleasepool {
    NSMutableArray *offlineImagesArr = [[NSMutableArray alloc] initWithCapacity:0];

    for (int i = 0; i<[socialArray count]; i++)
    {
        NSMutableDictionary *tmpDict = [socialArray objectAtIndex:i];
        NSString *baseUrl =  BASE_URL;
        if ([tmpDict objectForKey:@"logo"] != nil) 
        {
            NSString *imageUrl = [tmpDict objectForKey:@"logo"];
            baseUrl = [baseUrl stringByAppendingString:imageUrl];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:baseUrl]];
            if (data!= nil) 
            {
                [offlineImagesArr addObject:data];

                
            }
            else
            {
                UIImage *img = [UIImage imageNamed:@"NoImage.png"];
                NSData *data = UIImagePNGRepresentation(img);
                [offlineImagesArr addObject:data]; 

            }
            
            
        }
        else
        {
            UIImage *img = [UIImage imageNamed:@"NoImage.png"];
            NSData *data = UIImagePNGRepresentation(img);
            [offlineImagesArr addObject:data];
            
        }
        
    }
    
    NSString *filePath = [self dataFilePathForOfflineImages];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) 
    {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        [tmpDic setObject:offlineImagesArr forKey:@"offLineSocialImagesArry"];
        [tmpDic writeToFile:filePath atomically:YES];
        
    }
    else
    {
        [offLineImagesDict setObject:offlineImagesArr forKey:@"offLineSocialImagesArry"];
        
        [self offLimeImagesStoringMethod];
        
    }

}
    
}

-(void)offLineNearByImagesStoring
{
@autoreleasepool {
    NSMutableArray *offlineImagesArr = [[NSMutableArray alloc] initWithCapacity:0];

    for (int i = 0; i<[nearbyArray count]; i++)
    {
        NSMutableDictionary *tmpDict = [nearbyArray objectAtIndex:i];
        NSString *baseUrl = BASE_URL;
        if ([tmpDict objectForKey:@"logo"] != nil) 
        {
            NSString *imageUrl = [tmpDict objectForKey:@"logo"];
            baseUrl = [baseUrl stringByAppendingString:imageUrl];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:baseUrl]];
            if (data!= nil) 
            {
                [offlineImagesArr addObject:data];
                
            }
            else
            {
                UIImage *img = [UIImage imageNamed:@"NoImage.png"];
                NSData *data = UIImagePNGRepresentation(img);
                [offlineImagesArr addObject:data]; 

            }
            
        }
        else
        {
            UIImage *img = [UIImage imageNamed:@"NoImage.png"];
            NSData *data = UIImagePNGRepresentation(img);
            [offlineImagesArr addObject:data];
            
        }
        
    }


    
    NSString *filePath = [self dataFilePathForOfflineImages];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) 
    {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        [tmpDic setObject:offlineImagesArr forKey:@"offlineNearByImagesArr"];
        [tmpDic writeToFile:filePath atomically:YES];
        
    }
    else
    {
        [offLineImagesDict setObject:offlineImagesArr forKey:@"offlineNearByImagesArr"];
        
        [self offLimeImagesStoringMethod];
        
    }
    
}
    
}

-(void)offLineExhibitorsImagesStoring
{
@autoreleasepool {
    NSMutableArray *offlineImagesArr = [[NSMutableArray alloc] init];

    for (int i = 0; i<[exhibitorsArray count]; i++)
    {
        NSMutableDictionary *tmpDict = [exhibitorsArray objectAtIndex:i];
        NSString *baseUrl =  BASE_URL;
        if ([tmpDict objectForKey:@"logo"] != nil) 
        {
            NSString *imageUrl = [tmpDict objectForKey:@"logo"];
            baseUrl = [baseUrl stringByAppendingString:imageUrl];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:baseUrl]];
            if (data!= nil) 
            {
                [offlineImagesArr addObject:data];

                
            }
            else
            {
                UIImage *img = [UIImage imageNamed:@"NoImage.png"];
                NSData *data = UIImagePNGRepresentation(img);
                [offlineImagesArr addObject:data]; 

            }
            
        }
        else
        {
            UIImage *img = [UIImage imageNamed:@"NoImage.png"];
            NSData *data = UIImagePNGRepresentation(img);
            [offlineImagesArr addObject:data];
            
        }
        
    }
    
    NSString *filePath = [self dataFilePathForOfflineImages];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) 
    {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        [tmpDic setObject:offlineImagesArr forKey:@"offlineExhibitorsImagesArr"];
        [tmpDic writeToFile:filePath atomically:YES];
    }
    else
    {
        [offLineImagesDict setObject:offlineImagesArr forKey:@"offlineExhibitorsImagesArr"];
            
       [self offLimeImagesStoringMethod];
        
    }
    
}
    
}

-(void)offLinePartnersImagesStoring
{
    @autoreleasepool {
    NSMutableArray *offlineImagesArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<[partnersArray count]; i++)
    {
        NSMutableDictionary *tmpDict = [partnersArray objectAtIndex:i];
        NSString *baseUrl = BASE_URL;
        if ([tmpDict objectForKey:@"logo"] != nil) 
        {
            NSString *imageUrl = [tmpDict objectForKey:@"logo"];
            baseUrl = [baseUrl stringByAppendingString:imageUrl];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:baseUrl]];
            if (data!= nil) 
            {
                [offlineImagesArr addObject:data];
                
                
            }
            else
            {
                UIImage *img = [UIImage imageNamed:@"NoImage.png"];
                NSData *data = UIImagePNGRepresentation(img);
                [offlineImagesArr addObject:data]; 
                
            }
            
        }
        else
        {
            UIImage *img = [UIImage imageNamed:@"NoImage.png"];
            NSData *data = UIImagePNGRepresentation(img);
            [offlineImagesArr addObject:data];
            
        }
        
    }
    
    NSString *filePath = [self dataFilePathForOfflineImages];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) 
    {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        [tmpDic setObject:offlineImagesArr forKey:@"offlinePartnersImagesArr"];
        [tmpDic writeToFile:filePath atomically:YES];
    }
    else
    {
        [offLineImagesDict setObject:offlineImagesArr forKey:@"offlinePartnersImagesArr"];
        
        [self offLimeImagesStoringMethod];
        
    }
    
    }
    
}

-(void)offLinePhotoStoring
{
    @autoreleasepool {
    NSMutableArray *offlineImagesArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<[photosArray count]; i++)
    {
        NSMutableDictionary *tmpDict = [photosArray objectAtIndex:i];
        NSString *baseUrl = BASE_URL;
        if ([tmpDict objectForKey:@"logo"] != nil) 
        {
            NSString *imageUrl = [tmpDict objectForKey:@"logo"];
            baseUrl = [baseUrl stringByAppendingString:imageUrl];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:baseUrl]];
            if (data!= nil) 
            {
                [offlineImagesArr addObject:data];
                
                
            }
            else
            {
                UIImage *img = [UIImage imageNamed:@"NoImage.png"];
                data = UIImagePNGRepresentation(img);
                [offlineImagesArr addObject:data]; 
                
            }
            

            
        }
        else
        {
            UIImage *img = [UIImage imageNamed:@"NoImage.png"];
            NSData *data = UIImagePNGRepresentation(img);
            [offlineImagesArr addObject:data];
            
        }
        
    }
    
    NSString *filePath = [self dataFilePathForOfflineImages];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) 
    {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        [tmpDic setObject:offlineImagesArr forKey:@"offlinePhotosImagesArr"];
        [tmpDic writeToFile:filePath atomically:YES];
    }
    else
    {
        [offLineImagesDict setObject:offlineImagesArr forKey:@"offlinePhotosImagesArr"];
        
        [self offLimeImagesStoringMethod];
        
    }
    }
    
    
}


-(void)offLineFunFactsImagesStoring
{
    @autoreleasepool {
    NSMutableArray *offlineImagesArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<[funFactsArray count]; i++)
    {
        NSMutableDictionary *tmpDict = [funFactsArray objectAtIndex:i];
        NSString *baseUrl = BASE_URL;
        if ([tmpDict objectForKey:@"picture"] != nil) 
        {
            NSString *imageUrl = [tmpDict objectForKey:@"picture"];
            baseUrl = [baseUrl stringByAppendingString:imageUrl];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:baseUrl]];
            if (data!= nil) 
            {
                [offlineImagesArr addObject:data];
                
                
            }
            else
            {
                UIImage *img = [UIImage imageNamed:@"NoImage.png"];
                NSData *data = UIImagePNGRepresentation(img);
                [offlineImagesArr addObject:data]; 
                
            }
            
        }
        else
        {
            UIImage *img = [UIImage imageNamed:@"NoImage.png"];
            NSData *data = UIImagePNGRepresentation(img);
            [offlineImagesArr addObject:data];
            
        }
        
    }
    
    NSString *filePath = [self dataFilePathForOfflineImages];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) 
    {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        [tmpDic setObject:offlineImagesArr forKey:@"offlineFunFactsImagesArr"];
        [tmpDic writeToFile:filePath atomically:YES];
    }
    else
    {
        [offLineImagesDict setObject:offlineImagesArr forKey:@"offlineFunFactsImagesArr"];
        
        [self offLimeImagesStoringMethod];
        
    }
    
    }
    
}






///////21/06/2012
-(void)appStartMethod
{
    [self callWebServices];
    
}

-(void)tokenIdMethodStoreMethod
{
  
    NSString *filePath = [self dataFilePathForTokenId];
    if ([[mainResponseDict objectForKey:@"event"] objectForKey:@"tokenid"]!= nil)
    {
        NSString *tokenStr = [[mainResponseDict objectForKey:@"event"] objectForKey:@"tokenid"];
        
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        [tmpDict setObject:tokenStr forKey:@"tokenId"];
        [tmpDict writeToFile:filePath atomically:YES];
    }
    
}
-(void)dataSynchMethod :(NSString *)selectedTime
{
    NSString *timeStr = selectedTime;
    int time = [timeStr intValue]*60;
    //int time = [timeStr intValue];

    
    if (timer != nil)
    {
        [timer invalidate];
        timer = nil;
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(callDataSynchMethod) userInfo:nil repeats:YES];
    
    
}

-(void)callDataSynchMethod
{
    BOOL network = [self networkCheckingMethod];
    
    if (network == YES)
    {
            fromDataSynchMethod = YES;
            mainParser = [[MainParserClass alloc] init];
    }
      
}

-(void)dataSynchRestoreMethod
{
    
}

-(void)callDataSynchMethodAfterloadingTheApplication
{
    NSString *filepathForDataSynch = [self dataFilePathForDataSynchMethod];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepathForDataSynch])
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filepathForDataSynch];
        
        
        NSString *time = [tmpDict objectForKey:@"dataSynchTime"];
        
        [self performSelector:@selector(dataSynchMethod:) withObject:time];
        
        
    }
    else
    {
         NSString *time = @"6";
       [self performSelector:@selector(dataSynchMethod:) withObject:time];  
    }
  
    
}


-(void)pushNotifications
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
}


#pragma mark - This method will called if app got successfull registration(proper provisioning and bundle identifier)
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    //you can get the device token of 32 digits this is not the udid of the device this is diffrent for every application in your device having diffrent device token we need to send this device token to your server y because you will get push notifications based on device tokens only. 
    
    // for example you have two diffrent applications which are having pushnotifications concepts  in your device you will get diffrent device tokens. then only you may know you got the notification for which application(this is for your understanding only).
    
	
    // You can see the device token in NSLOG 
    
    //NSLog(@"My token is: %@", deviceToken);
    
    //to send device token to  server u need to encode the device token
    
    if (deviceToken)
	{
		//NSLog(@"token length is %d", [deviceToken length]);
		
		NSMutableString* encodedToken = [NSMutableString string];
		
		unsigned char* bytes = (unsigned char*)[deviceToken bytes];
		
		for (int i = 0; i < [deviceToken length]; ++i)
		{
			unsigned char ch = bytes[i];
			[encodedToken appendFormat:@"%02X", ch];
		}
        
        mainDeviceToken = [encodedToken copy];
        [mainDeviceToken copy];
        // here  you  got encoded device token
        // NSLog(@"%@",encodedToken);
       // NSLog(@"mainDeviceToken = %@",mainDeviceToken);
        
    } 
    
}

#pragma mark this will called when the registration failed (check provision and bundle identifiers)

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", [error description]);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    for (id key in userInfo) {
        //NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
    }    
    
}


- (void)dealloc
{
}

#pragma mark NetworkHandler
- (BOOL)updateReachabilityStatus:(Reachability *)reachability
{
	if(reachability != internetReach) return NO;
	
	BOOL statusFlag = NO;	
	NetworkStatus networkStatus = [reachability currentReachabilityStatus];
	BOOL connectionRequired = [reachability connectionRequired];
	NSString *status = @"";
	switch (networkStatus) 
    {
		case NotReachable:
        {
			status = @"Internet access not available, please check your internet connection.";
			connectionRequired = NO;			
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection" message:status delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alertView show];
        }
			break;
		case ReachableViaWWAN:
			status = @"Reachable WWAN";
			statusFlag = YES;
			break;
		case ReachableViaWiFi:
			status = @"Reachable  WiFi";
			statusFlag = YES;
			break;
		default:
			status = @"";
			break;
	}	
	if(connectionRequired) {
		status = @"Connection Required";
	}
	return statusFlag;
	
}

-(BOOL)isNetWorkAvailable
{
    /*
	internetReach = [Reachability reachabilityForInternetConnection] ;
	[internetReach startNotifer];
	if([self updateReachabilityStatus:internetReach])
	{	
        NSLog(@"Netework is there" ); 
		return YES;
	}
	 NSLog(@"Netework is not  there" ); 
	return NO;*/
    
    
//    Reachability * reach = [[Reachability alloc] init];
//    
//    if([reach isReachable])
//    {
//       NSLog(@"Netework is there" ); 
//    }
//    else
//    {
//        NSLog(@"Netework is not  there" ); 
//    }
//
//    return YES;
    
//    Reachability * reach = [note object];
//    
//    if([reach isReachable])
//    {
//        NSLog(@"network reachable");
//    }
//    else
//    {
//        NSLog(@"network not reachable");
//    }

    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self 
//                                             selector:@selector(reachabilityChanged:) 
//                                                 name:kReachabilityChangedNotification 
//                                               object:nil];
//    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
//    
//    
//   
//    
//    
//    if (reach.isReachableViaWiFi) 
//    {
//        isNetworkAvailable = YES;
//    }
//    else
//    {
//        isNetworkAvailable = NO; 
//    }
//    
//    //isNetworkAvailable = [self performSelector:@selector(reachabilityChanged:)];
//    
//   
//    return isNetworkAvailable;
    
    
    
    /////////////////////////////////Viswanath
    Reachability *reachability = [Reachability reachabilityForInternetConnection];  
    NetworkStatus networkStatus = [reachability currentReachabilityStatus]; 
    return !(networkStatus == NotReachable);
    
}

//-(void)reachabilityChanged:(NSNotification*)note
//{
//    Reachability * reach = [note object];
//    
//    if([reach isReachable])
//    {
//        NSLog(@"network reachable");
//    }
//    else
//    {
//        NSLog(@"network not reachable");
//    }
//}

-(BOOL)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    //Reachability * reach = [[Reachability alloc] init];
    
    if([reach isReachable])
    {
        //NSLog(@"network reachable");
        isNetworkAvailable = YES;
        return YES;
    }
    else
    {
        //NSLog(@"network not reachable");
        isNetworkAvailable = NO;
        return NO;
    }

}

#pragma mark - BannerView delegate methods

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    //[self layoutAnimated:YES];
//   // if (self.bannerIsVisible)
//   // {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        [UIView commitAnimations];
//       // self.bannerIsVisible = NO;
//    //}
}
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [self layoutAnimated:YES];
}


- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
       return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    
}


- (void)layoutAnimated:(BOOL)animated
{
    
    bannerView.backgroundColor = [UIColor blackColor];
    if (bannerView.bannerLoaded) 
    {
       bannerView.frame = CGRectMake(0, mainNavigationViewController.view.frame.size.height-50, mainNavigationViewController.view.frame.size.width, 50);
    } else {
        bannerView.frame = CGRectMake(0, 800, 320, 50);
    }
   
}

-(void)cacheImage:(NSData*)imageData withKey :(NSString*)urlKey{

    if (imageCache == nil) {
        imageCache = [[NSMutableDictionary alloc]init];
    }
    
    if (cachedImageDir == nil) {
        [self prepareDirectoryForImageCache];
    }
    
    NSString *fileName = [urlKey lastPathComponent];
    NSLog(@" FILE NAME AT URL  %@", fileName);
    
    [[NSFileManager defaultManager] createFileAtPath:[cachedImageDir stringByAppendingPathComponent:fileName] contents:imageData attributes:nil];
 }

-(UIImage*)getImageWithUrl:(NSString*)url{
    
    if (imageCache != nil) {
       id object =  [imageCache objectForKey:[url lastPathComponent]];
        if (object != nil) {
             NSLog(@" NSCACHE HIT  %@ ",[url lastPathComponent]);
            UIImage *image = [UIImage imageWithData:object];
            if (image != nil) {
                 return image;
            }else{
                [imageCache removeObjectForKey:[url lastPathComponent]];
            }
        }

        NSString *file = [cachedImageDir stringByAppendingPathComponent:[url lastPathComponent]];
           
            if ([[NSFileManager defaultManager] fileExistsAtPath:file]) {
             
            NSData *data = [[NSFileManager defaultManager] contentsAtPath:file];
            
            if (data != nil) {
                 NSLog(@" DOCUMENTS HIT FILE NAME %@ ",file);
                    [imageCache setObject:data forKey:[url lastPathComponent]];
                    UIImage *image = [UIImage imageWithData:data];
                    return image;
            }
               
        }
    }
    return nil;
}


-(void)clearCache{
    
    if (imageCache != nil) {
        [imageCache removeAllObjects];
    }
    
}


- (void) prepareDirectoryForImageCache {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *cacheDirPath = [documentsDirectory stringByAppendingPathComponent:@"cachedImages" ];
    cachedImageDir  = cacheDirPath;
    if (![[NSFileManager defaultManager] fileExistsAtPath:cacheDirPath])
    {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:cacheDirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [self clearCache];
}



@end
