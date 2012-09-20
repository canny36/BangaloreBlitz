//
//  Util.h
//  AppNMedia
//
//  Created by Srinivas on 18/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LARGE_FONT_SIZE 15;
#define MEDIUM_FONT_SIZE 13;
#define SMALL_FONT_SIZE 11;

@interface Util : NSObject



+(UIColor*)titleColor;
+(UIColor*)subTitleColor;
+(UIColor*)linkTextColor;
+(UIColor*)detailTextColor;

+(NSString*)titleFontName;
+(NSString*)subTitleFontName;
+(NSString*)linkTextFontName;
+(NSString*)detailTextFontName;

@end
