//
//  VideosTableCell.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

@interface VideosTableCell : UITableViewCell 
{
    UIView *bgView;
    UITextView *titleTxtView;
    UILabel *subTitleLabel;
    UIWebView *webView;
    NSURL *vedioUrl;
    UIImageView *vedioImageView;
    UIActivityIndicatorView *activityIndicator;
}
@property(nonatomic,retain)UITextView *titleTxtView;;
@property(nonatomic,retain)UILabel *subTitleLabel;
@property(nonatomic,retain)UIWebView *webView;
@property(nonatomic,retain)NSURL *vedioUrl;
@property(nonatomic,retain)UIImageView *vedioImageView;
@property(nonatomic,retain)UIActivityIndicatorView *activityIndicator;
-(void)loadWebView:(NSURL *)vedioUrl;
-(void)loadWebViewOnBackGround;
-(void)assignImage:(NSString *)path;
@end
