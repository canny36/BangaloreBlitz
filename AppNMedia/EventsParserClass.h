//
//  EventsParserClass.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 27/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AppNMediaAppDelegate;

@interface EventsParserClass : NSObject <NSXMLParserDelegate>
{
    AppNMediaAppDelegate *appDelegate;
    
    NSMutableURLRequest *request;
    NSURLConnection *connection;
    NSMutableData *webServiceData;
    BOOL dataReceived;
    NSTimer *timer;
    
    NSString *urlString;
    NSDictionary *resultDict;
    
    BOOL allInfoParsingCompleted;
    
       
}
@property(nonatomic,retain)NSDictionary *resultDict;
@property BOOL allInfoParsingCompleted;
-(void)callMainParsingMethod :(NSString *)urlString1;
-(void)parseAdOnDifferentThread;
-(void)assignMainResponseDict;
-(void)storeingInformation;
@end
