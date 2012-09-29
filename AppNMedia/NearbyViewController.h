//
//  NearbyViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CannyViewController.h"

@class AppNMediaAppDelegate;
@interface NearbyViewController : CannyViewController <UITableViewDelegate,UITableViewDataSource>
{
     AppNMediaAppDelegate    *appDelegate;

    
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
