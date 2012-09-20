//
//  SponsorsTableCell.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

@interface SponsorsTableCell : UITableViewCell 
{
    UIView *bgView;
    UIImageView *sponsersImageView;
    UILabel *sponserNameLabel;
    UILabel *sponserDetailsLabel;
    UILabel *sponserTypeLabel;
    UIActivityIndicatorView *activityIndicatorview;
}
@property(nonatomic,retain) UIImageView *sponsersImageView;
@property(nonatomic,retain) UILabel *sponserNameLabel;;
@property(nonatomic,retain) UILabel *sponserDetailsLabel;
@property(nonatomic,retain)UILabel *sponserTypeLabel;
@property(nonatomic,retain)UIActivityIndicatorView *activityIndicatorview;
-(void)assignImage:(NSString *)path;
@end
