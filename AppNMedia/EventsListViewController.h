//
//  EventsListViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

@class AppNMediaAppDelegate;
@class EventsParserClass;
@class MainViewController;
@interface EventsListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    AppNMediaAppDelegate    *appDelegate;
    EventsParserClass *eventParserClass;
    MainViewController *mainViewController;
    
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    UITableView *eventsTableView;
    
    
    NSMutableArray *agendaArray;
    //////////// Styles data
    int backGroundColor;
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;

    
    
}
-(void)assignStyles;
@end
