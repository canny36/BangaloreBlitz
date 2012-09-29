//
//  CustomTableViewCell.h
//  BangaloreItBiz
//
//  Created by Srinivas on 29/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell{
    
    id _favTarget;
    UIButton *favButton;
   
}

@property(nonatomic,retain)id favTarget;

-(void)setDefaultImage:(UIImage*)image;
-(UIImage*)goldImage;
-(UIImage*)grayImage;

-(void)selectFavorite:(BOOL)select;
-(void)enableBookmarkWithTarget:(id)target;
-(void)setDefaultImage:(UIImage*)image;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier hideImageView:(BOOL)hide;
+(UIFont*)titleFont;
+(UIFont*)detailFont;

@end
