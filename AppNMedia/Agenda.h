//
//  Agenda.h
//  AppNMedia
//
//  Created by Srinivas on 27/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Agenda : NSObject{
    NSString *_date;
    NSMutableArray *_locArray;
}

@property(nonatomic,readonly) NSString *date;
@property(nonatomic,readonly) NSMutableArray *locArray;

+(NSMutableArray*)collection;
+(void)clear;

@end
