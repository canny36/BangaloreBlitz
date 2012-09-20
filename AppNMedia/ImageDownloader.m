//
//  ImageDownloader.m
//  AppNMedia
//
//  Created by Srinivas on 11/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "ImageDownloader.h"
#import "ImageLoader.h"
#define MAXCONCURRENTCOUNT 5


@implementation ImageDownloader
static ImageDownloader *instance;

+(ImageDownloader*)shareInstance{
    if (instance == nil) {
       instance = [[ImageDownloader alloc]init];
       
    }
    return instance;
}

static NSMutableDictionary *imageOperationDict;

- (id)init
{
    self = [super init];
    if (self) {
        appdelegate =  (AppNMediaAppDelegate*)[[UIApplication sharedApplication] delegate];
        operationQueue = [[NSOperationQueue alloc]init];
        [operationQueue setMaxConcurrentOperationCount:MAXCONCURRENTCOUNT];
    
    }
    return self;
}


-(void)addOperation:(ImageLoader*)operation{
   
    if (imageOperationDict == nil) {
        imageOperationDict = [[NSMutableDictionary alloc]init];
    }
    
    if ([imageOperationDict objectForKey:operation.url] == nil) {
        [imageOperationDict setValue:operation forKey:operation.url];
        [operationQueue addOperation:operation];
    }
    
    NSLog(@"OPERATION COUNT %d ",operationQueue.operationCount);
 
}

-(UIImage*)getImage:(NSString*)url{
    
   UIImage *image = [appdelegate getImageWithUrl:url];
    
    if (image != nil) {
        return image;
    }

    return nil;
}

-(void)removeOperation:(ImageLoader*)loader{
    if (imageOperationDict != nil) {
        [imageOperationDict removeObjectForKey:loader.url];
    }
}

@end
