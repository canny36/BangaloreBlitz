//
//  SpeakersViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "ImageDownloader.h"

@class AppNMediaAppDelegate;
@class SpeakersViewDetailsController;

@interface SpeakersViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate,ImageDownloadDelegate>
{
    AppNMediaAppDelegate    *appDelegate;
    SpeakersViewDetailsController *speakersDetailsViewController;
    
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    
    IBOutlet UISearchBar *participantsSearchBar;
    

    UITableView *speakersTableView;
    UIView      *tableBgView;
    NSMutableArray *speakersArray;
    NSMutableArray *speakersImagesArray;
    NSMutableArray *selectedIndexesArray;

    //////////// Styles data
    int backGroundColor;
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    //////// offline 
    NSMutableArray *offlineSpeakersImagesArr;
    
    /////// myFavorites methods
    NSMutableArray *myFavoriteSpeakers;
    NSMutableArray *myFavIndexesArray;
    NSMutableDictionary *restoreDict;

    ////////// Search functionality
    NSString *searchString;
    NSMutableArray *array;
    NSMutableArray *agendaArray;
    NSMutableArray *itemsArray;
    NSMutableArray *searchArr;
    UITableView *searchTableView;
    IBOutlet UIImageView *transparentImageView;
    
    ImageDownloader *imageDownloader;
    NSMutableArray *currentDownloads;
    
}
@property(nonatomic,retain)NSMutableArray *offlineSpeakersImagesArr;
-(void)assignStyles;
-(void)addOrDeleteFromMyFavorites:(int )selectedIndex checkMark:(BOOL)checkMark fromSearchTable:(BOOL)fromSearchTable;
-(void)homeButtonClicked;
-(void)storeMyfavorites;
-(void)mainSearchMethod;
-(NSArray *)extractMethod:(NSInteger)value;
-(void)createSearchTable;
-(void)myFavoritesAddingFromSearchResultsTableDetailsController:(NSMutableDictionary *)selectedDictionary checkMark:(BOOL)checkMark;
@end
