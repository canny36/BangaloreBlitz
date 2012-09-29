//
//  AgendaTableViewCell.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 27/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "AgendaItem.h"
#import "CustomTableViewCell.h"

@class  AgendaViewController;

@interface AgendaTableViewCell : CustomTableViewCell
{
    AgendaViewController *_agendaViewController;

    UIButton *_selectButton;
    BOOL _buttonSelected;


}

@property(nonatomic,retain) UIButton *selectButton;
@property BOOL    buttonSelected;

@property(nonatomic,retain)AgendaViewController *agendaViewController;

-(void)cellWithAgendaItem:(AgendaItem*)item;
+(int)heightForItem:(AgendaItem*)item;

@end
