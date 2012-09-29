//
//  SubAgendaViewController.h
//  AppNMedia
//
//  Created by Srinivas on 27/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CannyViewController.h"

@interface SubAgendaViewController : CannyViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    
    NSMutableArray *_subAgendaArray;
    NSMutableArray *_searchArray;
   IBOutlet UITableView *_tableView;
    
    NSMutableArray *_myFavAgendaArray;
    
    IBOutlet UISearchBar *_searchBar;
    
}

@property(nonatomic,retain) NSMutableArray *subAgendaArray;
-(void)onBookmarkButtonClick:(UIButton*)sender;
@end
