//
//  AgendaViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "AgendaLoc.h"
#import "CannyViewController.h"

@class AppNMediaAppDelegate;
@interface AgendaViewController : CannyViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate>
{
    AppNMediaAppDelegate  *appDelegate;

    
    IBOutlet UISearchBar *agendaSearchBar;
    
    
    IBOutlet UITableView *agendaTableView;

    NSMutableArray *myFavAgendaArray;
    NSString *_dateString;
    NSString *searchString;
    UITableView *searchTableView;
    NSMutableArray *searchArr;
    AgendaLoc *_loc;

}


@property(nonatomic,retain) NSString *dateString;
@property(nonatomic,retain) AgendaLoc *loc;


@end
