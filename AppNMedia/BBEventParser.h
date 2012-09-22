//
//  BBEventParser.h
//  AppNMedia
//
//  Created by Srinivas on 22/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParserDelegate <NSObject>

@required

-(void)onSuccess : (NSDictionary*)responseDict;
-(void)onError :(NSError**)error;

@end

@interface BBEventParser : NSOperation{
    
    id<ParserDelegate> delegate;
    NSString *url;
    BOOL isStarted;
    BOOL isFinished;
    BOOL cancel;
    
    
}

@end
