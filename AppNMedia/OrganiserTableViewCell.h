//
//  OrganiserTableViewCell.h
//  AppNMedia
//
//  Created by Srinivas on 11/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
@interface OrganiserTableViewCell : UITableViewCell
{
    UIImageView *organiserImageView;
    UILabel     *titleLabel;
    UILabel     *descriptionLabel;
     UIActivityIndicatorView *activityIndicator;
}
@property(nonatomic,retain)UIImageView *organiserImageView;
@property(nonatomic,retain)UILabel     *titleLabel;
@property(nonatomic,retain)UILabel     *descriptionLabel;

@end
