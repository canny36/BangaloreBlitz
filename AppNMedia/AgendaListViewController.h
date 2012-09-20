//
//  AgendaListViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 22/05/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
@class AppNMediaAppDelegate;
@class AgendaViewController;
@interface AgendaListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UISearchBarDelegate>
{
    AppNMediaAppDelegate  *appDelegate;
    AgendaViewController *agendaViewController;
    
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    
    NSMutableArray *agendaArray;
    UITableView *agendaTableView;
    NSMutableArray *array;
    //////////// Styles data
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    
    ////////// Search functionality
    NSString *searchString;
    UITableView *searchTableView;
    NSMutableArray *searchArr;
    NSMutableArray *itemsArray;
    IBOutlet UISearchBar *agendaSearchBar;
    IBOutlet UIImageView *transparentImageView;
    
    NSMutableArray *cellItems;
    
}

-(void)assignStyles;
-(void)homeButtonClicked;
-(NSArray *)extractMethod:(NSInteger)value;
-(void)mainSearchMethod;
-(void)createSearchTable;

@end
