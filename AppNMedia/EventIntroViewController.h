//
//  EventIntroViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 19/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppNMediaAppDelegate;
@interface EventIntroViewController : UIViewController 
{
    AppNMediaAppDelegate    *appDelegate;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    IBOutlet UITextView  *eventIntroTxtView;
    
    //////////// Styles data
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    IBOutlet UIImageView *transparentImageView;
}
-(void)homeButtonClicked;
-(void)assignStyles;
- (NSString *)flattenHTML:(NSString *)html ;
@end
