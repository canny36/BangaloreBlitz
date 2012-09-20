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
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 77)];
        [bgView.layer setCornerRadius:10.0f];
        bgView.backgroundColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.5];;
        [bgView.layer setBorderWidth:0.1f];
        [self addSubview:bgView];
        
        self.backgroundColor = [UIColor clearColor];
        speakerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 70, 65)];
        speakerImageView.layer.cornerRadius = 7.0;
        speakerImageView.layer.masksToBounds = YES;
        speakerImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        speakerImageView.layer.borderWidth = 0.5;
        speakerImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:speakerImageView];
        
        speakerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 180, 60)];
        speakerNameLabel.numberOfLines = 3;
        speakerNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:speakerNameLabel];
        
        
        
               
        speakersDetailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, 190, 20)];
        speakersDetailsLabel.backgroundColor = [UIColor clearColor];
        //[self addSubview:speakersDetailsLabel];
        
        
        selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectButton.frame = CGRectMake(265, 10, 30, 30);
        [selectButton setImage:[UIImage imageNamed:@"gray_star.png"] forState:UIControlStateNormal];
        [selectButton addTarget:self action:@selector(selectButtonSetImage :) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectButton];
        
        activityIndicatorview = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicatorview.frame = CGRectMake(25, 20, 20, 20);
        [activityIndicatorview startAnimating];
        [speakerImageView addSubview:activityIndicatorview];
        
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
