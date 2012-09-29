//
//  ProgramCell.m
//  AppNMedia
//
//  Created by Srinivas on 17/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "ProgramCell.h"

@implementation ProgramCell

static UIImage *defaultImage;

@synthesize pimageView;
@synthesize titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        UIImage *image = [UIImage imageNamed:@"list_bg.png"];
        UIImageView *iView  = [[UIImageView alloc]initWithFrame:CGRectZero];
        iView.image = image;
        
        self.backgroundView = iView;
        
        image = [UIImage imageNamed:@"list_over_bg.png"];
        iView  = [[UIImageView alloc]initWithFrame:CGRectZero];
        iView.image = image;
        
        self.selectedBackgroundView = iView;
        
        self.backgroundColor = [UIColor clearColor];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(140,0,100, 80)];
        titleLabel.textAlignment = UITextAlignmentLeft;
        titleLabel.numberOfLines =3;
        [titleLabel setBackgroundColor:[UIColor  clearColor]];
    
        [self addSubview:titleLabel];
        
       pimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 75)];
//        //        supporterImageView.layer.cornerRadius = 7.0;
        if (defaultImage == nil) {
            defaultImage = [UIImage imageNamed:@"default_img.png"];
            CGSize size = defaultImage.size;
            CGSize itemSize = CGSizeMake(size.width/2, size.height/2);
            UIGraphicsBeginImageContext(itemSize);
            CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
            [defaultImage drawInRect:imageRect];
            defaultImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
        }
//        imageView.backgroundColor = [UIColor  colorWithPatternImage:defaultImage];
          pimageView.contentMode = UIViewContentModeScaleAspectFit;
        pimageView.image = defaultImage;
        
        [self addSubview:pimageView];

        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
