//
//  SponsorCategoryController.h
//  AppNMedia
//
//  Created by Srinivas on 13/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SponsorCategoryController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    IBOutlet UITableView *tableView;
    NSArray *array;
    NSMutableDictionary *sponsorDict;
}




@end
