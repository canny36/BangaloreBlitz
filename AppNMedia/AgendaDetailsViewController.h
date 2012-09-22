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
   
      
    IBOutlet UIScrollView *scrollView;
  
    //////////// Styles data
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    
    mapViews *openMap;
   


}
@property(nonatomic,retain)NSMutableDictionary *selectedDict;
//-(void)assignStyles;
//-(void)createLabelsWithStyles;
//-(void)homeButtonClicked;
//-(void)agendaSpeakerDetails;
//-(void)makeaMap;
@end
