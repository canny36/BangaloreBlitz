//
//  NearbyViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppNMediaAppDelegate;
@interface NearbyViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
     AppNMediaAppDelegate    *appDelegate;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    
    UITableView *nearbyTableView;
    NSMutableArray *nearbyArray;
    NSMutableArray *nearByTypesArray;
    
    //////////// Styles data
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
       
    /////// Nearby types table view
    UITableView *nearByTypesTableView;
    NSMutableArray *nearBySourceArray;
    NSString *selectedType;
    IBOutlet UIImageView *transparentImageView;
}
-(void)assignStyles;
-(void)homeButtonClicked;
-(NSMutableArray *)mainNearByTableCreation;

@end
