//
//  LinksViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CannyViewController.h"

@class AppNMediaAppDelegate;
@class  WebViewController;

@interface LinksViewController : CannyViewController <UITableViewDelegate,UITableViewDataSource >
{
     AppNMediaAppDelegate    *appDelegate;
     WebViewController *webViewController;

    UITableView *linksTableView;
    NSMutableArray *linksArray;
    
    NSString *weblinkFontName;
    NSString *weblinkFontSize;
    NSString *weblinkFontColor;

}

@end
