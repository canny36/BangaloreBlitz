//
//  SpeakerInfo.h
//  AppNMedia
//
//  Created by Srinivas on 26/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpeakerInfo : NSObject{
    
    NSString *_description;
    NSString *_firstName;
    NSString *_lastName;
    NSString *_type;
    NSString *_weblink;
    NSString *_speakerId;
    NSString *_logo;
    NSString *_name;
    NSString *_presenterType;
    
}

@property(nonatomic,retain) NSString *description;
@property(nonatomic,retain) NSString *firstName;
@property(nonatomic,retain) NSString *lastName;
@property(nonatomic,retain) NSString *type;
@property(nonatomic,retain) NSString *weblink;
@property(nonatomic,retain) NSString *speakerId;
@property(nonatomic,retain) NSString *logo;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *presenterType;

+(NSMutableArray*)collection;
-(id)initWithDict:(NSDictionary*)dict;
+(NSMutableArray*)favorites:(NSMutableArray*)array;
+(NSMutableArray*)agendaCollection:(NSDictionary*)dict;

@end
