//
//  CannyViewController.h
//  BangaloreItBiz
//
//  Created by Srinivas on 29/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"
#import "CustomTableViewCell.h"

@interface CannyViewController : UIViewController<ImageDownloadDelegate>{
    ImageDownloader *imageDownloader;
    NSMutableArray *currentDownloads;
}

-(void)onFavoriteSelection:(UIButton*)sender;
-(void)updateCell:(ImageLoader*)loader;
-(void)loadImageAtIndexpath:(NSIndexPath*)indexpath urlString :(NSString*)url cell :(CustomTableViewCell*)cell;

@end
