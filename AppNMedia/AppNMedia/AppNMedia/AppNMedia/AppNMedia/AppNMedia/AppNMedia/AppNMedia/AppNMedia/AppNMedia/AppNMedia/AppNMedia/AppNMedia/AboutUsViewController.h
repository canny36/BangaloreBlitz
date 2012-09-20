//
//  AboutUsViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 08/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mapViews.h"
@class AppNMediaAppDelegate;
@interface AboutUsViewController : UIViewController
{
    AppNMediaAppDelegate    *appDelegate;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    IBOutlet UILabel     *seeSettingsLabel;
    
    IBOutlet UILabel *aboutUslabel;
    IBOutlet UITextView *aboutUsTextView;
    IBOutlet UILabel *lastUpDatedLabel;
    IBOutlet UITextView *lastUpDatedtextView;
    IBOutlet UILabel *appCurrentModeLabel;
    IBOutlet UILabel *appCurrentModeDataLabel;
    
    
    IBOutlet UITextView *eventName;
    IBOutlet UITextView *locationTextView;
    IBOutlet UITextView *addressTextView;
    IBOutlet UIScrollView *infoScrollView;
    
    //////////// Styles data
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    mapViews *openMap;
    IBOutlet UIImageView *transparentImageView;
}
-(void)assignStyles;
-(void)homeButtonClicked;
-(void)makeaMap;
@end
