//
//  NearByDetailViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 04/07/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mapViews.h"
#import "CannyViewController.h"

@class AppNMediaAppDelegate;
@class WebViewController;
@interface NearByDetailViewController : CannyViewController <UITableViewDataSource,UITableViewDelegate , ImageDownloadDelegate>
{
    AppNMediaAppDelegate    *appDelegate;
    WebViewController *webViewController;
    
    UITableView *nearbyTableView;
    NSMutableArray *selectedArray;
    NSString *selectedType;
    
    mapViews *openMap;

    NSMutableArray *nearbyArray;

    
}

@property(nonatomic,retain) NSMutableArray *selectedArray;
@property(nonatomic,retain)NSString *selectedType;

@end
