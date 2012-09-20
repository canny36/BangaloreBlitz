//
//  ImageDownloader.h
//  AppNMedia
//
//  Created by Srinivas on 11/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppNMediaAppDelegate.h"
#import "ImageLoader.h"

@interface ImageDownloader : NSObject{
    
    NSOperationQueue *operationQueue;
    AppNMediaAppDelegate *appdelegate;
    
}

-(void)addOperation:(ImageLoader*)operation;
+(ImageDownloader*)shareInstance;
-(UIImage*)getImage:(NSString*)url;
-(void)removeOperation:(ImageLoader*)loader;
    
@end
