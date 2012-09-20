//
//  PhotosTableViewCell.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 06/07/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
@interface PhotosTableViewCell : UITableViewCell
{
    UIView *bgView;
    UIImageView *PhotoImageView; 
    UILabel *nameLabel;
    UIActivityIndicatorView *activityIndicator;
 
}
@property(nonatomic,retain)UIImageView *PhotoImageView; 
@property(nonatomic,retain) UILabel *nameLabel;
@property(nonatomic,retain)UIActivityIndicatorView *activityIndicator;
-(void)assignImage:(NSString *)path;
@end
