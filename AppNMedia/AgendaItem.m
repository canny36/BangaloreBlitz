//
//  AgendaItem.m
//  AppNMedia
//
//  Created by Srinivas on 27/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "AgendaItem.h"
#import "SubAgendaItem.h"
#import "SpeakerInfo.h"
#import "Agenda.h"
#import "AgendaLoc.h"

@interface AgendaItem()


@property(nonatomic,readwrite) NSString *agendaId;
@property(nonatomic,readwrite) NSString *title;
@property(nonatomic,readwrite) NSString *date;
@property(nonatomic,readwrite) NSString *endDate;
@property(nonatomic,readwrite) NSString *startTime;
@property(nonatomic,readwrite) NSString *endTime;
@property(nonatomic,readwrite) NSString *address;
@property(nonatomic,readwrite) NSString *room;
@property(nonatomic,readwrite) NSString *level;
@property(nonatomic,readwrite) NSString *presenterType;
@property(nonatomic,readwrite) NSString *description;
@property(nonatomic,readwrite) NSString *url;

@property(nonatomic,readwrite) NSMutableArray *speakers;
@property(nonatomic,readwrite) NSMutableArray *subAgendaItems;
@property(nonatomic,readwrite) NSString *agendaSpeaker;
@end

@implementation AgendaItem

-(id)init{
   self =  [super init];
    if (self) {
        
    }
    return self;
}

-(id)initWithDict:(NSDictionary*)dict{
    
    self = [super init];
    if (self) {
        self.agendaId = [dict objectForKey:@"agendaid"];
        self.title = [dict objectForKey:@"title"];
        self.date = [dict objectForKey:@"date"];
        self.endDate = [dict objectForKey:@"enddate"];
        self.startTime = [dict objectForKey:@"starttime"];
        self.endTime = [dict objectForKey:@"endtime"];
        self.address = [dict objectForKey:@"address"];
        self.room = [dict objectForKey:@"room"];
        self.level = [dict objectForKey:@"level"];
        self.presenterType = [dict objectForKey:@"presenter_type"];
        self.url = [dict objectForKey:@"url"];
        self.description = [dict objectForKey:@"description"];
        self.subAgendaItems = [SubAgendaItem collection:[dict objectForKey:@"subagenda"]];
        self.speakers = [SpeakerInfo agendaCollection:[dict objectForKey:@"agendaspeakers"]];
        self.agendaSpeaker = [dict objectForKey:@"agendaspeaker"];;
    }
    
    return self;
}

+(NSMutableArray*)collection:(NSDictionary*)dict{
   
    NSMutableArray *collection = nil;
    
    id object = [dict objectForKey:@"item"];
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        if (collection == nil) {
            collection = [[NSMutableArray alloc]init];
        }
        
        AgendaItem *item = [[AgendaItem alloc]initWithDict:(NSDictionary*)object];
        [collection addObject:item];
        
    }else if([object isKindOfClass:[NSArray class]]){
        NSArray *array = (NSArray*)object;
        for ( NSDictionary *dict in array ) {
            if (collection == nil) {
                collection = [[NSMutableArray alloc]init];
            }
            
            AgendaItem *item = [[AgendaItem alloc]initWithDict:dict];
            [collection addObject:item];
        }
    }
    
    return collection;
}

+(NSMutableArray*)favorites:(NSMutableArray*)array{
    
   NSMutableArray *agendaItems;
   NSMutableArray *agendaArray =[Agenda collection];
    for (Agenda *agenda in agendaArray) {
        for(AgendaLoc *loc in agenda.locArray){
            if ([loc.itemArray count]>0) {
                if (agendaItems == nil) {
                    agendaItems = [[NSMutableArray alloc]init];
                }
                [agendaItems addObjectsFromArray:loc.itemArray];
            }
        }
    }
    
    NSLog(@"ANGENDAITEMS COUNT %d ",agendaItems.count);
    
    NSMutableArray *favoriteAgendaItems  = nil;
 
    for (NSString *agendaId in  array) {
        for (AgendaItem*info in agendaItems) {
            if ([info.agendaId isEqualToString: agendaId]) {
                
                if (favoriteAgendaItems == nil) {
                    favoriteAgendaItems = [[NSMutableArray alloc]init];
                }
                
                [favoriteAgendaItems addObject:info];
                continue;
            }
        }
    }
    
    NSLog(@" FAVORITE AGENDA  %@ ",favoriteAgendaItems);
    return favoriteAgendaItems;
}


@end
