//
//  AgendaLoc.m
//  AppNMedia
//
//  Created by Srinivas on 27/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "AgendaLoc.h"
#import "AgendaItem.h"

@interface AgendaLoc()

@property(nonatomic,readwrite) NSString *locId;
@property(nonatomic,readwrite) NSString *address;
@property(nonatomic,readwrite) NSMutableArray *itemArray;

@end

@implementation AgendaLoc

@synthesize locId = _locId;
@synthesize address = _address;
@synthesize itemArray = _itemArray;

-(id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(id)initWithDict:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        NSDictionary *attr = [dict objectForKey:@"attributes"];
        self.locId = [attr objectForKey:@"id"];
        self.address = [attr objectForKey:@"address"];
        self.itemArray = [AgendaItem collection:dict];
    }
    return self;
}

+(NSMutableArray*)collection:(id)object{
    NSMutableArray *collection = nil;
    
//    NSLog(@"ANGENDA LOC %@ ", object);
    if (object == nil) {
        return nil;
    }
    
//    id object = [dict objectForKey:@"item"];
    
//    NSLog(@"ANGENDA LOC %@ ", object);

    if ([object isKindOfClass:[NSDictionary class]]) {
    
        if (collection == nil) {
            collection = [[NSMutableArray alloc]init];
        }
        AgendaLoc *loc = [[AgendaLoc alloc]initWithDict:(NSDictionary*)object];
       [collection addObject:loc];
   
    }else if([object isKindOfClass:[NSArray class]]){
        NSArray *array =  (NSArray*)object;
        for (NSDictionary *dict in array) {
            if (collection == nil) {
                collection = [[NSMutableArray alloc]init];
            }
            AgendaLoc *loc = [[AgendaLoc alloc]initWithDict:dict];
            [collection addObject:loc];
        }
    }
    return collection
    ;
}

@end
