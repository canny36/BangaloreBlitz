//
//  SubAgendaItem.m
//  AppNMedia
//
//  Created by Srinivas on 27/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "SubAgendaItem.h"
#import "SpeakerInfo.h"
#include "AppNMediaAppDelegate.h"

@interface SubAgendaItem()

@property(nonatomic,readwrite) NSString *agendaId;
@property(nonatomic,readwrite) NSString *title;
@property(nonatomic,readwrite) NSString *date;
@property(nonatomic,readwrite) NSString *endDate;
@property(nonatomic,readwrite) NSString *startTime;
@property(nonatomic,readwrite) NSString *endTime;
@property(nonatomic,readwrite) NSString *address;
@property(nonatomic,readwrite) NSString *url;
@property(nonatomic,readwrite) NSString *description;
@property(nonatomic,readwrite) NSString *presenterType;
@property(nonatomic,readwrite) NSString *room;
@property(nonatomic,readwrite) NSString *level;
@property(nonatomic,readwrite) NSMutableArray *speakers;

@end

@implementation SubAgendaItem
//<agendaid>26</agendaid>
//<title>test</title>
//<date>Friday. 08/17/2012</date>
//<enddate>Friday. 08/17/2012</enddate>
//<starttime>01:02 am</starttime>
//<endtime>12:12 pm</endtime>
//<locationid>2</locationid>
//<address>
//KTPO Bangalore, Plot No.121, EPIP, Whitefield Industrial Area,, Bangalore, Karnataka 560052
//</address>
//<room/>
//<level/>
//<agendaspeaker/>
//<presenter_type/>
//<description/>
//<url/>
//<createddate>09/27/2012</createddate>
//<modifieddate>09/27/2012</modifieddate>
//<status>1</status>

-(id)initWithDict:(NSDictionary*)dict{
    
    self = [super init];
    if (self) {
        self.title = [dict objectForKey:@"title"];
         self.description = [dict objectForKey:@"description"];
         self.date = [dict objectForKey:@"date"];
         self.endDate = [dict objectForKey:@"enddate"];
         self.startTime = [dict objectForKey:@"starttime"];
         self.endTime = [dict objectForKey:@"endtime"];
         self.room = [dict objectForKey:@"room"];
         self.level = [dict objectForKey:@"level"];
         self.address = [dict objectForKey:@"address"];
         self.presenterType = [dict objectForKey:@"presenter_type"];
         self.speakers = [SpeakerInfo agendaCollection:[dict objectForKey:@"agendaspeakers"]];
    }
    return self;
}


+(NSMutableArray*)collection:(NSDictionary*)dict{
   
    NSMutableArray *collection = nil;

    id object = [dict objectForKey:@"subitem"];
    
    if ([object isKindOfClass:[NSDictionary class]]) {
      
        if (collection == nil) {
            collection = [[NSMutableArray alloc]init];
        }
        SubAgendaItem *item =  [[SubAgendaItem alloc]initWithDict:(NSDictionary*)object];
        [collection addObject:item];
        
    }else if([object isKindOfClass:[NSArray class]]){
        
        NSArray *array = (NSArray*)object;
        for (NSDictionary *dict in array ) {
            if (collection == nil) {
                collection = [[NSMutableArray alloc]init];
            }
            SubAgendaItem *item =  [[SubAgendaItem alloc]initWithDict:dict];
            [collection addObject:item];
        }
    }
    return collection;
}

@end
