//
//  SponsorsTableCell.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "SponsorsTableCell.h"


@implementation SponsorsTableCell
@synthesize sponsersImageView;
@synthesize sponserNameLabel;
@synthesize sponserDetailsLabel;
@synthesize sponserTypeLabel;
@synthesize activityIndicatorview;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UIImage *image = [UIImage imageNamed:@"list_bg.png"];
        UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.image = image;
        
        self.backgroundView = imageView;
        
       image = [UIImage imageNamed:@"list_over_bg.png"];
        imageView  = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.image = image;
        
        self.selectedBackgroundView = imageView;
        
        
//        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 77)];
//        [bgView.layer setCornerRadius:10.0f];
//        bgView.backgroundColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.5];;
//        [bgView.layer setBorderWidth:0.1f];
//        [self addSubview:bgView];
        self.backgroundColor = [UIColor clearColor];
        
        sponsersImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0 , 100, 80)];
//        sponsersImageView.layer.cornerRadius = 7.0;
//        sponsersImageView.layer.masksToBounds = YES;
//        sponsersImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        sponsersImageView.contentMode = UIViewContentModeScaleAspectFit;
//        sponsersImageView.layer.borderWidth = 0.5;
        
        [self addSubview:sponsersImageView];
        
        
                
        sponserNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, 180, 40)];
        sponserNameLabel.numberOfLines= 2;
        sponserNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:sponserNameLabel];
        
        
        sponserDetailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 35, 180, 20)];
        sponserDetailsLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:sponserDetailsLabel];
        
        sponserTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 40, 180, 20)];
        sponserTypeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:sponserTypeLabel];
        
//        activityIndicatorview = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        activityIndicatorview.frame = CGRectMake(40, 15, 20, 20);
//        [activityIndicatorview startAnimating];
//        [sponsersImageView addSubview:activityIndicatorview];
        
        
    }
    return self;
}


-(void)assignImage:(NSString *)path
{
     @autoreleasepool {
    NSURL *url=[NSURL URLWithString:path];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    if(img)
    {
        sponsersImageView.image = img;
    }
   else
    {
        sponsersImageView.image = [UIImage imageNamed:@"NoImage.png"];
    }
    [activityIndicatorview stopAnimating];
     }
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
