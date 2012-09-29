//
//  SpeakersTableViewCell.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "CustomTableViewCell.h"

@class SpeakersViewController;

@interface SpeakersTableViewCell : CustomTableViewCell
{
    SpeakersViewController *_speakerViewController;
    UIButton    *_selectButton;
    BOOL         _buttonSelected;
      
}
@property(nonatomic,retain)SpeakersViewController *speakerViewController;
@property(nonatomic,retain)UIButton  *selectButton;

@property BOOL   buttonSelected;

-(void)selectButton:(BOOL)select;
-(void)selectButtonSetImage:(UIButton *)sender;
-(void)loadDefaultImage;

@end
