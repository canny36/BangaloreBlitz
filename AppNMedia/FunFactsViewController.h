//
//  FunFactsViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 04/07/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppNMediaAppDelegate;
@class WebViewController;
@interface FunFactsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    AppNMediaAppDelegate    *appDelegate;
    WebViewController *webViewController;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    UITableView *funFactsTableView;
    NSMutableArray *funFactsArray;
    //////////// Styles data
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    
    NSMutableArray *offLineFunFactsImagesArray;
    IBOutlet UIImageView *transparentImageView;
    
    
}
-(void)homeButtonClicked;
-(void)assignStyles;
-(void)makeaMap :(int )selectedAddress;
-(void)openWeb:(int)intSelected;
@end
