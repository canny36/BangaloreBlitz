//
//  LinksTableCell.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

@interface LinksTableCell : UITableViewCell 
{
    UIView *bgView;
    UIImageView *linksImageView;
    UITextView *linkNameLabel;
    UILabel *linkUrlLabel;
    UIActivityIndicatorView *activityIndicator;
}
@property(nonatomic,retain)UITextView *linkNameLabel;
@property(nonatomic,retain)UILabel *linkUrlLabel;
@property(nonatomic,retain)UIImageView *linksImageView;
@property(nonatomic,retain)UIActivityIndicatorView *activityIndicator;

-(void)assignImage:(NSString *)path;

@end
