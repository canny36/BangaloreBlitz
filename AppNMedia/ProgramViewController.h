//
//  ProgramViewController.h
//  AppNMedia
//
//  Created by Srinivas on 11/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"

@interface ProgramViewController : UIViewController{
    
    IBOutlet UITableView *_tableView;
    NSMutableArray *programs;
    
    NSMutableArray *currentDownloads;
    ImageDownloader *imageDownloader;
}

@end
