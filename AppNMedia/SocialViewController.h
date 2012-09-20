//
//  SocialViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppNMediaAppDelegate;
@class  WebViewController;
@interface SocialViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    AppNMediaAppDelegate    *appDelegate;
     WebViewController *webViewController;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    UITableView *socialTableView;
    
    NSMutableArray *socialArray;
    
    //////////// Styles data
    int backGroundColor;
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;

    NSString *weblinkFontName;
    NSString *weblinkFontSize;
    
    //////// offline 
    NSMutableArray *offlineSocialImagesArr;
    IBOutlet UIImageView *transparentImageView;
}
-(void)assignStyles;
-(void)homeButtonClicked;
@end
