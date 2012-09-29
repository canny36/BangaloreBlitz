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
#import "SpeakerInfo.h"

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

    IBOutlet UIScrollView *speakerScrollView;

    IBOutlet UILabel *speakerName;
   
    IBOutlet UILabel *speakerDesignation;
    IBOutlet UILabel *descriptionLabel;

    IBOutlet UIButton *profileButton;
    
    NSString *nameStr;


    //////////// Styles data
    int backGroundColor;
    
    IBOutlet UIButton *favoritesButton;
      
    SpeakerInfo *speakerInfo;

    
}


@property(nonatomic,retain) SpeakerInfo *speakerInfo;

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
