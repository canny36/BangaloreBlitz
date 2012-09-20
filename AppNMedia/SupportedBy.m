//
//  SupportedBy.m
//  AppNMedia
//
//  Created by Srinivas on 10/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "SupportedBy.h"
#import "AppNMediaAppDelegate.h"
@interface SupportedBy()

@property(retain ,readwrite) NSString *logo;
@property(retain ,readwrite) NSString *sbId;
@property(retain ,readwrite) NSString *title;

@end

@implementation SupportedBy
    
@synthesize logo,sbId,title;
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(id)initWithDict:(NSDictionary*)dict{
    self = [super init];
    if (self != nil) {
                              
        self.logo = [dict objectForKey:@"logo"];
        self.sbId = [dict objectForKey:@"supportedbyid"];
        self.logo = [dict objectForKey:@"weblink"];
        self.title = [dict objectForKey:@"title"];
    }
    return self;
}

+(NSMutableArray*)collection{

    
    AppNMediaAppDelegate *appdelegate = (AppNMediaAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray *supportedByArray = [[NSMutableArray alloc]init];
    
   id object = [[[appdelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"supportedbylist"] objectForKey:@"supportedby"];
    
    if ([object  isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary*)object;
        SupportedBy *supportedBY = [[SupportedBy alloc]initWithDict:dict];
        [supportedByArray addObject:supportedBY];
        
    }
    return supportedByArray;

}

@end
