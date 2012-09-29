//
//  PhotosViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "CannyViewController.h"

@class AppNMediaAppDelegate;
@class  WebViewController;

@interface PhotosViewController : CannyViewController <UITableViewDataSource,UITableViewDelegate>
{
     AppNMediaAppDelegate    *appDelegate;
      WebViewController *webViewController;

    UIScrollView *photosScrollView;
    
    NSMutableArray *photosArray;
    NSMutableArray *videosArray;

    UITableView *photosTableView;


}

@end
