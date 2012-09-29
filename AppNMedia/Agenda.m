//
//  Agenda.m
//  AppNMedia
//
//  Created by Srinivas on 27/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "Agenda.h"
#import "AgendaLoc.h"
#import "AppNMediaAppDelegate.h"

static NSMutableArray *sCollection = nil;


@interface Agenda()

@property(nonatomic,readwrite) NSString *date;
@property(nonatomic,readwrite) NSMutableArray *locArray;

@end

@implementation Agenda

@synthesize date=_date;
@synthesize locArray=_locArray;

-(id)initWithDict:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        NSDictionary *attr = [dict objectForKey:@"attributes"];
        self.date = [attr objectForKey:@"date"];
        self.locArray = [AgendaLoc collection:[dict objectForKey:@"agendalocation"]];
    }
    return self;
}

+(void)clear{
    
    sCollection = nil;
}

+(NSMutableArray*)collection{
    
    if (sCollection) {
        return sCollection;
    }

    NSMutableArray *collection = nil;
    
    AppNMediaAppDelegate *appDelegate = (AppNMediaAppDelegate*)[UIApplication sharedApplication].delegate;
    NSDictionary *dict =  [[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"agendalist"];
    
    id object = [dict objectForKey:@"agenda"];
    
    if (object == nil ) {
        return nil;
    }
    if ([object isKindOfClass:[NSDictionary class]]) {
       
        if (collection == nil) {
           collection = [[NSMutableArray alloc]init];
        }
        
         Agenda *agenda = [[Agenda alloc] initWithDict:(NSDictionary*)object];
         [collection addObject:agenda];
        
    }else if ([object isKindOfClass:[NSArray class]]){
        
        NSArray *array = (NSArray*)object;
        for (NSDictionary *dict in array) {
            if (collection == nil) {
                collection = [[NSMutableArray alloc]init];
            }
            
            Agenda *agenda = [[Agenda alloc] initWithDict:dict];
            [collection addObject:agenda];
        }
    }
    
    sCollection  = collection;
    
    return collection;
}

@end
