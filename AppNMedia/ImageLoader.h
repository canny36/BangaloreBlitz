//
//  ImageLoader.h
//  AppNMedia
//
//  Created by Srinivas on 11/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppNMediaAppDelegate.h"

@class ImageLoader;

@protocol ImageDownloadDelegate <NSObject>

@required

-(void)onDownloadCompletion:(UIImage*)image : (ImageLoader*)imageLoader;
-(void)onErrorLoadingImage:(ImageLoader*)imageLoader;

@end

@interface ImageLoader : NSOperation<NSURLConnectionDelegate>{
    
    NSString *url;
    NSIndexPath *indexPath;
    CGSize size;
    
    BOOL completed;
    BOOL cancelled;
    id<ImageDownloadDelegate> delegate;
    
    NSMutableData *activeDownload;
    NSURLConnection *imageConnection;
    
    AppNMediaAppDelegate *appdelegate;
}

@property(nonatomic,retain) NSString *url;
@property(nonatomic,retain) NSIndexPath *indexPath;
@property(atomic,assign) CGSize size;
@property(atomic,assign) id<ImageDownloadDelegate> delegate;


- (id)initWithUrl:(NSString*)_url withSize:(CGSize)_size delegate: (id<ImageDownloadDelegate>)idelegate;

@end
