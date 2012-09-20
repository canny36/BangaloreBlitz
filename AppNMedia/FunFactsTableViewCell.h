//
//  FunFactsTableViewCell.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 16/07/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
@class FunFactsViewController;
@interface FunFactsTableViewCell : UITableViewCell
{
    FunFactsViewController *ffvc;
    UIView *bgView;
    UITextView *descriptionTextView;
    UIImageView *funFactsImageView;
    UIActivityIndicatorView *activityIndicator;
}
@property(nonatomic,retain)UITextView *descriptionTextView;
@property(nonatomic,retain)UIImageView *funFactsImageView;
@property(nonatomic,retain)UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain)FunFactsViewController *ffvc;
-(void)openWeb;
@end
