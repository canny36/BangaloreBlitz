//
//  Organizer.h
//  AppNMedia
//
//  Created by Srinivas on 10/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Organizer : NSObject
{
    NSString *description;
    NSString *highlight;
    NSString *logo;
    NSString *title;
    NSString *type;
    NSString * weblink;
    NSString *organizerid;
}

@property(retain ,readonly) NSString *description;
@property(retain ,readonly) NSString *highlight;;
@property(retain ,readonly) NSString *logo;
@property(retain ,readonly) NSString *type;
@property(retain ,readonly) NSString *title;
@property(retain ,readonly) NSString *weblink;
@property(retain ,readonly) NSString *organizerid;

-(id)initWithDict:(NSDictionary*)dict;

+(NSMutableArray*)collection;

@end
