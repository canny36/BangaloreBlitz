//
//  SPonsor.m
//  AppNMedia
//
//  Created by Srinivas on 12/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "SPonsor.h"
#import "AppNMediaAppDelegate.h"

@interface Category : NSObject{
    
    NSString *_id;
    NSString *name;
}

@property(retain,readonly) NSString *_id;
@property(retain,readonly) NSString *name;

@end


@interface Category()

@property(retain,readwrite) NSString *_id;
@property(retain,readwrite) NSString *name;

@end

@implementation Category

- (id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        self._id = [dict objectForKey:@"id"];
        self.name = [dict objectForKey:@"name"];
    }
    
    return self;
}



@end


@interface SPonsor()

@property(retain,readwrite) NSString *categoryID;
@property(retain,readwrite) NSString *categoryName;
@property(retain,readwrite) NSString *address1;
@property(retain,readwrite) NSString *city;
@property(retain,readwrite) NSString *createdBy;
@property(retain,readwrite) NSString *createdDate;
@property(retain,readwrite) NSString *eventId;
@property(retain,readwrite) NSString *level;
@property(retain,readwrite) NSString *name;
@property(retain,readwrite) NSString *rank;
@property(retain,readwrite) NSString *sponsorId;
@property(retain,readwrite) NSString *state;
@property(retain,readwrite) NSString *status;
@property(retain,readwrite) NSString *logo;
@property(retain,readwrite) NSString *logourl;
@property(retain,readwrite) NSMutableArray *categoryArray;

@end
@implementation SPonsor

//static NSMutableDictionary *categoryDictionary;
//static NSMutableArray *categoryArray;



- (id)init
{
    self = [super init];
    if (self) {
       
        
    }
    return self;
}


-(id)initWithDict:(NSDictionary*)dict category :(Category*)category{
    self = [super init];
    if (self) {
//        address1 = Madiwala;
//        city = Banglore;
//        createdby = 29;
//        createddate = "09/12/2012";
//        eventid = 1;
//        level = "Event Sponsor";
//        name = eventsp2;
//        rank = 1;
//        sponsorid = 2;
//        state = KT;
//        status = 1;
        
        self.address1 = [dict objectForKey:@"address1"];
        self.city = [dict objectForKey:@"city"];
        self.createdBy = [dict objectForKey:@"createdby"];
        self.createdDate = [dict objectForKey:@"createddate"];
        self.eventId = [dict objectForKey:@"eventid"];
        self.level = [dict objectForKey:@"level"];
        self.name = [dict objectForKey:@"name"];
        self.rank = [dict objectForKey:@"rank"];
        self.sponsorId = [dict objectForKey:@"sponsorid"];
        self.state = [dict objectForKey:@"state"];
        self.status= [dict objectForKey:@"status"];
        self.categoryID = category._id;
        self.categoryName = category.name;
        self.logo = [dict objectForKey:@"logo"];
        self.logourl = [dict objectForKey:@"logourl"];
        
    }
    return self;
}


+(NSMutableDictionary*)collectSponsors{
    
    NSMutableDictionary *categorydict = [[NSMutableDictionary alloc]init];
    AppNMediaAppDelegate *appdelegate = (AppNMediaAppDelegate*)[[UIApplication sharedApplication] delegate];
//        
    id object = [[[appdelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"sponsorslist"] objectForKey:@"category"];
    
    NSLog(@" SPONSER BUFFER = %@ ",object);
    
    if ([object  isKindOfClass:[NSArray class]]) {
        
       
        
        NSArray *array = (NSArray*)object;
        for (int i=0, size = [array count]; i<size; i++) {
            
             NSLog(@" APPDELEGATE org collection  %@ ",object);
            
            NSDictionary *dict = [array objectAtIndex:i];
            NSDictionary *_categorydict = [dict objectForKey:@"attributes"];
//            NSMutableArray *categoryArray = [[NSMutableArray alloc]init];
            
            Category *category = [[Category alloc]initWithDict:_categorydict];
            
            NSArray *sponsorArray =  [dict objectForKey:@"sponsor"];
            
            NSLog(@" APPDELEGATE sponsor array   %@ ",sponsorArray);

            NSMutableArray *sponsors = [[NSMutableArray alloc]init];
            for (int i=0,size = sponsorArray.count ; i<size ; i++) {
                
                NSDictionary *dict = [sponsorArray objectAtIndex:i];
                SPonsor *sponsor = [[SPonsor alloc]initWithDict:dict category:category];
                [sponsors addObject:sponsor];
            [categorydict setValue:sponsors forKey:category.name];

            }
          
        }
        
    }
    return categorydict;
}

@end
