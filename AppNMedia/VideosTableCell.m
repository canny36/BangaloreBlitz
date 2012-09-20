//
//  VideosTableCell.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "VideosTableCell.h"


@implementation VideosTableCell
@synthesize titleTxtView;
@synthesize subTitleLabel;
@synthesize webView;
@synthesize vedioUrl;
@synthesize vedioImageView;
@synthesize activityIndicator;
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
        
//        webView = [[UIWebView alloc] initWithFrame:CGRectMake(5, 10, 80, 50)];
//        webView.backgroundColor = [UIColor blackColor];
//        [self addSubview:webView];
//        
        

        titleTxtView  = [[UITextView alloc] initWithFrame:CGRectMake(100, 0, 180, 50)];
        titleTxtView.backgroundColor = [UIColor clearColor];
        titleTxtView.editable = NO;
        titleTxtView.userInteractionEnabled = NO;
        [self addSubview:titleTxtView];
        
        subTitleLabel  = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 150, 20)];
        subTitleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:subTitleLabel];
      
        vedioImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 80, 50)];
        vedioImageView.layer.cornerRadius = 7.0;
        vedioImageView.layer.masksToBounds = YES;
        vedioImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        vedioImageView.contentMode = UIViewContentModeScaleToFill;
        vedioImageView.layer.borderWidth = 0.5;
        
        [self addSubview:vedioImageView];

        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicator.frame = CGRectMake(20, 10, 20, 20);
        [activityIndicator startAnimating];
        [vedioImageView addSubview:activityIndicator];


        
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
    NSURL *url=[NSURL URLWithString:path];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    if(img)
    {
        vedioImageView.image = img;
    }
    else
    {
        vedioImageView.image = [UIImage imageNamed:@"NoImage.png"];
    }
    [activityIndicator stopAnimating];
}




-(void)loadWebView:(NSURL *)vedioUrl
{
    [self performSelector:@selector(loadWebViewOnBackGround) withObject:nil];
}

-(void)loadWebViewOnBackGround
{
    //NSLog(@"vedio url = %@",vedioUrl);
    [webView loadRequest:[NSURLRequest requestWithURL:vedioUrl]];
}

- (void)dealloc
{
}

@end
