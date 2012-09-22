//
//  UIImage+scale.m
//  AppNMedia
//
//  Created by Srinivas on 18/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "UIImage+scale.h"

@implementation UIImage (scale)

-(UIImage*)scaleImageToSize:(CGSize)size{
    UIImage *scaledImage  = nil;
    
    CGSize itemSize = CGSizeMake(size.width, size.height);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [self drawInRect:imageRect];
    scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
   }

@end
