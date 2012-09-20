//
//  NewsTableCell.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

@interface NewsTableCell : UITableViewCell 
{
    UIView *bgView;
    UIImageView *newsImageView; 
    UILabel *titleLabel;
    UILabel *descriptionTextView;
    UIActivityIndicatorView *activityIndicator;
}
@property(nonatomic,retain)UIImageView *newsImageView;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *descriptionTextView;
@property(nonatomic,retain)UIActivityIndicatorView *activityIndicator;
-(void)assignImage:(NSString *)path;
@end
