//
//  MainParserClass.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 26/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AppNMediaAppDelegate;
@class EventsParserClass;
@class EventsListViewController;
#import "BBEventParser.h"
@interface MainParserClass : NSObject <ParserDelegate>
{
    AppNMediaAppDelegate *appDelegate;
    EventsParserClass    *eventParserClass;
    EventsListViewController *eventListViewController;
    
    NSMutableURLRequest *request;
    NSURLConnection *connection;
    NSMutableData *webServiceData;
    BOOL dataReceived;
    NSTimer *timer;
     
    NSString *urlString;
    NSDictionary *resultDict;
    
    /////
    NSMutableDictionary *tokenIdDict;

}
@property(nonatomic,retain)NSDictionary *resultDict;
-(void)callMainParsingMethod;
-(void)parseAdOnDifferentThread;
-(void)eventsInfoSeperationMethod;
-(void)callAllEventsInfoParsingMethod;
-(void)startUserInteractions;
/////////////////
- (NSString *)flattenHTML:(NSString *)html ;
@end
