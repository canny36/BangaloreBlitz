//
//  PhotosViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
@class AppNMediaAppDelegate;
@class  WebViewController;
@interface PhotosViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
     AppNMediaAppDelegate    *appDelegate;
      WebViewController *webViewController;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    UIScrollView *photosScrollView;
    
    NSMutableArray *photosArray;
    //////////// Styles data
    int backGroundColor;
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    ///////
    NSMutableArray *offLinePhotosImagesArry;
    UITableView *photosTableView;
    IBOutlet UIImageView *transparentImageView;
    

}
-(void)assignStyles;
-(void)homeButtonClicked;
@end
