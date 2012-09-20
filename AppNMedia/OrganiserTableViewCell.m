//
//  OrganiserTableViewCell.m
//  AppNMedia
//
//  Created by Srinivas on 11/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "OrganiserTableViewCell.h"
#import "Util.h"

@implementation OrganiserTableViewCell

@synthesize organiserImageView;
@synthesize titleLabel;
@synthesize descriptionLabel;

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
        imageView  = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.image = image;
        
        self.selectedBackgroundView = imageView;
        
        organiserImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
//        organiserImageView.layer.cornerRadius = 7.0;
//        organiserImageView.layer.masksToBounds = YES;
//        organiserImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        organiserImageView.contentMode = UIViewContentModeScaleAspectFit;
//        organiserImageView.layer.borderWidth = 0.5;
        
        if (defaultImage == nil) {
            defaultImage = [UIImage imageNamed:@"list_over_image.png"];
        }
        organiserImageView.backgroundColor = [UIColor colorWithPatternImage:defaultImage];
        organiserImageView.image = image;
        organiserImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        
        [self addSubview:organiserImageView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, 185, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [Util subTitleColor];
        [self addSubview:titleLabel];
        
        descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 30, 185, 50)];
        descriptionLabel.numberOfLines = 5;
        descriptionLabel.backgroundColor = [UIColor clearColor];
        descriptionLabel.textColor = [Util detailTextColor];
        
        [self addSubview:descriptionLabel];
//        
//        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        activityIndicator.frame = CGRectMake(40, 15, 20, 20);
//        [activityIndicator startAnimating];
//        [organiserImageView addSubview:activityIndicator];
        
    }
    
    return self;
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
