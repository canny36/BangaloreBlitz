//
//  SpeakersViewDetailsController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "ImageDownloader.h"

@class AppNMediaAppDelegate;
@class SpeakersViewController;
@class  WebViewController;

@interface SpeakersViewDetailsController : UIViewController<ImageDownloadDelegate>
{
     AppNMediaAppDelegate    *appDelegate;
     SpeakersViewController   *svc;
     WebViewController *webView;
    
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView  *subBgView;
    IBOutlet UIImageView *speakerImageView;
    IBOutlet UITextView  *speakerDescriptionTxtView;
    IBOutlet UITextView  *speakerDeatilsTxtView;
    IBOutlet UIScrollView *speakerScrollView;
       
    IBOutlet UILabel *byLabel;
    IBOutlet UILabel *byDataLabel;
    
    IBOutlet UILabel *countryLabel;
    IBOutlet UILabel *countryDataLabel;
    
    IBOutlet UILabel *typeLabel;
    IBOutlet UILabel *typeDataLabel;
    IBOutlet UILabel *descriptionLabel;

    NSString *nameStr;
    NSMutableDictionary *selectedDict;
    int selectedRow;
    //////////// Styles data
    int backGroundColor;
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    
    IBOutlet UIButton *favoritesButton;
    BOOL         buttonSelected;
    BOOL         addedToMyfavorites;
    BOOL         fromSearchTable;
    IBOutlet UIImageView *transparentImageView;
    
}
@property(nonatomic,retain)NSMutableDictionary *selectedDict;
@property int selectedRow;
@property BOOL addedToMyfavorites;
@property BOOL fromSearchTable;
@property(nonatomic,retain)SpeakersViewController   *svc;
-(IBAction)viewProfileButtonClicked:(id)sender;
-(IBAction)favoritesButtonClicked:(id)sender;
-(void)assignStyles;
-(void)loadSpeakerImage;
-(void)homeButtonClicked;
@end
