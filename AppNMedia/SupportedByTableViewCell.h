//
//  SupportedByTableViewCell.h
//  AppNMedia
//
//  Created by Srinivas on 11/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
@interface SupportedByTableViewCell : UITableViewCell
{
    UIView *bgView;
    UIImageView *supporterImageView;
    UILabel     *titleLabel;
    UIActivityIndicatorView *activityIndicator;

}
@property(nonatomic,retain)UIImageView *supporterImageView;
@property(nonatomic,retain)UILabel     *titleLabel;
@end
