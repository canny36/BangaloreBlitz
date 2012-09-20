//
//  PhotosTableViewCell.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 06/07/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "PhotosTableViewCell.h"

@implementation PhotosTableViewCell
@synthesize PhotoImageView;
@synthesize nameLabel;
@synthesize activityIndicator;
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
        
        self.backgroundColor = [UIColor clearColor];
        
        PhotoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 10, 100, 80)];
        PhotoImageView.layer.cornerRadius = 7.0;
        PhotoImageView.userInteractionEnabled =YES;
        PhotoImageView.layer.masksToBounds = YES;
        PhotoImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        PhotoImageView.contentMode = UIViewContentModeScaleAspectFill;
        PhotoImageView.layer.borderWidth = 0.5;
        
        [self addSubview:PhotoImageView];        
        
              
        nameLabel  = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, 150, 80)];
        nameLabel.numberOfLines  =5;
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.frame = CGRectMake(40, 25, 20, 20);
        [activityIndicator startAnimating];
        [PhotoImageView addSubview:activityIndicator];
        
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)assignImage:(NSString *)path
{
     @autoreleasepool {
    NSURL *url=[NSURL URLWithString:path];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    if(img)
    {
        PhotoImageView.image = img;
    }
    else
    {
        PhotoImageView.image = [UIImage imageNamed:@"NoImage.png"];
    }
    [activityIndicator stopAnimating];
     }
}



@end
