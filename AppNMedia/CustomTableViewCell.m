//
//  CustomTableViewCell.m
//  BangaloreItBiz
//
//  Created by Srinivas on 29/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "CannyViewController.h"
#import "Util.h"

#define FONT_SIZE_TITLE 15
#define FONT_SIZE_DETAIL 13

@implementation CustomTableViewCell

static UIImage *defaultImage;
static UIImage *goldImage;
static UIImage *grayImage;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier hideImageView:(BOOL)hide{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.imageView.hidden = hide;
        [self setClipsToBounds:YES];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        self.textLabel.font= [UIFont fontWithName:[Util subTitleFontName] size:FONT_SIZE_TITLE];
        self.textLabel.textColor = [Util subTitleColor];
        self.textLabel.contentMode = UILineBreakModeWordWrap;
        self.detailTextLabel.font = [UIFont fontWithName:[Util detailTextFontName] size:FONT_SIZE_DETAIL];
        
        self.detailTextLabel.textColor = [Util detailTextColor];
        
        if (goldImage == nil) {
            goldImage =  [UIImage imageNamed:@"gold_star.png"];
        }
        
        if (grayImage == nil) {
            grayImage =  [UIImage imageNamed:@"gray_star.png"];
        }
        
        UIImage *image = [UIImage imageNamed:@"list_bg.png"];
        UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.image = image;
        
        self.backgroundView = imageView;
        
        image = [UIImage imageNamed:@"list_over_bg.png"];
        imageView  = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.image = image;
        
        self.selectedBackgroundView = imageView;
        self.backgroundColor = [UIColor clearColor];
        
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
        
        favButton = [UIButton buttonWithType:UIButtonTypeCustom];
        favButton.frame = CGRectMake(280, 20, 25, 25);
        [favButton setImage:[self grayImage] forState:UIControlStateNormal];
        
        
        [favButton addTarget:self action:@selector(selectButtonSetImage :) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setClipsToBounds:YES];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        self.textLabel.font= [UIFont fontWithName:[Util subTitleFontName] size:15];
        self.textLabel.textColor = [Util subTitleColor];
        self.textLabel.contentMode = UILineBreakModeWordWrap;
        self.detailTextLabel.font = [UIFont fontWithName:[Util detailTextFontName] size:13];
        
        self.detailTextLabel.textColor = [Util detailTextColor];
        
        if (goldImage == nil) {
            goldImage =  [UIImage imageNamed:@"gold_star.png"];
        }
        
        if (grayImage == nil) {
            grayImage =  [UIImage imageNamed:@"gray_star.png"];
        }
        
        UIImage *image = [UIImage imageNamed:@"list_bg.png"];
        UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.image = image;
        
        self.backgroundView = imageView;
        
        image = [UIImage imageNamed:@"list_over_bg.png"];
        imageView  = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.image = image;
        
        self.selectedBackgroundView = imageView;
        self.backgroundColor = [UIColor clearColor];
               
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
        
        favButton = [UIButton buttonWithType:UIButtonTypeCustom];
        favButton.frame = CGRectMake(280, 20, 25, 25);
        [favButton setImage:[self grayImage] forState:UIControlStateNormal];
        
        
        [favButton addTarget:self action:@selector(selectButtonSetImage :) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(UIImage*)goldImage{
    return goldImage;
}

-(UIImage*)grayImage{
    return grayImage;
}

-(void)enableBookmarkWithTarget:(id)target{
    self.favTarget = target;
    [self setAccessoryView:favButton];
}

-(void)selectFavorite:(BOOL)select{
    [favButton setImage: select ? goldImage : grayImage forState:UIControlStateNormal];
}


-(void)selectButtonSetImage:(UIButton*)sender
{
    favButton.selected = !favButton.selected;
    [favButton setImage: favButton.selected ? goldImage : grayImage forState:UIControlStateNormal];
  
        if ([self.favTarget isKindOfClass:[CannyViewController class]]) {
            CannyViewController *controller = self.favTarget;
            [controller onFavoriteSelection:sender];
        }
 }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)setDefaultImage:(UIImage*)image{
    
    if (self.imageView.hidden == NO) {
        self.imageView.image = image == nil ? defaultImage : image;
    }
}

-(void)layoutSubviews{
    
    [super layoutSubviews];

    if (self.imageView.hidden == YES) {
        return;
    }
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    CGRect frame = self.imageView.frame;
    frame.size.width = 100;
    frame.origin.x = 2;
    [self.imageView setFrame:frame];
    
    frame = self.textLabel.frame;
    frame.origin.x = 105;
    frame.size.width = 175;
    [self.textLabel setFrame:frame];
    
    frame = self.detailTextLabel.frame;
    frame.origin.x = 105;
      frame.size.width =175;
    [self.detailTextLabel setFrame:frame];
       
    if (self.accessoryView != nil) {
        frame  = self.accessoryView.frame;
        frame.origin.x = 280;
        self.accessoryView.frame = frame;
        NSLog(@" ACCESSORY FRAME w = %f x =  %f ", frame.size.width,frame.origin.x);
    }
    
      
    
}

+(UIFont*)titleFont{
    return  [UIFont fontWithName:[Util subTitleFontName] size:FONT_SIZE_TITLE];
 }

+(UIFont*)detailFont{
    return [UIFont fontWithName:[Util detailTextFontName] size:FONT_SIZE_DETAIL];
}

@end
