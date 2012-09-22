//
//  NewsTableCell.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "NewsTableCell.h"
#import "UIImage+scale.h"

@implementation NewsTableCell
@synthesize newsImageView;
@synthesize titleLabel;
@synthesize descriptionTextView;
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
        imageView  = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.image = image;
        
        self.selectedBackgroundView = imageView;
    
        self.backgroundColor = [UIColor clearColor];
    
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, 200, 30)];
        [titleLabel setBackgroundColor:[UIColor  clearColor]];
        [self addSubview:titleLabel];
        
        descriptionTextView = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 80)];
        descriptionTextView.numberOfLines = 3;
        descriptionTextView.backgroundColor = [UIColor clearColor];
        [self addSubview:descriptionTextView];
        
        
        
        newsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 90, 80)];
        //        supporterImageView.layer.cornerRadius = 7.0;
        if (defaultImage == nil) {
//            defaultImage = [UIImage imageNamed:@"list_over_image.png"];
            defaultImage = [UIImage imageNamed:@"default_img.png"];
            defaultImage = [defaultImage scaleImageToSize:CGSizeMake(defaultImage.size.width/2, defaultImage.size.height/2)];
            
        }
//        newsImageView.backgroundColor = [UIColor colorWithPatternImage:defaultImage];
        newsImageView.image = defaultImage;
        newsImageView.contentMode = UIViewContentModeScaleAspectFit;
       
        [self addSubview:newsImageView];
        
//        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        activityIndicator.frame = CGRectMake(40, 35, 20, 20);
//        [activityIndicator startAnimating];
//        [newsImageView addSubview:activityIndicator];
        

        
        
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
        newsImageView.image = img;
    }
    else
    {
        newsImageView.image = [UIImage imageNamed:@"NoImage.png"];
    }
    [activityIndicator stopAnimating];
     }
}



- (void)dealloc
{
    
}

@end
