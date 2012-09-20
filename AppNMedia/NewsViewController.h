//
//  NewsViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"

@class AppNMediaAppDelegate;
@class  WebViewController;
@interface NewsViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
     AppNMediaAppDelegate    *appDelegate;
     WebViewController *webViewController;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;

    UITableView *newsTableView;
    NSMutableArray *newsArray;
    
    //////////// Styles data
    int backGroundColor;
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    
    ///////
    NSMutableArray *offLineNewsImagesArry;
    IBOutlet UIImageView *transparentImageView;
    
    ImageDownloader *imageDownloader;
    NSMutableArray *currentDownloads;

}

-(void)assignStyles;
-(void)homeButtonClicked;

@end
