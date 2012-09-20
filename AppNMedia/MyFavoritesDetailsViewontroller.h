//
//  MyFavoritesDetailsViewontroller.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 08/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mapViews.h"
@class AppNMediaAppDelegate;
@class WebViewController;
@interface MyFavoritesDetailsViewontroller : UIViewController<UIScrollViewDelegate>
{
    AppNMediaAppDelegate    *appDelegate;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    
    BOOL agendaSelected;
    NSMutableDictionary *selectedDict;
    NSMutableArray *imagesArray;
    int selectedIndex;
   
    //////////// Styles data
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    
    //////////////// UI
    IBOutlet UIScrollView *speakersScrollView;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *descriptionLabel;
    IBOutlet UITextView *nameTxtView;
    IBOutlet UITextView *titleTxtView;
    IBOutlet UITextView *descriptionTxtView;
    IBOutlet UIImageView *speakerImageView;
    
    IBOutlet UILabel *cityLabel;
    IBOutlet UILabel *cityDataLabel;
    IBOutlet UILabel *countryLabel;
    IBOutlet UILabel *countryDataLabel;
    IBOutlet UILabel *titleDataLabel;
    IBOutlet UIImageView *transparentImageView;
    
    
    
    IBOutlet UIScrollView *agendaScrollView;
    IBOutlet UILabel *agendaSpeakerLabel;
    IBOutlet UILabel *agendaTitleLabel;
    IBOutlet UILabel *agendaDescriptionLabel;
    IBOutlet UILabel *agendaTypeLabel;
    IBOutlet UILabel *agendaAddressLabel;
    IBOutlet UILabel *agendaSpeakerDataLabel;
    IBOutlet UILabel *agendaTypeDataLabel;
    IBOutlet UITextView *AgendaDescriptionDataTxtView;
    IBOutlet UITextView *AgendaAddressDataTxtView;
    IBOutlet UITextView *AgendTitleDataTxtView;
    mapViews *openMap;
    WebViewController *webView;

}
@property  BOOL agendaSelected;
@property int selectedIndex;
@property(nonatomic,retain) NSMutableDictionary *selectedDict;
-(void)assignStyles;
-(void)assignData;
-(void)loadSpeakerImage;
-(void)homeButtonClicked;
-(IBAction)viewProfileButtonClicked:(id)sender;
@end
