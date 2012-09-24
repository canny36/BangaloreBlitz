//
//  DownloadUtil.h
//  AppNMedia
//
//  Created by Srinivas on 22/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBEventParser.h"

@interface DownloadUtil : NSObject{
    
    NSOperationQueue *downloadQueue;
}

+(DownloadUtil*)instance;
-(void)download:(NSString *)url delegate : (id<ParserDelegate>)delegate;

@end

