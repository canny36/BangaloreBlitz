//
//  MyFavotitesViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 06/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppNMediaAppDelegate;
@interface MyFavotitesViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    AppNMediaAppDelegate    *appDelegate;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    
    UITableView *myFavoritesTableView;
    NSMutableArray *selectedAgendaArr;
    NSMutableArray *selectedSpeakersArr;
    NSMutableArray *selectedIndexArr;
    
    //////////// Styles data
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    
    ///////////////
    NSMutableArray *array;
    NSMutableArray *agendaArray;
    NSMutableArray *itemsArray;
    IBOutlet UIImageView *transparentImageView;

}
-(void)assignStyles;
-(void)homeButtonClicked;
-(NSArray *)extractMethod:(NSInteger)value;
@end
