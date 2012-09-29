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
    NSMutableArray *agendaArray;
    UITableView *agendaTableView;
}


-(void)homeButtonClicked;
-(NSArray *)extractMethod:(NSInteger)value;
-(void)mainSearchMethod;
-(void)createSearchTable;

@end
