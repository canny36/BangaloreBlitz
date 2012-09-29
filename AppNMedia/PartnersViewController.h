//
//  PartnersViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 24/05/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"
#import "CannyViewController.h"

@class AppNMediaAppDelegate;
@class  WebViewController;
@interface PartnersViewController :CannyViewController <UITableViewDelegate,UITableViewDataSource>
{
    AppNMediaAppDelegate    *appDelegate;
    WebViewController *webViewController;
    
    UITableView *partnersTableView;
    NSMutableArray *partnersArray;

}

@end
