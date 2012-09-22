//
//  SpeakersTableViewCell.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "SpeakersTableViewCell.h"
#import "SpeakersViewController.h"

@implementation SpeakersTableViewCell
@synthesize speakerImageView;
@synthesize speakerNameLabel;
@synthesize speakersDetailsLabel;
@synthesize selectButton;
@synthesize buttonSelected;
@synthesize activityIndicatorview;
@synthesize speakerViewController;
@synthesize fromSearchTable;

static UIImage *defaultImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        // Initialization code

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
        speakerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 70, 65)];

        speakerImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:speakerImageView];
        
        speakerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100
                                                                     , 0, 180, 60)];
        speakerNameLabel.numberOfLines = 3;
        speakerNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:speakerNameLabel];
                 
        speakersDetailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 190, 20)];
        speakersDetailsLabel.backgroundColor = [UIColor clearColor];
        //[self addSubview:speakersDetailsLabel];
           
        selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectButton.frame = CGRectMake(265, 20, 30, 30);
        [selectButton setImage:[UIImage imageNamed:@"gray_star.png"] forState:UIControlStateNormal];
        [selectButton addTarget:self action:@selector(selectButtonSetImage :) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectButton];
        
//        activityIndicatorview = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        activityIndicatorview.frame = CGRectMake(25, 20, 20, 20);
//        [activityIndicatorview startAnimating];
//        [speakerImageView addSubview:activityIndicatorview];
        
    }
    return self;
}

-(void)loadDefaultImage{
    
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
    
    speakerImageView.contentMode = UIViewContentModeScaleToFill;
    speakerImageView.image = defaultImage;
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
        speakerImageView.image = img;
        }
        else
        {
         speakerImageView.image = [UIImage imageNamed:@"NoImage.png"];
        }
    [activityIndicatorview stopAnimating];
     }
}
-(void)selectButtonSetImage:(UIButton *)sender
{
    
    
    if (buttonSelected == NO)
    {
        buttonSelected = YES;
        [selectButton setImage:[UIImage imageNamed:@"gold_star.png"] forState:UIControlStateNormal];
        [speakerViewController addOrDeleteFromMyFavorites:sender.tag checkMark:buttonSelected fromSearchTable:fromSearchTable];
    }
    else
    {
        buttonSelected = NO;
        [selectButton setImage:[UIImage imageNamed:@"gray_star.png"] forState:UIControlStateNormal];
        [speakerViewController addOrDeleteFromMyFavorites:sender.tag checkMark:buttonSelected fromSearchTable:fromSearchTable];


    }
    //NSLog(@"%d",sender.tag);
    
}

- (void)dealloc
{
    
    
}

@end
