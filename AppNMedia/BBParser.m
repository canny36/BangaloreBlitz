//
//  BBParser.m
//  AppNMedia
//
//  Created by Srinivas on 22/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "BBParser.h"
#import "BBEventParser.h"
#import "DownloadUtil.h"

#define MAIN_URL @"http://conferenceapps.net/mobile/client.php?id=29"

#define PARSE_MAIN 0
#define PARSE_EVENT 1



@implementation BBParser

-(id)init{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

-(void)parseMain{
    [[DownloadUtil instance] download: MAIN_URL delegate:self];
}

-(void)onSuccess : (NSDictionary*)responseDict eventParser:(BBEventParser*)parser{
    if (parser.tag == PARSE_MAIN) {
        [self afterParsingMain:responseDict];
    }else{
        [self afterParsingEvent:responseDict];
    }
}

-(void)onError :(NSError**)error{
    NSLog(@"ERROR LOADING");
}

-(void)afterParsingMain:(NSDictionary*)dict{
    
    id response = [[[dict objectForKey:@"root"] objectForKey:@"events"] objectForKey:@"event"];
    if ([response isKindOfClass:[NSDictionary class]]) {
//        NSDictionary *event = (NSDictionary*)response;
        
    }else if([response isKindOfClass:[NSArray class]]){
//        NSArray *eventArray = (NSArray*)response;
        
    }
    
}

-(void)fetchEvent:(NSDictionary*)dict{
    
}

-(void)afterParsingEvent:(NSDictionary*)dict{
    //
}

-(void)cacheEventInfo:(NSDictionary*)dict{
    //
}


- (NSString *)filePathForTokenId
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"tokenId.plist"];
}

- (NSString *)dataFilePathForEventsInfo
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"events.plist"];
}

@end
