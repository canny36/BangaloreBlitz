//
//  UIImage+scale.h
//  AppNMedia
//
//  Created by Srinivas on 18/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (scale)



-(UIImage*)scaleImageToSize:(CGSize)size;
-(UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSizeWithSameAspectRatio:(CGSize)targetSize;
- (UIImage *) scaleImage: (UIImage *)image scaleFactor:(float)scaleBy;

@end
