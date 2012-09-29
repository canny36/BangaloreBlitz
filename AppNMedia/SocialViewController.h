//
//  SocialViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CannyViewController.h"


@class AppNMediaAppDelegate;
@class  WebViewController;

@interface SocialViewController : CannyViewController<UITableViewDataSource,UITableViewDelegate>
{
    AppNMediaAppDelegate    *appDelegate;
     WebViewController *webViewController;

    UITableView *socialTableView;
    
    NSMutableArray *socialArray;
}

@end
