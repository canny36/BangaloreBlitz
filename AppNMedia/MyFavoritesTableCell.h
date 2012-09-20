//
//  MyFavoritesTableCell.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 08/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

@interface MyFavoritesTableCell : UITableViewCell 
{
     UIView *bgView;
     UILabel *timeLabel;
     UILabel *titleLabel;
     UILabel *byLabel;
     

}
@property(nonatomic,retain)UIView *bgView;
@property(nonatomic,retain)UILabel *timeLabel;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain)UILabel *byLabel;
@end
