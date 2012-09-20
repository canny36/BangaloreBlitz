//
//  PartnersTableCell.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 24/05/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

@class PartnersViewController;
@interface PartnersTableCell : UITableViewCell 
{
    UIView *bgView;
    UILabel *nameLabel;
    UILabel *phoneLabel;
    UIButton *phoneNoButton;
    UIImageView *partnerImageView;
    UIActivityIndicatorView *activityIndicator;
    
    PartnersViewController *pvController;
}
@property(nonatomic,retain) UIButton *phoneNoButton;;
@property(nonatomic,retain)UILabel *nameLabel;
@property(nonatomic,retain)UILabel *phoneLabel;
@property(nonatomic,retain)UIImageView *partnerImageView;
@property(nonatomic,retain)UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) PartnersViewController *pvController;
-(void)assignImage:(NSString *)path;
-(void)makePhoneCall ;
@end
