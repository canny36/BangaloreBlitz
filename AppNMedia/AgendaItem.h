//
//  AgendaItem.h
//  AppNMedia
//
//  Created by Srinivas on 27/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AgendaItem : NSObject{

    NSString *_agendaId;
    NSString *_title;
    NSString *_date;
    NSString *_endDate;
    NSString *_startTime;
    NSString *_endTime;
    NSString *_address;
    NSString *_room;
    NSString *_level;
    NSString *_presenterType;
    NSString *_description;
    NSString *_url;
    NSString *_agendaSpeaker;
    NSMutableArray *_speakers;
    NSMutableArray *_subAgendaItems;
    
}


@property(nonatomic,readonly) NSString *agendaId;
@property(nonatomic,readonly) NSString *title;
@property(nonatomic,readonly) NSString *date;
@property(nonatomic,readonly) NSString *endDate;
@property(nonatomic,readonly) NSString *startTime;
@property(nonatomic,readonly) NSString *endTime;
@property(nonatomic,readonly) NSString *address;
@property(nonatomic,readonly) NSString *room;
@property(nonatomic,readonly) NSString *level;
@property(nonatomic,readonly) NSString *presenterType;
@property(nonatomic,readonly) NSString *description;
@property(nonatomic,readonly) NSString *url;
@property(nonatomic,readonly) NSString *agendaSpeaker;

@property(nonatomic,readonly) NSMutableArray *speakers;
@property(nonatomic,readonly) NSMutableArray *subAgendaItems;

+(NSMutableArray*)collection:(NSDictionary*)dict;
-(id)initWithDict:(NSDictionary*)dict;
+(NSMutableArray*)favorites:(NSMutableArray*)array;
@end
