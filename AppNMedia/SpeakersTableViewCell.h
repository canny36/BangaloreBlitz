//
//  SpeakersTableViewCell.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

@class SpeakersViewController;
@interface SpeakersTableViewCell : UITableViewCell
{
    SpeakersViewController *speakerViewController;
    UIView *bgView;
    UIImageView *speakerImageView;
    UILabel     *speakerNameLabel;
    UILabel     *speakersDetailsLabel;
    UIButton    *selectButton;
    BOOL         buttonSelected;
    UIActivityIndicatorView *activityIndicatorview;
    BOOL fromSearchTable;
    
}
@property(nonatomic,retain)SpeakersViewController *speakerViewController;
@property(nonatomic,retain)UIImageView *speakerImageView;
@property(nonatomic,retain) UILabel     *speakerNameLabel;
@property(nonatomic,retain) UILabel     *speakersDetailsLabel;
@property(nonatomic,retain)UIButton    *selectButton;
@property(nonatomic,retain)UIActivityIndicatorView *activityIndicatorview;
@property BOOL   buttonSelected;
@property BOOL   fromSearchTable;
-(void)assignImage:(NSString *)path;
-(void)selectButtonSetImage:(UIButton *)sender;
@end
