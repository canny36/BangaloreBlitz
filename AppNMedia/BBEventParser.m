//
//  BBEventParser.m
//  AppNMedia
//
//  Created by Srinivas on 22/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "BBEventParser.h"
#import "XMLToDictionary.h"

@interface BBEventParser()
@property(nonatomic,readwrite) NSString *url;
@end


@implementation BBEventParser

@synthesize url = _url;
@synthesize tag;

-(id)initWithUrl:(NSString*)urlString delegate:(id<ParserDelegate>)_delegate{
    self = [super init];
    if (self) {
        self.url = urlString;
        delegate = _delegate;
    }
    return  self;
}

-(void)main{
    [self parseXml:self.url];
}

-(void)cancel{
    cancel = YES;
}

-(void)parseXml:(NSString*)url{
    
    if (cancel) {
        return;
    }
    NSURLResponse *response ;
    NSError *error;
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSHTTPURLResponse *httpResponse =  (NSHTTPURLResponse*)response;
    
    if (error) {
        [delegate onError:&error];
    }
    
    if( httpResponse.statusCode == 200){
        if (responseData != nil) {
            [self parseData:responseData];
        }else{
            [delegate onError:nil];
        }
    }else{
         [delegate onError:nil];
    }
}

-(void)parseData:(NSData*)data{
    
    if (cancel) {
        return;
    }
    
    XMLToDictionary *xmlDict = [[XMLToDictionary alloc]init];
    [xmlDict setNeedAttributesKey:YES needEmptyTags:YES];
    NSDictionary *dictionary = [xmlDict parseData:data enableDebug:YES];
    if(dictionary != nil){
        NSLog(@"RESPONSE FROM SRVER %@ ", dictionary);
        [delegate onSuccess:dictionary];
    }else{
        [delegate onError:nil];
    }
}



@end
