//
//  ExhibitorsViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 24/05/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mapViews.h"
@class AppNMediaAppDelegate;
@class  WebViewController;
@interface ExhibitorsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    AppNMediaAppDelegate    *appDelegate;
    WebViewController *webViewController;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    
    UITableView *exhibitorsTableView;
    NSMutableArray *exhibitorsArray;
    //////////// Styles data
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    //////// offline 
    NSMutableArray *offlineExhibitorsImagesArr;
    mapViews *openMap;
    IBOutlet UIImageView *transparentImageView;
}
-(void)assignStyles;
-(void)homeButtonClicked;
-(void)makeaMap :(int )selectedAddress;
@end
