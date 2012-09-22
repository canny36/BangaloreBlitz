//
//  MainParserClass.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 26/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "MainParserClass.h"
#import "AppNMediaAppDelegate.h"
#import "EventsParserClass.h"
#import "EventsListViewController.h"
#import "XMLToDictionary.h"
@implementation MainParserClass
@synthesize resultDict;

- (NSString *)dataFilePathForTokenId
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"tokenId.plist"];
}

-(id)init
{
    self = [super init];
    if (self) 
    {
        appDelegate = (AppNMediaAppDelegate *)[[UIApplication sharedApplication] delegate];
        [self callMainParsingMethod];
        
    }
    return self;
}

- (NSString *)flattenHTML:(NSString *)html 
{
    
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        [theScanner scanUpToString:@"<" intoString:NULL] ; 
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}

-(void)callAllEventsInfoParsingMethod
{
    
    NSString *filePath = [self dataFilePathForTokenId];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        tokenIdDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    }
    else
    {
        tokenIdDict = [[NSMutableDictionary alloc] initWithCapacity:0];
 
    }
    
    NSLog(@"EVENTSARRAY COUNT %d",[appDelegate.eventsArray count] );
    
    for (int i = 0; i<[appDelegate.eventsArray count]; i++)
    {
    
       // http://conferenceapps.net/mobile/eventinfo.php?id=1&tokenid=&devicetoken=&os=1
        
        eventParserClass = [[EventsParserClass alloc] init];
        eventParserClass.allInfoParsingCompleted = NO;
        
//        NSString *url =  @"http://conferenceapps.net/mobile/eventinfo.php?id=1&tokenid=&devicetoken=&os=1";
        
         NSString *url =  @"http://conferenceapps.net/mobile/eventinfo.php?id=";
        NSMutableDictionary *tmpDict  = [appDelegate.eventsArray objectAtIndex:i];
        NSString *id = [tmpDict objectForKey:@"eventid"];
        
        url = [url stringByAppendingString:id];
        
        if ([tokenIdDict objectForKey:@"tokenId"]!= nil)
        {
            url = [url stringByAppendingString:@"&tokenid="];
            url = [url stringByAppendingString:[tokenIdDict objectForKey:@"tokenId"]];
        }
        
        url = [url stringByAppendingString:@"&devicetoken="];
        if (appDelegate.mainDeviceToken!= nil)
        {
            url = [url stringByAppendingString:appDelegate.mainDeviceToken];
            url = [url stringByAppendingString:@"&os=1"];
        }
        
        [eventParserClass callMainParsingMethod:url];
   
    }
}

-(void)startUserInteractions
{
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
}
-(void)eventsInfoSeperationMethod
{
//    appDelegate.tmpStylesDict = [[resultDict objectForKey:@"root"] objectForKey:@"client"] ;
//
     
    [appDelegate.eventsArray removeAllObjects];
    
    id response = [[[appDelegate.mainResponseDictionary objectForKey:@"root"] objectForKey:@"events"] objectForKey:@"event"];
    
    if ([response isKindOfClass:[NSDictionary class]])
    {
        NSLog(@" EVENT RESPONSE %@ ", (NSDictionary*)response);
        if ( appDelegate.eventsArray == nil ) {
            appDelegate.eventsArray  = [[NSMutableArray alloc]initWithCapacity:0];
        }
        
        [appDelegate.eventsArray addObject:response];
    }
    else
    {
        [appDelegate.eventsArray addObjectsFromArray:[[[appDelegate.mainResponseDictionary objectForKey:@"root"] objectForKey:@"events"] objectForKey:@"event"]  ];
    }  
    
    
    [self callAllEventsInfoParsingMethod];
   
}


////////////////////////////// WebServices calling
-(void)callMainParsingMethod
{
    NSURL *url = [NSURL URLWithString:@"http://conferenceapps.net/mobile/client.php?id=29"];
    
    
	request = [[NSMutableURLRequest alloc]initWithURL:url];
		
	
    connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
   
//    timer = [NSTimer scheduledTimerWithTimeInterval:100 target:self selector:@selector(cancelConnection:) userInfo:connection repeats:NO];
    
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
//	NSLog(@"error occured in login response = %@",[error description]);
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"No network " delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//    [alert show];
}
-(void)parseAdOnDifferentThread
{
        
    XMLToDictionary *xmlParsing = [[XMLToDictionary alloc] init];
    [xmlParsing setNeedAttributesKey:YES needEmptyTags:NO];
    
    
    appDelegate.mainResponseDictionary = [xmlParsing parseData:webServiceData enableDebug:NO];
    NSLog(@"RESPONSE  %@",appDelegate.mainResponseDictionary  );
    [self eventsInfoSeperationMethod];
    
}


-(void)cancelConnection:(NSTimer *)myTimer
{
    NSLog(@"network broke");
    NSURLConnection *tempConnection = [myTimer userInfo];
    if([tempConnection isEqual:connection])
    {
        if (dataReceived == NO)
        {
            [connection cancel];
            [appDelegate.activityIndicator stopAnimating];
            [[UIApplication sharedApplication]endIgnoringInteractionEvents];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Network problem " delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
        
        timer = nil;
    }
    
}
- (void)dealloc
{
    
}


@end
