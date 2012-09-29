//
//  SponsersViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"
#import "CannyViewController.h"

@class AppNMediaAppDelegate;
@class  WebViewController;
@interface SponsersViewController :CannyViewController <UITableViewDataSource,UITableViewDelegate>
{
    AppNMediaAppDelegate    *appDelegate;
    WebViewController *webViewController;

    UITableView *sponsersTableView;
    
    NSMutableArray *sponsersArray;
    NSMutableArray *sponsersImagesArray;
    NSMutableArray *sponsorsArray;
    
    NSString *categoryName;
}

@property(nonatomic,retain)NSMutableArray *sponsorsArray;
@property(nonatomic,retain) NSString *categoryName;

@end
