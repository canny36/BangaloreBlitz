//
//  AgnedaListTableViewCell.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 12/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "AgnedaListTableViewCell.h"


@implementation AgnedaListTableViewCell
@synthesize agendaNameTxtView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        
        UIImage *image = [UIImage imageNamed:@"list_bg.png"];
        UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.image = image;
        
        self.backgroundView = imageView;
        
        self.backgroundColor = [UIColor clearColor];

        agendaNameTxtView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, 280, 40)];
        agendaNameTxtView.backgroundColor = [UIColor clearColor];
        agendaNameTxtView.editable = NO;
        agendaNameTxtView.userInteractionEnabled = NO;
        [self addSubview: agendaNameTxtView];
    }
    return self;
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
