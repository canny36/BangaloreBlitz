//
//  AgendaDetailsViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 10/05/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mapViews.h"

@class AppNMediaAppDelegate;
@class AgendaSpeakerDetailsViewController;
@interface AgendaDetailsViewController : UIViewController <UITextViewDelegate>
{
    AppNMediaAppDelegate    *appDelegate;
    AgendaSpeakerDetailsViewController *asdvController;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    
    NSMutableDictionary *selectedDict;
    NSMutableArray      *speakersDetailsArray;
   
    IBOutlet UITextView *timeTxtView;
    IBOutlet UITextView *titleTxtView;
    IBOutlet UILabel    *levelLabel;
    IBOutlet UILabel    *levelDataLabel;
    IBOutlet UILabel    *byLabel;
    IBOutlet UITextView *byTxtView;
    IBOutlet UILabel    *instructorLabel;
    IBOutlet UITextView *addressTxtView;
    IBOutlet UILabel    *roomLabel;
    IBOutlet UITextView *roomTxtView;
    IBOutlet UILabel    *descriptionLabel;
    IBOutlet UITextView *descriptionTextView;
    
        
    
    IBOutlet UIScrollView *scrollView;
  
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
@property(nonatomic,retain)NSMutableDictionary *selectedDict;
-(void)assignStyles;
-(void)createLabelsWithStyles;
-(void)homeButtonClicked;
-(void)agendaSpeakerDetails;
-(void)makeaMap;
@end
