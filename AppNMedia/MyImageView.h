//
//  MyImageView.h
//  PhotoPager1
//
//  Created by Logic2 on 19/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyImageView : UIView<NSURLConnectionDataDelegate>{
    
    NSString *urlString;
    UIImageView *imageView;
    UIActivityIndicatorView *spinner;
    NSMutableData *imagedata;
    
}
- (id)initWithFrame:(CGRect)frame:(NSString*)urlString;

@property (retain, nonatomic) UIImageView *imageView; 
@end
