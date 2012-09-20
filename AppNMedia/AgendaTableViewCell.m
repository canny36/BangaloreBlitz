//
//  AgendaTableViewCell.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 27/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "AgendaTableViewCell.h"
#import "AgendaViewController.h"

@implementation AgendaTableViewCell
@synthesize agendaNameLabel;
@synthesize agendaDetailsLabel;
@synthesize byLabel;
@synthesize buttonSelected;
@synthesize agendaViewController;
@synthesize selectButton;
@synthesize selectedSection;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;

//        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 3, 300, 95)];
//        [bgView.layer setCornerRadius:10.0f];
//        bgView.backgroundColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.5];;
//        [bgView.layer setBorderWidth:0.1f];
//        [self addSubview:bgView];
        
        UIImage *image = [UIImage imageNamed:@"list_bg.png"];
        UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.image = image;
        
        self.backgroundView = imageView;
        
        
        self.backgroundColor = [UIColor clearColor];
      
        agendaNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 250, 30)];
        agendaNameLabel.numberOfLines = 2;
        agendaNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:agendaNameLabel];
        
        agendaDetailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 270, 40)];
        agendaDetailsLabel.numberOfLines = 2;
        agendaDetailsLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:agendaDetailsLabel];
        
        byLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, 270, 40)];
        byLabel.numberOfLines = 2;
        byLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:byLabel];


        
        selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectButton.frame = CGRectMake(265, 20, 30, 30);
        [selectButton setImage:[UIImage imageNamed:@"gray_star.png"] forState:UIControlStateNormal];
        

        [selectButton addTarget:self action:@selector(selectButtonSetImage :) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectButton];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)selectButtonSetImage:(UIButton *)sender
{
    if (buttonSelected == NO)
    {
        buttonSelected = YES;
        [selectButton setImage:[UIImage imageNamed:@"gold_star.png"] forState:UIControlStateNormal];
        [agendaViewController addOrDeleteFromMyFavorites:sender.tag checkMark:buttonSelected];

    }
    else
    {
        buttonSelected = NO;
        [selectButton setImage:[UIImage imageNamed:@"gray_star.png"] forState:UIControlStateNormal];
        [agendaViewController addOrDeleteFromMyFavorites:sender.tag checkMark:buttonSelected];

        
        
    }
    //NSLog(@"%d",sender.tag);
    
}
- (void)dealloc
{
}

@end
