//
//  ImageLoader.m
//  AppNMedia
//
//  Created by Srinivas on 11/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "ImageLoader.h"
@interface ImageLoader()

-(void)startDownload;

@end

@implementation ImageLoader

@synthesize url,indexPath,size;

- (id)initWithUrl:(NSString*)_url withSize:(CGSize)_size delegate: (id<ImageDownloadDelegate>)idelegate
{
    self = [super init];
    if (self) {
        size = _size;
        url = _url;
        delegate = idelegate;
        appdelegate = (AppNMediaAppDelegate*)[[UIApplication sharedApplication] delegate];
    }
    return self;
}



- (void)main{
    [self startDownload];
}



-(void)startDownload{
    
    if (cancelled) {
        
        return;
    }
    
    NSLog(@"IMAGE DOWNLOADED %@ ",url);
    
   NSData *imgData =  [NSData dataWithContentsOfURL:[NSURL URLWithString:self.url] ];
    [appdelegate cacheImage:imgData withKey:self.url];
    
    
    if (cancelled) {
        return;
    }
    
    UIImage *image = [UIImage imageWithData:imgData];
    if (image != nil) {
        [delegate onDownloadCompletion:image :self];
    }else{
        [delegate onErrorLoadingImage:self];
    }
    
    completed = YES;
      

    
   
    
}

-(void)cancel{
    cancelled = YES;
    [imageConnection cancel];
    imageConnection = nil;
}

-(void)cancelOperation{
    
     cancelled = YES;
}

- (BOOL)isCancelled{
    return cancelled;
}

- (BOOL)isFinished{
    return completed;
}

- (BOOL)isConcurrent{
    return YES;
}

- (BOOL)isReady{
    return YES;
}


@end
