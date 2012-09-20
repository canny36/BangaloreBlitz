//
//  SupportedBy.h
//  AppNMedia
//
//  Created by Srinivas on 10/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SupportedBy : NSObject{
    NSString *logo;
    NSString *sbId;
    NSString *title;
    NSString *weblink;
    
}

@property(retain ,readonly) NSString *logo;
@property(retain ,readonly) NSString *sbId;
@property(retain ,readonly) NSString *title;
@property(retain ,readonly) NSString *weblink;

+(NSMutableArray*)collection;

@end
