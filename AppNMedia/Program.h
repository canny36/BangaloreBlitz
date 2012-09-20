//
//  Program.h
//  AppNMedia
//
//  Created by Srinivas on 11/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Program : NSObject{
    
    NSString *programID;
    NSString *logo;
    NSString *weblink;
    NSString *title;
    NSString *description;
}

@property(retain,readonly)NSString *programID;
@property(retain,readonly)NSString *logo;
@property(retain,readonly)NSString *weblink;
@property(retain,readonly)NSString *title;
@property(retain,readonly)NSString *description;


+(NSMutableArray*)collection;
@end
