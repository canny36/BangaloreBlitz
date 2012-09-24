//
//  ExhibitorsTableCell.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 24/05/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "ExhibitorsTableCell.h"
#import "ExhibitorsViewController.h"

@implementation ExhibitorsTableCell
@synthesize nameLabel;
@synthesize locationTxtView;
@synthesize roomTxtView;
@synthesize exhibitorsImageView;
@synthesize activityIndicator;
@synthesize evc;
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
        
        
        exhibitorsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 10, 110, 60)];
//        exhibitorsImageView.layer.cornerRadius = 7.0;
//        exhibitorsImageView.layer.masksToBounds = YES;
//        exhibitorsImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        exhibitorsImageView.contentMode = UIViewContentModeScaleAspectFit;
//        exhibitorsImageView.layer.borderWidth = 0.5;
        
        [self addSubview:exhibitorsImageView];
        
         nameLabel = [[UITextView alloc] initWithFrame:CGRectMake(120, 5, 170, 60)];
        nameLabel.editable = NO;
        nameLabel.userInteractionEnabled = NO;
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.frame = CGRectMake(40, 15, 20, 20);
        [activityIndicator startAnimating];
        [exhibitorsImageView addSubview:activityIndicator];
        
        
        
        locationTxtView = [[UILabel alloc] initWithFrame:CGRectMake(5, 70, 290, 40)];
        locationTxtView.numberOfLines = 2;
        locationTxtView.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *txtTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeaMap)];
        [locationTxtView addGestureRecognizer:txtTapGesture];
        locationTxtView.userInteractionEnabled = YES;
       
        [self addSubview:locationTxtView];
        

        roomTxtView = [[UILabel alloc] initWithFrame:CGRectMake(5, 105, 290, 40)];
        roomTxtView.numberOfLines = 2;

        roomTxtView.userInteractionEnabled = NO;
        roomTxtView.backgroundColor = [UIColor clearColor];
        [self addSubview:roomTxtView];

        
        
        
        
        
        
    }
    return self;
}

-(void)assignImage:(NSString *)path
{
 //   NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
     @autoreleasepool {
    NSURL *url=[NSURL URLWithString:path];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    if(img)
    {
        exhibitorsImageView.image = img;
    }
    else
    {
        exhibitorsImageView.image = [UIImage imageNamed:@"NoImage.png"];
    }
    [activityIndicator stopAnimating];
     }
//    [pool release];
}

-(void)makeaMap
{
    [evc makeaMap:locationTxtView.tag];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
//    [super dealloc];
}

@end
