//
//  DownloadUtil.m
//  AppNMedia
//
//  Created by Srinivas on 22/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "DownloadUtil.h"
#import "BBEventParser.h"

@implementation DownloadUtil

static DownloadUtil *downloadUtil;
//static NSOperationQueue *downloadQueue;

-(id)init{
   self=  [super init];
    if (self) {
        downloadQueue = [[NSOperationQueue alloc]init];
        downloadQueue.maxConcurrentOperationCount =1;
    }
    return self;
}

+(DownloadUtil*)instance{
    
    if (downloadUtil == nil) {
        downloadUtil = [[DownloadUtil alloc]init];
    }
    return downloadUtil;
}

-(void)download:(NSString *)url delegate : (id<ParserDelegate>)delegate  parseWhat : (int)tag{
    
    BBEventParser *parser = [[BBEventParser alloc]initWithUrl:url delegate:delegate];
    parser.tag = tag;
    [downloadQueue addOperation:parser];
}

@end
