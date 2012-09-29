//
//  SpeakersTableViewCell.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "SpeakersTableViewCell.h"
#import "SpeakersViewController.h"
#import "UIImage+scale.h"

@implementation SpeakersTableViewCell


static UIImage *defaultImage;
static UIImage *greyImage;
static UIImage *goldImage;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {

        
        if (defaultImage == nil) {
            defaultImage = [UIImage imageNamed:@"no_image.png"];
            CGSize size = defaultImage.size;
            CGSize itemSize = CGSizeMake(size.width/2, size.height/2);
            UIGraphicsBeginImageContext(itemSize);
            CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
            [defaultImage drawInRect:imageRect];
            defaultImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
        }

       
        if (goldImage == nil) {
            goldImage =  [UIImage imageNamed:@"gold_star.png"];
        }
       
        if (greyImage == nil) {
            greyImage =  [UIImage imageNamed:@"gray_star.png"];
        }

        
        self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.selectButton.frame = CGRectMake(275 , 10,
                                        25, 25);
        [self.selectButton setImage:greyImage forState:UIControlStateNormal];
        [self.selectButton addTarget:self action:@selector(selectButtonSetImage :) forControlEvents:UIControlEventTouchUpInside];
       
        self.accessoryView = self.selectButton;
        
        [self setDefaultImage:defaultImage];
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    
}


-(void)selectButtonSetImage:(UIButton*)sender
{
    self.selectButton.selected = !self.selectButton.selected;
    self.buttonSelected = self.selectButton.selected;
    [self.selectButton setImage: self.selectButton.selected ? goldImage : greyImage forState:UIControlStateNormal];
    [self.speakerViewController onBookmarkButtonClick:sender];
    
}

- (void)dealloc
{
    
    
}

@end
