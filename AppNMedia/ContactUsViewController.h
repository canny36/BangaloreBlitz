//
//  ContactUsViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 08/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <MessageUI/MessageUI.h>
#import "mapViews.h"
@class AppNMediaAppDelegate;
@class WebViewController;;
@interface ContactUsViewController : UIViewController <MFMailComposeViewControllerDelegate,UITextViewDelegate>
{
    AppNMediaAppDelegate    *appDelegate;
    WebViewController *webViewController;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    
    IBOutlet UILabel *clientNameLabel;
    IBOutlet UILabel *emailidLabel;
    IBOutlet UILabel *phoneNoLabel;
    IBOutlet UILabel *addressLabel;
    IBOutlet UILabel *urlLabel;
    

    IBOutlet UITextView *emailidDataTextView;
    IBOutlet UILabel *phoneNoDataLabel;
    IBOutlet UITextView *addressTextView;
    IBOutlet UITextView *urlTxtView;
    
    
    IBOutlet UIButton *phoneButton;
    IBOutlet UIButton *emailButton;
    
    NSMutableArray *contactUsArray;
    
    //////////// Styles data
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    mapViews *openMap;
    IBOutlet UIImageView *transparentImageView;
    
    
    IBOutlet UIScrollView *scrollView;
}
-(void)assignStyles;
-(void)homeButtonClicked;
-(void)callMailCraetionMethod;
-(IBAction)buttonClicked:(UIButton *)sender;
-(void)makeaMap;
@end
