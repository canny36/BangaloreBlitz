//
//  AgendaLoc.h
//  AppNMedia
//
//  Created by Srinivas on 27/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AgendaLoc : NSObject
{
    NSString *_locId;
    NSString *_address;
    NSMutableArray *_itemArray;
    
}
@property(nonatomic,readonly) NSString *locId;
@property(nonatomic,readonly) NSString *address;
@property(nonatomic,readonly) NSMutableArray *itemArray;

+(NSMutableArray*)collection:(id)object;

@end
