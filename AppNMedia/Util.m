//
//  Util.m
//  AppNMedia
//
//  Created by Srinivas on 18/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "Util.h"



@implementation Util


static UIColor *titleTextcolor;
static UIColor *subtitleTextcolor;
static UIColor *linkTextcolor;
static UIColor *detailTextcolor;


static NSString *titleFontName;
static NSString *subtitleFontName;
static NSString *linkFontName;
static NSString *detailFontName;


+(UIColor*)titleColor{
    
    if (titleTextcolor == nil) {
        
//        d5f9f7
        
        titleTextcolor = [UIColor colorWithRed:0.83 green:0.976 blue:0.968 alpha:1];
        
//    titleTextcolor = [UIColor colorWithRed:1 green:0.890 blue:0 alpha:1];
        
//        0.83, 0.976 , 0.968 
    }
    return  titleTextcolor;
}

+(UIColor*)subTitleColor{
    
    if (subtitleTextcolor == nil) {
        
//        CAD5DE 0.792 0.835 0.870
        
//        subtitleTextcolor = [UIColor colorWithRed:0.91 green:0.93 blue:0.95 alpha:1];
        
       subtitleTextcolor = [UIColor colorWithRed:0.792 green:0.835 blue:0.870 alpha:1];
    }
    return subtitleTextcolor;
}

+(UIColor*)linkTextColor{
    
    if (linkTextcolor == nil) {
        linkTextcolor = [UIColor colorWithRed:0.12 green:0.7 blue:1 alpha:1];
    }
    return linkTextcolor;
}

+(UIColor*)detailTextColor{
    
    if (detailTextcolor == nil) {
        
                
         detailTextcolor = [UIColor colorWithRed:0.792 green:0.835 blue:0.870 alpha:1];
    }
    return detailTextcolor;
}

+(NSString*)titleFontName{
    
    if (titleFontName == nil) {
        titleFontName = @"Helvetica-Bold";
    }
    return titleFontName;
}

+(NSString*)subTitleFontName{
    
    if (subtitleFontName == nil) {
        subtitleFontName = @"Helvetica-Bold";
    }
    return subtitleFontName;
}

+(NSString*)linkTextFontName{
    
    if (linkFontName == nil) {
        linkFontName =@"Verdana";
    }
    return linkFontName;
}

+(NSString*)detailTextFontName{
    
    if (detailFontName == nil) {
        detailFontName = @"Helvetica";
    }
    return detailFontName;
}

@end
