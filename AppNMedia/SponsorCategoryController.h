//
//  SponsorCategoryController.h
//  AppNMedia
//
//  Created by Srinivas on 13/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CannyViewController.h"

@interface SponsorCategoryController : CannyViewController<UITableViewDelegate,UITableViewDataSource>{
    
    IBOutlet UITableView *_tableView;
    NSArray *array;
    NSMutableDictionary *sponsorDict;
}




@end
