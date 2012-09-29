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
                defaultImage = [UIImage imageNamed:@"default_img.png"];
                CGSize size = defaultImage.size;
                CGSize itemSize = CGSizeMake(size.width/2, size.height/2);
                UIGraphicsBeginImageContext(itemSize);
                CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
                [defaultImage drawInRect:imageRect];
                defaultImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                
                      
//            defaultImage = [UIImage imageNamed:@"list_over_image.png"];
        }
//        supporterImageView.backgroundColor = [UIColor colorWithPatternImage:defaultImage];
        supporterImageView.image = defaultImage;
        supporterImageView.contentMode = UIViewContentModeScaleAspectFit;
       

        
        [self addSubview:supporterImageView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 15, 180, 40)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.numberOfLines = 2;
        [self addSubview:titleLabel];
      

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
