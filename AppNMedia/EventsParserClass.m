//
//  EventsParserClass.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 27/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "EventsParserClass.h"
#import "AppNMediaAppDelegate.h"
#import "XMLToDictionary.h"

@implementation EventsParserClass
@synthesize resultDict;
@synthesize allInfoParsingCompleted;

- (NSString *)dataFilePathForEventsInfo
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"events.plist"];
}

- (NSString *)dataFilePathForLastUpdatedInfo
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"lastUpdated.plist"];
}

-(id)init
{
    self = [super init];
    if (self) 
    {
        appDelegate = (AppNMediaAppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}
-(void)assignMainResponseDict
{
//    if ([appDelegate.completeEventsInfoArray count]>0)
//    {
//        if ([[[appDelegate.completeEventsInfoArray objectAtIndex:0] objectForKey:@"event"] objectForKey:@"tokenid"] != nil)
//        {
//            appDelegate.tokenId = [[[appDelegate.completeEventsInfoArray objectAtIndex:0] objectForKey:@"event"] objectForKey:@"tokenid"];
//            
//            NSString *filePath = [self dataFilePathForTokenId];
//            
//            NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] initWithCapacity:0];
//            [tmpDic setObject:appDelegate.tokenId forKey:@"tokenId"];
//            [tmpDic writeToFile:filePath atomically:YES];
//            
//        }
//        
//        if ([appDelegate.completeEventsInfoArray count] == 1) 
//        {
//            appDelegate.mainResponseDict = [appDelegate.completeEventsInfoArray objectAtIndex:0];
//            appDelegate.selectedEvent = 0;
//            [appDelegate loadCompleteOffLineImages];
//            
//        }
//
//    }
    
        
}

////////////////////////////// WebServices calling
-(void)callMainParsingMethod :(NSString *)urlString1
{
    allInfoParsingCompleted = NO;

    NSURL *url = [NSURL URLWithString:urlString1];
    
    if (request != nil)
    {
    }
	request = [[NSMutableURLRequest alloc]initWithURL:url];
    
	if (connection != nil) 
	{
	}
    connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    
    if (timer  != nil)
    {
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:55 target:self selector:@selector(cancelConnection:) userInfo:connection repeats:NO];
    
}



-(void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)data
{
    dataReceived = YES;
    [webServiceData appendData:data]; 
}
-(void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)response
{
    
    webServiceData = [[NSMutableData alloc]init];
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)aConnection
{
   [self parseAdOnDifferentThread];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	//NSLog(@"error occured in login response");
}
-(void)parseAdOnDifferentThread
{
    
    
    XMLToDictionary *xmlParsing = [[XMLToDictionary alloc] init];
    [xmlParsing setNeedAttributesKey:YES needEmptyTags:NO];
    if (resultDict) 
    {
    }
    resultDict = [xmlParsing parseData:webServiceData enableDebug:NO];
    
    if (appDelegate.fromDataSynchMethod == YES)
    {
        if ([resultDict objectForKey:@"result"]!= nil)
        {
            NSLog(@"nodata");
        }
        else
        {
            [appDelegate.allEventsInfoArray removeAllObjects];
            [appDelegate.allEventsInfoArray addObject:resultDict];
            allInfoParsingCompleted = YES;
            [self storeingInformation]; 
            
            appDelegate.mainResponseDict = [appDelegate.allEventsInfoArray objectAtIndex:0];

        }
               
    }
    else
    {
    
    if ([resultDict objectForKey:@"result"]!= nil)
    {
        [appDelegate nodataResponseMethod];
    }
    else
    {
        [appDelegate.allEventsInfoArray addObject:resultDict];
    }
        NSLog(@"the all information array = %@",resultDict);
    
    [appDelegate createCustomStyleDict];
    allInfoParsingCompleted = YES;
    [self storeingInformation];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];


    }

    [appDelegate.activityIndicator stopAnimating];

}


-(void)cancelConnection:(NSTimer *)myTimer
{
    NSURLConnection *tempConnection = [myTimer userInfo];
    if([tempConnection isEqual:connection])
    {
        if (dataReceived == NO)
        {
            [connection cancel];
            [appDelegate.activityIndicator stopAnimating];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];

            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Network problem " delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
        timer = nil;
    }
    
}

-(void)storeingInformation
{
    if (allInfoParsingCompleted == YES)
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        [tmpDict setObject:appDelegate.eventsArray forKey:@"eventsArray"];
        
        [tmpDict setObject:appDelegate.allEventsInfoArray forKey:@"allEventsInfoArray"];

        
        NSDateFormatter *df = [NSDateFormatter new];
        [df setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        
        NSDate *presentDate=[NSDate date];
        NSString *lastUpdate=[df stringFromDate:presentDate];
        [tmpDict setObject:lastUpdate forKey:@"lastUpdatedTimeAndDate"];

        NSString *filePath = [self dataFilePathForEventsInfo];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
            [tmpDict writeToFile:filePath atomically:YES];
        }
        else
        {
            [tmpDict writeToFile:filePath atomically:YES];
 
        }
        
    }
    
        
}
- (void)dealloc
{
}

@end
