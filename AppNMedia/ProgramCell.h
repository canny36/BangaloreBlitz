//
//  ProgramCell.h
//  AppNMedia
//
//  Created by Srinivas on 17/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgramCell : UITableViewCell{
    
    UILabel *titleLabel;
    UIImageView *pimageView;
}

@property(nonatomic,readonly) UILabel *titleLabel;
@property(nonatomic,readonly) UIImageView *pimageView;

@end
