//
//  SupportedByTableViewCell.m
//  AppNMedia
//
//  Created by Srinivas on 11/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "SupportedByTableViewCell.h"

@implementation SupportedByTableViewCell
@synthesize supporterImageView;
@synthesize titleLabel;

static UIImage *backgroundImage;
static UIImage *selectorImage;
static UIImage *defaultImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        

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
        
        supporterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 100, 80)];
//        supporterImageView.layer.cornerRadius = 7.0;
        if (defaultImage == nil) {
            defaultImage = [UIImage imageNamed:@"list_over_image.png"];
        }
        supporterImageView.backgroundColor = [UIColor colorWithPatternImage:defaultImage];
        supporterImageView.image = image;
        supporterImageView.contentMode = UIViewContentModeScaleAspectFit;
       
//        
//        UIImage *sImage = [UIImage imageNamed:@"image_rounder.jpg"];
//        
//        UIEdgeInsets insets = UIEdgeInsetsZero;
//        insets.left = sImage.size.width/2 -1;
//        insets.right = sImage.size.width/2;
//        insets.top = sImage.size.height/2-1;
//        insets.bottom = sImage.size.height/2 ;
//        
//        sImage =[sImage resizableImageWithCapInsets:insets];
        
//        sImage = [sImage stretchableImageWithLeftCapWidth:sImage.size.width/2 topCapHeight:sImage.size.height/2];
        
//        imageView  = [[UIImageView alloc]initWithFrame:CGRectZero];
//        imageView.image = sImage;
//        
//        self.backgroundView = imageView;
        
//        [sImage resizableImageWithCapInsets:edgeInsets];
//            #if __IPHONE_OS_VERSION_MAX_ALLOWED > 50000 // __IPHONE_4_0
//                NSLog( @"After Version 4.0" );
//            #else
//                NSLog( @"Version 4.0 or earlier" );
//            #endif
        
        [self addSubview:supporterImageView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 15, 180, 40)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.numberOfLines = 2;
        [self addSubview:titleLabel];
        
        
//        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        activityIndicator.frame = CGRectMake(40, 15, 20, 20);
//        [activityIndicator startAnimating];
//        [supporterImageView addSubview:activityIndicator];

        

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
