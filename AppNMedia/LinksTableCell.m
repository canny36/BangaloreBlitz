//
//  LinksTableCell.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "LinksTableCell.h"


@implementation LinksTableCell
@synthesize linkNameLabel;
@synthesize linkUrlLabel;
@synthesize linksImageView;
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
        
        linksImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1, 100, 100)];
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
        
        linksImageView.contentMode = UIViewContentModeScaleToFill ;
//      linksImageView.contentMode = UIViewContentModeScaleAspectFit ;
        linksImageView.image = defaultImage;
        

        
//        linksImageView.layer.cornerRadius = 7.0;
//        linksImageView.layer.masksToBounds = YES;
//        linksImageView.layer.borderColor = [UIColor whiteColor].CGColor;
//        linksImageView.contentMode = UIViewContentModeScaleAspectFill;
//        linksImageView.layer.borderWidth = 0.5;
        
        [self addSubview:linksImageView];

        

        linkNameLabel = [[UITextView alloc] initWithFrame:CGRectMake(120
, 20, 185, 50)];
        linkNameLabel.editable = NO;
        linkNameLabel.userInteractionEnabled = NO;
        linkNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:linkNameLabel];
        
        linkUrlLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 185, 20)];
        linkUrlLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:linkUrlLabel];
        
//        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        activityIndicator.frame = CGRectMake(40, 15, 20, 20);
//        [activityIndicator startAnimating];
//        [linksImageView addSubview:activityIndicator];
        
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
        linksImageView.image = img;
    }
    else
    {
        linksImageView.image = [UIImage imageNamed:@"NoImage.png"];
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
