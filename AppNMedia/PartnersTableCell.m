//
//  PartnersTableCell.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 24/05/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "PartnersTableCell.h"
#import "PartnersViewController.h"

@implementation PartnersTableCell
@synthesize phoneNoButton;
@synthesize nameLabel;
@synthesize partnerImageView;
@synthesize activityIndicator;
@synthesize pvController;
@synthesize phoneLabel;

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
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 3, 180, 50)];
        nameLabel.numberOfLines = 3;
        nameLabel.backgroundColor =[UIColor clearColor];
        [self addSubview:nameLabel];
        
               
        
        phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 62, 170, 20)];
        phoneLabel.backgroundColor = [UIColor clearColor];
        phoneLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makePhoneCall)];
        [phoneLabel addGestureRecognizer:tapGesture];
        [self addSubview:phoneLabel];
        
        
//        partnerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 10, 100, 80)];
        
        partnerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 100, 100)];
        //        supporterImageView.layer.cornerRadius = 7.0;
        if (defaultImage == nil) {
            defaultImage = [UIImage imageNamed:@"list_over_image.png"];
        }
       partnerImageView.backgroundColor = [UIColor colorWithPatternImage:defaultImage];
        partnerImageView.image = image;
        partnerImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        
//        partnerImageView.layer.cornerRadius = 7.0;
//        partnerImageView.layer.masksToBounds = YES;
//        partnerImageView.layer.borderColor = [UIColor whiteColor].CGColor;
//        partnerImageView.contentMode = UIViewContentModeScaleAspectFill;
//        partnerImageView.layer.borderWidth = 0.5;
        
        [self addSubview:partnerImageView];
        
//        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        activityIndicator.frame = CGRectMake(40, 30, 20, 20);
//        [activityIndicator startAnimating];
//        [partnerImageView addSubview:activityIndicator];
        
        
    }
    return self;
}
-(void)assignImage:(NSString *)path
{
//    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
     @autoreleasepool {
    NSURL *url=[NSURL URLWithString:path];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    if(img)
    {
        partnerImageView.image = img;
    }
    else
    {
        partnerImageView.image = [UIImage imageNamed:@"NoImage.png"];
    }
    
    [activityIndicator stopAnimating];
//    [pool release];
     }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)makePhoneCall 
{
    int k = phoneLabel.tag;
    [pvController makePhoneCall:k];
}



- (void)dealloc
{
//    [super dealloc];
}

@end
