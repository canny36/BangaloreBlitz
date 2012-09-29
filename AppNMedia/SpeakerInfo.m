//
//  SpeakerInfo.m
//  AppNMedia
//
//  Created by Srinivas on 26/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "SpeakerInfo.h"
#import "AppNMediaAppDelegate.h"

@implementation SpeakerInfo
    
@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize type = _type;
@synthesize description = _description;
@synthesize weblink = _weblink;
@synthesize speakerId = _speakerId;
@synthesize logo = _logo;
@synthesize presenterType=_presenterType;

-(id)initWithDict:(NSDictionary*)dict{
    
    self = [super init];
    
    if (self) {
        
//        //    <speakerid>55</speakerid>
//        //    <firstname>Dr. Amita Prasad, IAS</firstname>
//        //    <lastname/>
//        //    <speakerphoto/>
//        //    <title>
//        //    Principal Secretary to Government, Urban Development Department, Government of Karnataka
//        //    </title>
//        //    <description/>
//        //    <createddate>09/26/2012</createddate>
//        //    <modifieddate>09/26/2012</modifieddate>
//        //    <status/>
//        //    <weblink/>
//        //    <createdby>29</createdby>
//        //    <geo_locationid>0</geo_locationid>
//        //    <country/>
//        //    <city/>
//        //    <presentertype>Keynote Address</presentertype>
//        //    <typeid>2</typeid>
//        
        
        
        
        
        
        
        self.lastName = [dict objectForKey:@"lastname"];
        self.firstName = [dict objectForKey:@"firstname"]; 
        self.presenterType = [dict objectForKey:@"presentertype"];
        self.type = [dict objectForKey:@"title"];
        self.description = [dict objectForKey:@"description"];
        self.weblink = [dict objectForKey:@"weblink"];
        self.speakerId = [dict objectForKey:@"speakerid"];
        self.logo = [dict objectForKey:@"speakerphoto"];
        self.name = self.firstName;
        if (self.lastName != nil) {
           self.name = [self.firstName stringByAppendingString:@" "];
           self.name = [self.firstName stringByAppendingString:self.lastName];
        }
        
    }
    
    return self;
}

+(NSMutableArray*)collection{
    
    NSMutableArray *speakers = [[NSMutableArray alloc]init];
    
    AppNMediaAppDelegate *appDelegate = (AppNMediaAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"speakerslist"] objectForKey:@"speaker"] isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = [[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"speakerslist"] objectForKey:@"speaker"];
        SpeakerInfo *info = [[SpeakerInfo alloc]initWithDict:dict];
        [speakers addObject:info];
    }
    else
    {
        NSArray *speakerArray = [[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"speakerslist"] objectForKey:@"speaker"];
       
        for ( NSDictionary *dict in speakerArray ) {
            SpeakerInfo *info = [[SpeakerInfo alloc]initWithDict:dict];
            [speakers addObject:info];
        }
    }
    
    return speakers;
}


+(NSMutableArray*)agendaCollection:(NSDictionary*)dict{
    
    NSMutableArray *speakers = [[NSMutableArray alloc]init];

    id object =[dict objectForKey:@"agendaspeaker"] ;
    
    if ([object isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = (NSDictionary*)object;
        SpeakerInfo *info = [[SpeakerInfo alloc]initWithDict:dict];
        [speakers addObject:info];
    }
    else
    {
        NSArray *speakerArray = (NSArray*)object;
        
        for ( NSDictionary *dict in speakerArray ) {
            SpeakerInfo *info = [[SpeakerInfo alloc]initWithDict:dict];
            [speakers addObject:info];
        }
    }
    return speakers;
}

+(NSMutableArray*)favorites:(NSMutableArray*)array{
   
    NSMutableArray *favoriteSpeakers  = nil;
    NSMutableArray *speakers  =  [SpeakerInfo collection];
    for (NSString *speakerId in  array) {
        for (SpeakerInfo *info in speakers) {
            if ([info.speakerId isEqualToString: speakerId]) {
                if (favoriteSpeakers == nil) {
                    favoriteSpeakers = [[NSMutableArray alloc]init];
                }
                
                [favoriteSpeakers addObject:info];
                continue;
            }
        }
    }
    return favoriteSpeakers;
}


@end
