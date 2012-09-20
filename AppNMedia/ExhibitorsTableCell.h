//
//  ExhibitorsTableCell.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 24/05/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
@class ExhibitorsViewController;
@interface ExhibitorsTableCell : UITableViewCell 
{
    UIView *bgView;
    UITextView *nameLabel;
    UILabel *locationTxtView;
    
    UILabel *roomTxtView;
    UIImageView *exhibitorsImageView;
    UIActivityIndicatorView *activityIndicator;
    
    
    ExhibitorsViewController *evc;
}
@property(nonatomic,retain)UITextView *nameLabel;
@property(nonatomic,retain)UILabel *locationTxtView;
@property(nonatomic,retain)UILabel *roomTxtView;
@property(nonatomic,retain) UIImageView *exhibitorsImageView;;
@property(nonatomic,retain)UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) ExhibitorsViewController *evc;
-(void)assignImage:(NSString *)path;
-(void)makeaMap;
@end
