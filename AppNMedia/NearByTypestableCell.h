//
//  NearByTypestableCell.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 26/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

@interface NearByTypestableCell : UITableViewCell 
{
     UIView *bgView;
     UILabel *nameLabel;
    
}
@property(nonatomic,retain)UILabel *nameLabel;
@end
