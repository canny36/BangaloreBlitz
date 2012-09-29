//
//  PartnersTableCell.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 24/05/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "PartnersTableCell.h"
#import "PartnersViewController.h"
#import "UIImage+scale.h"


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
     
        self.clipsToBounds = YES;
        
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
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(110,10, 180, 42)];
        nameLabel.numberOfLines = 2;
        nameLabel.backgroundColor =[UIColor clearColor];
        [self addSubview:nameLabel];
        
        phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 52, 170, 21)];
        phoneLabel.backgroundColor = [UIColor clearColor];
        phoneLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makePhoneCall)];
        [phoneLabel addGestureRecognizer:tapGesture];
        [self addSubview:phoneLabel];

        
        partnerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];

        if (defaultImage == nil) {
            defaultImage = [UIImage imageNamed:@"default_img.png"];
            defaultImage = [defaultImage scaleImageToSize:CGSizeMake( defaultImage.size.width, defaultImage.size.height)];
        }

//        partnerImageView.image = defaultImage;
        partnerImageView.contentMode = UIViewContentModeScaleAspectFit;
//
//        [self addSubview:partnerImageView];

        
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
   CGRect frame =  self.imageView.frame;
    frame = CGRectMake(0, 5, 100, 70);
    self.imageView.frame = frame;
    self.contentMode = UIViewContentModeScaleAspectFit;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

-(void)makePhoneCall 
{

}



- (void)dealloc
{

}

@end
