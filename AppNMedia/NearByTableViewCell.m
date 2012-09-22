//
//  NearByTableViewCell.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 26/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "NearByTableViewCell.h"
#import "NearByDetailViewController.h"

@implementation NearByTableViewCell

@synthesize nameLabel;
@synthesize phoneNumber;
@synthesize addresstxtView;
@synthesize locationImageView;
@synthesize typeLabel;
@synthesize activityIndicator;
@synthesize nbdvController;

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
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, 200, 45)];
        nameLabel.numberOfLines =2;
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textAlignment = UITextAlignmentLeft;
        [self addSubview:nameLabel];
        
                
        phoneNumber = [[UILabel alloc] initWithFrame:CGRectMake(110, 45, 200, 20)];
        phoneNumber.backgroundColor = [UIColor clearColor];
        phoneNumber.textAlignment = UITextAlignmentLeft;
        phoneNumber.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makePhoneCall)]     ;
        [phoneNumber addGestureRecognizer:tapGesture];
        [self addSubview:phoneNumber];
        
        addresstxtView = [[UITextView alloc] initWithFrame:CGRectMake(100, 60, 190, 45)];
        addresstxtView.backgroundColor = [UIColor clearColor];
        addresstxtView.textAlignment = UITextAlignmentLeft;
        addresstxtView.editable = NO;
        addresstxtView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *txtTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeaMap)];
        [addresstxtView addGestureRecognizer:txtTapGesture];
        [self addSubview:addresstxtView];
        
        typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 95, 200, 20)];
        typeLabel.backgroundColor = [UIColor clearColor];
        typeLabel.textAlignment = UITextAlignmentLeft;
        [self addSubview:typeLabel];
        
        
        
        
        locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 95, 95)];
        locationImageView.contentMode = UIViewContentModeScaleAspectFit;

        
        UITapGestureRecognizer *tapGesture1 =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photosViewClicked)]     ;
        [locationImageView addGestureRecognizer:tapGesture1];
        [self addSubview:locationImageView];
        
//        
//        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        activityIndicator.frame = CGRectMake(40, 35, 20, 20);
//        [activityIndicator startAnimating];
//        [locationImageView addSubview:activityIndicator];
        
    }
    return self;
}


-(void)makeaMap
{
    [nbdvController makeaMap:addresstxtView.tag];
}

-(void)assignImage:(NSString *)path
{
     @autoreleasepool {
    NSURL *url=[NSURL URLWithString:path];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    if(img)
    {
        locationImageView.image = img;
    }
    else
    {
        locationImageView.image = [UIImage imageNamed:@"NoImage.png"];
    }
    [activityIndicator stopAnimating];
     }
}
-(void)photosViewClicked;
{
    [nbdvController photosViewClicked:locationImageView.tag];
}
-(void)makePhoneCall 
{
    int k = phoneNumber.tag;

    [nbdvController makePhoneCall:k];
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
