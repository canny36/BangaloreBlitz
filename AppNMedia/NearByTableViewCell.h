//
//  NearByTableViewCell.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 26/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
@class NearByDetailViewController;
@interface NearByTableViewCell : UITableViewCell 
{
    UIView *bgView;
    UILabel *nameLabel;
    UILabel *phoneNumber;
    UITextView *addresstxtView;
    UILabel *typeLabel;
    UIImageView *locationImageView;
    UIActivityIndicatorView *activityIndicator;
    NearByDetailViewController *nbdvController;
}
@property(nonatomic,retain)UILabel *nameLabel;
@property(nonatomic,retain)UILabel *phoneNumber;
@property(nonatomic,retain)UILabel *typeLabel;
@property(nonatomic,retain)UITextView *addresstxtView;
@property(nonatomic,retain)UIImageView *locationImageView;
@property(nonatomic,retain)UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain)NearByDetailViewController *nbdvController;
-(void)assignImage:(NSString *)path;
-(void)makeaMap;
-(void)photosViewClicked;
@end
