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
        
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 3, 300, 55)];
        [bgView.layer setCornerRadius:10.0f];
        bgView.backgroundColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.5];;
        [bgView.layer setBorderWidth:0.1f];
        [self addSubview:bgView];
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
