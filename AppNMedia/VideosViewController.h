//
//  VideosViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppNMediaAppDelegate;
@class  WebViewController;
@interface VideosViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
     AppNMediaAppDelegate    *appDelegate;
     WebViewController *webViewController;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;

     UITableView *videosTableView;
    NSMutableArray *videosArray;
    
    //////////// Styles data
    int backGroundColor;
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    IBOutlet UIImageView *transparentImageView;
    NSMutableArray *offlineVediosImagesArray;

}
-(void)assignStyles;
-(void)loadVediosToWebview:(UIWebView *)vedioWebView url:(NSURL *)vedioUrl;
-(void)homeButtonClicked;
@end
