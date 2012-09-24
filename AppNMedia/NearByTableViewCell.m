//
//  NearByTableViewCell.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 26/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "NearByTableViewCell.h"
#import "NearByDetailViewController.h"
#import "Util.h"

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
        nameLabel.font = [UIFont fontWithName:[Util subTitleFontName] size:15];
        nameLabel.textColor = [Util subTitleColor];
        [self addSubview:nameLabel];
        
                
        phoneNumber = [[UILabel alloc] initWithFrame:CGRectMake(110, 45, 200, 20)];
        phoneNumber.backgroundColor = [UIColor clearColor];
        phoneNumber.textAlignment = UITextAlignmentLeft;
        phoneNumber.userInteractionEnabled = YES;
        phoneNumber.font = [UIFont fontWithName:[Util detailTextFontName] size:15];
        phoneNumber.textColor = [Util detailTextColor];
        UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makePhoneCall)]     ;
        [phoneNumber addGestureRecognizer:tapGesture];
        [self addSubview:phoneNumber];
        
        addresstxtView = [[UILabel alloc] initWithFrame:CGRectMake(10, 60,250, 70)];
        addresstxtView.backgroundColor = [UIColor clearColor];
        addresstxtView.textAlignment = UITextAlignmentLeft;
        addresstxtView.numberOfLines = 3;
        addresstxtView.font = [UIFont fontWithName:[Util detailTextFontName] size:15];
        addresstxtView.textColor = [Util detailTextColor];
        addresstxtView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *txtTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeaMap)];
        [addresstxtView addGestureRecognizer:txtTapGesture];
        [self addSubview:addresstxtView];
        
        typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,110, 200, 20)];
        typeLabel.backgroundColor = [UIColor clearColor];
        typeLabel.font = [UIFont fontWithName:[Util detailTextFontName] size:15];
        typeLabel.textColor = [Util detailTextColor];
        typeLabel.textAlignment = UITextAlignmentLeft;
//        [self addSubview:typeLabel];

        locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,1, 100, 85)];
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


//-(void)layoutSubviews{
//    [super layoutSubviews];
//    CGRect frame =  self.imageView.frame;
//    frame.size.width = 95;
//    frame.size.height = 95;
//    self.imageView.frame = frame;
//    
//    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    
//    frame = self.textLabel.frame;
//    self.textLabel.numberOfLines = 4;
//    
//}

- (void)dealloc
{
}

@end
