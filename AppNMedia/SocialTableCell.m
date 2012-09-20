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
        
        
        socilImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 10, 100, 60)];
        socilImageView.layer.cornerRadius = 7.0;
        socilImageView.layer.masksToBounds = YES;
        socilImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        socilImageView.contentMode = UIViewContentModeScaleAspectFill;
        socilImageView.layer.borderWidth = 0.5;
        
        [self addSubview:socilImageView];

        
        
        socialNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 170, 40)];
        socialNameLabel.backgroundColor = [UIColor clearColor];
        socialNameLabel.numberOfLines =2;
        [self addSubview:socialNameLabel];
        
        socialUrlTxtView = [[UITextView alloc] initWithFrame:CGRectMake(115, 25, 170, 40)];
        socialUrlTxtView.editable = NO;
        socialUrlTxtView.userInteractionEnabled = NO;
        socialUrlTxtView.backgroundColor = [UIColor clearColor];
        [self addSubview:socialUrlTxtView];
        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.frame = CGRectMake(40, 15, 20, 20);
        [activityIndicator startAnimating];
        [socilImageView addSubview:activityIndicator];
        

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
        socilImageView.image = img;
    }
    else
    {
        socilImageView.image = [UIImage imageNamed:@"NoImage.png"];
    }
    [activityIndicator stopAnimating];
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
