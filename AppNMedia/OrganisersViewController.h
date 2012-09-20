//
//  OrganisersViewController.h
//  AppNMedia
//
//  Created by apple on 08/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"
@class AppNMediaAppDelegate;
@interface OrganisersViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    AppNMediaAppDelegate *appDelegate;
    
    NSMutableArray *organisersArray;
    IBOutlet UIImageView *transparentImageView;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    UITableView *organisersTableView;
    //////////// Styles data
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    ImageDownloader *imageDownloader;
       NSMutableArray *currentDownloads;
    
        
  }
-(void)assignStyles;
-(void)homeButtonClicked
;
@end
