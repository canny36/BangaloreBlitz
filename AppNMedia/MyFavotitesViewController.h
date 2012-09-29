//
//  MyFavotitesViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 06/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"

@class AppNMediaAppDelegate;
@interface MyFavotitesViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,ImageDownloadDelegate>
{
    AppNMediaAppDelegate    *appDelegate;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    
    UITableView *myFavoritesTableView;
    NSMutableArray *selectedAgendaArr;
    NSMutableArray *selectedSpeakersArr;
    NSMutableArray *selectedIndexArr;

    
    ///////////////
    NSMutableArray *array;
    NSMutableArray *agendaArray;
    NSMutableArray *itemsArray;

    
    NSMutableArray *currentDownloads;
    ImageDownloader *imageDownloader;
}

-(void)assignStyles;
-(void)homeButtonClicked;
-(NSArray *)extractMethod:(NSInteger)value;
@end
