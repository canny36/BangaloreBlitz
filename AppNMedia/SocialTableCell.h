//
//  SocialTableCell.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 01/05/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

@interface SocialTableCell : UITableViewCell 
{
    UIView *bgView;
    UILabel *socialNameLabel;
    UITextView *socialUrlTxtView;
    UIImageView *socilImageView;
    UIActivityIndicatorView *activityIndicator;
}
@property(nonatomic,retain)UILabel *socialNameLabel;
@property(nonatomic,retain)UITextView *socialUrlTxtView;
@property(nonatomic,retain)UIImageView *socilImageView;
@property(nonatomic,retain)UIActivityIndicatorView *activityIndicator;
-(void)assignImage:(NSString *)path;
@end
