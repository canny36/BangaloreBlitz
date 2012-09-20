//
//  PartnersViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 24/05/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"

@class AppNMediaAppDelegate;
@class  WebViewController;
@interface PartnersViewController : UIViewController <UITableViewDelegate,UITableViewDataSource , ImageDownloadDelegate>
{
    AppNMediaAppDelegate    *appDelegate;
    WebViewController *webViewController;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    
    UITableView *partnersTableView;
    NSMutableArray *partnersArray;
    //////////// Styles data
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    
    NSString *weblinkFontName;
    NSString *weblinkFontSize;
    NSString *weblinkFontColor;
    //////// offline 
    NSMutableArray *offlinePartnerImagesArr;
    IBOutlet UIImageView *transparentImageView;

    
    ImageDownloader *imageDownloader;
    NSMutableArray *currentDownloads;
}
-(void)assignStyles;
-(void)homeButtonClicked;
-(void)makePhoneCall:(int )selctedPartner;
@end
