//
//  SocialTableCell.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 01/05/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "SocialTableCell.h"


@implementation SocialTableCell
@synthesize socialNameLabel;
@synthesize socialUrlTxtView;
@synthesize socilImageView;
@synthesize activityIndicator;

static UIImage *defaultImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
       
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        UIImage *image = [UIImage imageNamed:@"list_bg.png"];
        UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.image = image;
        
        self.backgroundView = imageView;
        
        image = [UIImage imageNamed:@"list_over_bg.png"];
        imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.image = image;
        
        self.selectedBackgroundView = imageView;
        self.backgroundColor = [UIColor clearColor];

        if (defaultImage == nil) {
            defaultImage = [UIImage imageNamed:@"default_img.png"];
        }
        
        socilImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 10, 100, 60)];
        socilImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:socilImageView];
        socilImageView.image = defaultImage;

        socialNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 170, 40)];
        socialNameLabel.backgroundColor = [UIColor clearColor];
        socialNameLabel.numberOfLines =2;
        [self addSubview:socialNameLabel];
        
        socialUrlTxtView = [[UITextView alloc] initWithFrame:CGRectMake(115, 25, 170, 40)];
        socialUrlTxtView.editable = NO;
        socialUrlTxtView.userInteractionEnabled = NO;
        socialUrlTxtView.backgroundColor = [UIColor clearColor];
        [self addSubview:socialUrlTxtView];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (void)dealloc
{
}

@end
