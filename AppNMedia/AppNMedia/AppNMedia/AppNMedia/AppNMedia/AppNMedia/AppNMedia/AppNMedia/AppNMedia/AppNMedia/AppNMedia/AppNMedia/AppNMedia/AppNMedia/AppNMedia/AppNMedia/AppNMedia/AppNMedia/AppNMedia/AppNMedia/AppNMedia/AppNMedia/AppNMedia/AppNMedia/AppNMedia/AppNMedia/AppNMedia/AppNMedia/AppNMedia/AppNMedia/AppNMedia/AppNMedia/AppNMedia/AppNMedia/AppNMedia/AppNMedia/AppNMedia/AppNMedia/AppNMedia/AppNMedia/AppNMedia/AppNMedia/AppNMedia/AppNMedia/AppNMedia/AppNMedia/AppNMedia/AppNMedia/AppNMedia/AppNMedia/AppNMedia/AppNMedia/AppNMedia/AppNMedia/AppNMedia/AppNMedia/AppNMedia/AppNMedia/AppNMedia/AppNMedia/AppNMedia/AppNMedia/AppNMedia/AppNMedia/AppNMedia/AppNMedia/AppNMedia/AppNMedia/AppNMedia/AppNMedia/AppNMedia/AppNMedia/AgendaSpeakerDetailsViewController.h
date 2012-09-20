//
//  AgendaSpeakerDetailsViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 29/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppNMediaAppDelegate;
@interface AgendaSpeakerDetailsViewController : UIViewController 
{
    AppNMediaAppDelegate    *appDelegate;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    IBOutlet UIScrollView *detailsScrollView;
    
    NSMutableArray *selectedArray;
    NSMutableArray *offlineSpeakersImagesArr;
    NSMutableArray *speakersArray;
    NSMutableArray *speakerImageViewArray;
    //////////// Styles data
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    IBOutlet UIImageView *transparentImageView;
}
@property(nonatomic,retain)NSMutableArray *selectedArray;
-(void)assignStyles;
-(void)addDetailUi;
-(void)addImageToImageView :(NSMutableDictionary *)tmpDict;
@end
