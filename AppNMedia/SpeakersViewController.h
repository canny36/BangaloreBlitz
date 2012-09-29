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
#import "CannyViewController.h"

@class AppNMediaAppDelegate;
@class SpeakersViewDetailsController;

@interface SpeakersViewController : CannyViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate,ImageDownloadDelegate>
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
    NSMutableArray *myFavoriteSpeakers;
    NSMutableArray *searchArr;
    
    UITableView *searchTableView;

    
}

@property(nonatomic,retain)NSMutableArray *offlineSpeakersImagesArr;

-(void)onBookmarkButtonClick:(UIButton*)sender;
@end
