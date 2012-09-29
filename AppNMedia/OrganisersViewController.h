//
//  OrganisersViewController.h
//  AppNMedia
//
//  Created by apple on 08/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"
#import "CannyViewController.h"

@class AppNMediaAppDelegate;
@interface OrganisersViewController : CannyViewController<UITableViewDataSource,UITableViewDelegate>
{
    AppNMediaAppDelegate *appDelegate;
    
    NSMutableArray *organisersArray;

    UITableView *organisersTableView;
      
  }

;
@end
