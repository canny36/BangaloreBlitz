//
//  AgendaViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

@class AppNMediaAppDelegate;
@interface AgendaViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate>
{
    AppNMediaAppDelegate  *appDelegate;
    
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    
    IBOutlet UISearchBar *agendaSearchBar;
    
    
    IBOutlet UITableView *agendaTableView;
    NSMutableDictionary *selectedAgendaLocation;
    
    NSMutableArray *itemsArray;
    //////////// Styles data
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    /////// myFavorites indexes
    NSMutableArray *myFavIndexesArray;
    NSMutableArray *myFavAgendaArray;
    
    
    int fromWhichSection;
    int fromWhichRow;
    NSString *dateString;
    
    ////////// Search functionality
    NSString *searchString;
    UITableView *searchTableView;
    NSMutableArray *searchArr;
    IBOutlet UIImageView *transparentImageView;
    
    NSMutableArray *cellItems;

}
@property(nonatomic,retain)NSMutableDictionary *selectedAgendaLocation;
@property(nonatomic,retain)NSMutableDictionary *sampleArray;
@property(nonatomic,retain)NSString *dateString;
@property int fromWhichSection;
@property int fromWhichRow;
-(void)assignStyles;
-(void)homeButtonClicked;
-(void)addOrDeleteFromMyFavorites:(int )selectedIndex checkMark:(BOOL)checkMark;
-(void)mainSearchMethod;
-(void)createSearchTable;
@end
