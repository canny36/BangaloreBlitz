//
//  SubAgendaCell.m
//  BangaloreItBiz
//
//  Created by Srinivas on 28/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "SubAgendaCell.h"
#import "Agenda.h"
#import "AgendaLoc.h"

@implementation SubAgendaCell

static UIImage *goldImage;
static UIImage *grayImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
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
        
        
        selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectButton.frame = CGRectMake(265, 20, 30, 30);
        [selectButton setImage:[UIImage imageNamed:@"gray_star.png"] forState:UIControlStateNormal];
        
        
        [selectButton addTarget:self action:@selector(selectButtonSetImage :) forControlEvents:UIControlEventTouchUpInside];
        //        [self addSubview:selectButton];
        
        self.accessoryView= selectButton;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)selectButton:(BOOL)select{
    [selectButton setImage: select ? goldImage : grayImage forState:UIControlStateNormal];
}

-(void)selectButtonSetImage:(UIButton*)sender
{
    selectButton.selected = !selectButton.selected;
    [selectButton setImage: selectButton.selected ? goldImage : grayImage forState:UIControlStateNormal];
    [self.controller onBookmarkButtonClick:sender];
    
}






@end
