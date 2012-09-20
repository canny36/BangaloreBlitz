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

@class AppNMediaAppDelegate;
@interface SupportedViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, ImageDownloadDelegate>
{
    
    AppNMediaAppDelegate *appDelegate;
    NSMutableArray       *supportedByArray;
    UITableView *supportedByTableView;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    ImageDownloader *imageDownloader;
    NSMutableArray *currentDownloads;
    
}


-(void)homeButtonClicked;
@end
