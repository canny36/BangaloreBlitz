//
//  Organizer.m
//  AppNMedia
//
//  Created by Srinivas on 10/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "Organizer.h"
#import "AppNMediaAppDelegate.h"

@interface Organizer()

@property(retain ,readwrite) NSString *description;
@property(retain ,readwrite) NSString *highlight;;
@property(retain ,readwrite) NSString *logo;
@property(retain ,readwrite) NSString *type;
@property(retain ,readwrite) NSString *title;
@property(retain ,readwrite) NSString *weblink;
@property(retain ,readwrite) NSString *organizerid;

@end

@implementation Organizer
//    organizerslist =         {
//        organizer =             (
//                                 {
//                                     description = "MM Activ Sci-Tech Communications Pvt. Ltd.  is engaged in creating, planning, development and implementation of the fully integrated national & international trade shows, focusing on frontier technologies";
//                                     highlight = 1;
//                                     logo = "uploads/logo_1346764124.jpg";
//                                     organizerid = 17;
//                                     title = "MM Activ";
//                                     type = "Event Partner";
//                                     weblink = "http://www.mmactiv.in/index.php";
//                                 },
    @synthesize description,logo,weblink,title,highlight,type,organizerid ;

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
        
        self.logo = [dict objectForKey:@"logo"];
        self.organizerid = [dict objectForKey:@"organizerid"];
        self.weblink = [dict objectForKey:@"weblink"];
        self.title = [dict objectForKey:@"title"];
        self.type = [dict objectForKey:@"type"];
        self.highlight = [dict objectForKey:@"highlight"];
        self.description = [dict objectForKey:@"description"];
        
    }
    return self;    
}





+(NSMutableArray*)collection
{
    
    
    AppNMediaAppDelegate *appdelegate = (AppNMediaAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray *supportedByArray = [[NSMutableArray alloc]init];
    
    id object = [[[appdelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"organizerslist"] objectForKey:@"organizer"];
    
    if ([object  isKindOfClass:[NSArray class]]) {
        
        NSLog(@" APPDELEGATE org collection  %@ ",object);
      
        NSArray *array = (NSArray*)object;
        for (int i=0, size = [array count]; i<size; i++) {
            
            NSDictionary *dict = [array objectAtIndex:i];
            Organizer *organizer = [[Organizer alloc]initWithDict:dict];
            [supportedByArray addObject:organizer];
        }
       
        
    }else{
          NSLog(@" APPDELEGATE org collection one  %@ ",object);
        NSDictionary *dict = (NSDictionary*)object;
        Organizer *organizer = [[Organizer alloc]initWithDict:dict];
        [supportedByArray addObject:organizer];
    }
    
    return supportedByArray;
    
}

@end
