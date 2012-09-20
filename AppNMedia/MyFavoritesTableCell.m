//
//  MyFavoritesTableCell.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 08/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "MyFavoritesTableCell.h"


@implementation MyFavoritesTableCell
@synthesize timeLabel;
@synthesize titleLabel;
@synthesize byLabel;
@synthesize bgView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        UIImage *image = [UIImage imageNamed:@"list_bg.png"];
        UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.image = image;
        
        self.backgroundView = imageView;
        
        image = [UIImage imageNamed:@"list_over_bg.png"];
        imageView  = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.image = image;
        
        self.selectedBackgroundView = imageView;
        
        
        self.backgroundColor = [UIColor clearColor];
        
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 280, 30)];
        timeLabel.numberOfLines =2;
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 280, 40)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.numberOfLines = 2;
        [self addSubview:titleLabel];
        
        
        byLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, 280, 40)];
        byLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:byLabel];
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    
}

@end
