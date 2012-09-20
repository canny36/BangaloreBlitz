//
//  SponsersViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"

@class AppNMediaAppDelegate;
@class  WebViewController;
@interface SponsersViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    AppNMediaAppDelegate    *appDelegate;
    WebViewController *webViewController;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;

    UITableView *sponsersTableView;
    
    NSMutableArray *sponsersArray;
    NSMutableArray *sponsersImagesArray;
    
    //////////// Styles data
    int backGroundColor;
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    //////// offline
    NSMutableArray *offlineSponserImagesArr;
    IBOutlet UIImageView *transparentImageView;
    
    NSMutableArray *sponsorsArray;
   
    NSMutableArray *currentDownloads;
    ImageDownloader *imageDownloader;
    
    
}

-(void)assignStyles;
-(void)homeButtonClicked;

@property(nonatomic,retain)NSMutableArray *sponsorsArray;


@end
