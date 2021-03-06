//
//  SupportedViewController.h
//  AppNMedia
//
//  Created by Srinivas on 11/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"
#import "ImageLoader.h"
#import "CannyViewController.h"

@class AppNMediaAppDelegate;
@interface SupportedViewController : CannyViewController<UITableViewDataSource,UITableViewDelegate, ImageDownloadDelegate>
{
    
    AppNMediaAppDelegate *appDelegate;
    NSMutableArray       *supportedByArray;
    UITableView *supportedByTableView;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;

    
}


-(void)homeButtonClicked;
@end
