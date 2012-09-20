//
//  AgendaTableViewCell.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 27/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
@class  AgendaViewController;
@interface AgendaTableViewCell : UITableViewCell
{
    AgendaViewController *agendaViewController;
    UIView *bgView;
    UILabel *agendaNameLabel;
    UILabel *agendaDetailsLabel;
    UILabel *byLabel;
    UIButton    *selectButton;
    BOOL         buttonSelected;
    int         selectedSection;

}
@property(nonatomic,retain)UILabel *agendaNameLabel;
@property(nonatomic,retain)UILabel *byLabel;
@property(nonatomic,retain)UILabel *agendaDetailsLabel;
@property(nonatomic,retain)UIButton    *selectButton;
@property BOOL    buttonSelected;
@property   int   selectedSection;
@property(nonatomic,retain)AgendaViewController *agendaViewController;
-(void)selectButtonSetImage:(UIButton *)sender;

@end
