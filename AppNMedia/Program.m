//
//  Program.m
//  AppNMedia
//
//  Created by Srinivas on 11/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "Program.h"
#import "AppNMediaAppDelegate.h"


@interface Program(){
    @private
}

@property(retain,readwrite)NSString *programID;
@property(retain,readwrite)NSString *logo;
@property(retain,readwrite)NSString *weblink;
@property(retain,readwrite)NSString *title;
@property(retain,readwrite)NSString *description;

@end

@implementation Program

@synthesize programID,logo,weblink,title,description;


- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


-(id)initWithDict:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        self.title = [dict objectForKey:@"title"];
        self.weblink = [dict objectForKey:@"weblink"];
        self.description = [dict objectForKey:@"description"];
        self.logo = [dict objectForKey:@"logo"];
        self.programID = [dict objectForKey:@"additionalitemid"];
    }
    return self;
}

+(NSMutableArray*)collection{
    
    AppNMediaAppDelegate *appdelegate = (AppNMediaAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray *supportedByArray = [[NSMutableArray alloc]init];
    
    id object = [[[appdelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"additionalitemlist"] objectForKey:@"additionalitem"];
    
    if ([object  isKindOfClass:[NSArray class]]) {
        
        NSLog(@" APPDELEGATE org collection  %@ ",object);
        
        NSArray *array = (NSArray*)object;
        for (int i=0, size = [array count]; i<size; i++) {
            NSDictionary *dict = [array objectAtIndex:i];
            Program *program = [[Program alloc]initWithDict:dict];
            [supportedByArray addObject:program];
        }
    }else{
        NSLog(@" APPDELEGATE org collection one  %@ ",object);
        if (object != nil && ! (object == [NSNull null]) && [object isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dict = (NSDictionary*)object;
            Program *program = [[Program alloc]initWithDict:dict];
            [supportedByArray addObject:program];
            
        }
       
    }
    
    return supportedByArray;
 
}

@end
