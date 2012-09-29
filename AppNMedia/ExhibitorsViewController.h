//
//  ExhibitorsViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 24/05/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mapViews.h"
#import "CannyViewController.h"

@class AppNMediaAppDelegate;
@class  WebViewController;
@interface ExhibitorsViewController : CannyViewController <UITableViewDataSource,UITableViewDelegate,ImageDownloadDelegate>
{
  
    AppNMediaAppDelegate    *appDelegate;
    WebViewController *webViewController;

    
    UITableView *exhibitorsTableView;
    NSMutableArray *exhibitorsArray;

    mapViews *openMap;

    
}


@end
