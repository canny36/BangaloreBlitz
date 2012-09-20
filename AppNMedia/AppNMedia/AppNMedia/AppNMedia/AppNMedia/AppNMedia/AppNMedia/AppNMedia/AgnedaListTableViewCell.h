//
//  AgnedaListTableViewCell.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 12/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

@interface AgnedaListTableViewCell : UITableViewCell 
{
      UIView *bgView;
    UITextView *agendaNameTxtView;
}
@property(nonatomic,retain)UITextView *agendaNameTxtView;
@end
