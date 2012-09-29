//
//  SubAgendaItem.h
//  AppNMedia
//
//  Created by Srinivas on 27/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubAgendaItem : NSObject{
//    <agendaid>26</agendaid>
//    <title>test</title>
//    <date>Friday. 08/17/2012</date>
//    <enddate>Friday. 08/17/2012</enddate>
//    <starttime>01:02 am</starttime>
//    <endtime>12:12 pm</endtime>
//    <locationid>2</locationid>
//    <address>
//    KTPO Bangalore, Plot No.121, EPIP, Whitefield Industrial Area,, Bangalore, Karnataka 560052
//    </address>
//    <room/>
//    <level/>
//    <agendaspeaker/>
//    <presenter_type/>
//    <description/>
//    <url/>
//    <createddate>09/27/2012</createddate>
//    <modifieddate>09/27/2012</modifieddate>
//    <status>1</status>
    
    NSString *_agendaId;
    NSString *_title;
    NSString *_date;
    NSString *_endDate;
    NSString *_startTime;
    NSString *_endTime;
    NSString *_address;
    NSString *_url;
    NSString *_description;
    NSString *_presenterType;
    NSString *_room;
    NSString *_level;
    NSMutableArray *_speakers;
    
}

@property(nonatomic,readonly) NSString *agendaId;
@property(nonatomic,readonly) NSString *title;
@property(nonatomic,readonly) NSString *date;
@property(nonatomic,readonly) NSString *endDate;
@property(nonatomic,readonly) NSString *startTime;
@property(nonatomic,readonly) NSString *endTime;
@property(nonatomic,readonly) NSString *address;
@property(nonatomic,readonly) NSString *url;
@property(nonatomic,readonly) NSString *description;
@property(nonatomic,readonly) NSString *presenterType;
@property(nonatomic,readonly) NSString *room;
@property(nonatomic,readonly) NSString *level;
@property(nonatomic,readonly) NSMutableArray *speakers;

-(id)initWithDict:(NSDictionary*)dict;
+(NSMutableArray*)collection:(NSDictionary*)dict;
    

@end
