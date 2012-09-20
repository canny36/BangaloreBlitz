//
//  SPonsor.h
//  AppNMedia
//
//  Created by Srinivas on 12/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPonsor : NSObject{
    
    
    
//    sponsorslist =         {
//        category =             (
//                                {
//                                    attributes =                     {
//                                        id = 1;
//                                        name = Event;
//                                    };
//                                    sponsor =                     (
//                                                                   {
//                                                                       address1 = Madiwala;
//                                                                       city = Banglore;
//                                                                       createdby = 29;
//                                                                       createddate = "09/12/2012";
//                                                                       eventid = 1;
//                                                                       level = "Event Sponsor";
//                                                                       name = eventsp2;
//                                                                       rank = 1;
//                                                                       sponsorid = 2;
//                                                                       state = KT;
//                                                                       status = 1;
//                                                                   },
    
    NSString *categoryID;
    NSString *categoryName;
    NSString *address1;
    NSString *city;
    NSString *createdBy;
    NSString *createdDate;
    NSString *eventId;
    NSString *level;
    NSString *name;
    NSString *rank;
    NSString *sponsorId;
    NSString *state;
    NSString *status;
    NSString *logo;
    NSString *logourl;


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
