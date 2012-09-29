//
//  SPonsor.h
//  AppNMedia
//
//  Created by Srinivas on 12/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPonsor : NSObject{
    
    NSString *_categoryID;
    NSString *_categoryName;
    NSString *_address1;
    NSString *_city;
    NSString *_createdBy;
    NSString *_createdDate;
    NSString *_eventId;
    NSString *_level;
    NSString *_name;
    NSString *_rank;
    NSString *_sponsorId;
    NSString *_state;
    NSString *_status;
    NSString *_logo;
    NSString *_logourl;

}


@property(retain,readonly) NSString *categoryID;
@property(retain,readonly) NSString *categoryName;
@property(retain,readonly) NSString *address1;
@property(retain,readonly) NSString *city;
@property(retain,readonly) NSString *createdBy;
@property(retain,readonly) NSString *createdDate;
@property(retain,readonly) NSString *eventId;
@property(retain,readonly) NSString *level;
@property(retain,readonly) NSString *name;
@property(retain,readonly) NSString *rank;
@property(retain,readonly) NSString *sponsorId;
@property(retain,readonly) NSString *state;
@property(retain,readonly) NSString *status;
@property(retain,readonly) NSString *logo;
@property(retain,readonly) NSString *logourl;

+(NSMutableDictionary*)collectSponsors;
@end
