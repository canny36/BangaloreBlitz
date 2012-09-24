//
//  FunFactsTableViewCell.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 16/07/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "FunFactsTableViewCell.h"
#import "FunFactsViewController.h"
@implementation FunFactsTableViewCell
@synthesize descriptionTextView;
@synthesize funFactsImageView;
@synthesize activityIndicator;
@synthesize ffvc;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
       
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
        
        descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(100, 5, 180, 70)];
        descriptionTextView.editable = NO;
        descriptionTextView.userInteractionEnabled = YES;
        descriptionTextView.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *txtTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeaMap)];
        [descriptionTextView addGestureRecognizer:txtTapGesture];
        [self addSubview:descriptionTextView];


        
        funFactsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 10, 80, 60)];
        funFactsImageView.layer.cornerRadius = 7.0;
        funFactsImageView.userInteractionEnabled = YES;
        funFactsImageView.layer.masksToBounds = YES;
        funFactsImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        funFactsImageView.contentMode = UIViewContentModeScaleToFill;
        funFactsImageView.layer.borderWidth = 0.5;
        
        
        UITapGestureRecognizer *imgTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openWeb)];
        [funFactsImageView addGestureRecognizer:imgTapGesture];
        [self addSubview:funFactsImageView];

        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.frame = CGRectMake(30, 15, 20, 20);
        [activityIndicator startAnimating];
        [funFactsImageView addSubview:activityIndicator];


    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)openWeb
{
    [ffvc openWeb:funFactsImageView.tag ];

}
-(void)assignImage:(NSString *)path
{
     @autoreleasepool {
    NSURL *url=[NSURL URLWithString:path];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    if(img)
    {
        funFactsImageView.image = img;
    }
    else
    {
        funFactsImageView.image = [UIImage imageNamed:@"NoImage.png"];
    }
    [activityIndicator stopAnimating];
     }
}
-(void)makeaMap
{
    [ffvc makeaMap:descriptionTextView.tag];
}

@end
