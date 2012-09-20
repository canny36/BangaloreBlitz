//
//  NearByDetailViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 04/07/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mapViews.h"
#import "ImageDownloader.h"

@class AppNMediaAppDelegate;
@class WebViewController;
@interface NearByDetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate , ImageDownloadDelegate>
{
    AppNMediaAppDelegate    *appDelegate;
    WebViewController *webViewController;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    
    UITableView *nearbyTableView;
    NSMutableArray *selectedArray;
    NSString *selectedType;
    
    mapViews *openMap;
    
    //////////// Styles data
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    //////// offline 
    NSMutableArray *offlineNearByImagesArr;
    NSMutableArray *nearbyArray;
    IBOutlet UIImageView *transparentImageView;
    
    NSMutableArray *currentDownloads;
    ImageDownloader *imageDownloader;
    
}

@property(nonatomic,retain) NSMutableArray *selectedArray;
@property(nonatomic,retain)NSString *selectedType;
-(void)assignStyles;
-(void)homeButtonClicked;
-(void)makePhoneCall:(int )selctedLocation;
-(void)makeaMap :(int )selectedAddress;
-(void)photosViewClicked:(int )selected;
@end
