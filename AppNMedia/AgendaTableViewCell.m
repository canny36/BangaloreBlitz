//
//  AgendaTableViewCell.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 27/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "AgendaTableViewCell.h"
#import "AgendaViewController.h"
#import "AgendaItem.h"
#import "Util.h"

@implementation AgendaTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
            
    }
    return self;
}

+(int)heightForItem:(AgendaItem*)item{
      
    NSString *dateStr = @"";
    
    if (item.startTime != nil)
    {
        dateStr = [dateStr stringByAppendingString:@" \n "];
        dateStr = [dateStr stringByAppendingString:item.startTime];
        
    }
    
    if (item.endTime != nil)
    {
        dateStr = [dateStr stringByAppendingString:@" - "];
        dateStr = [dateStr stringByAppendingString:item.endTime];
    }
    
    
    CGSize size1 = [item.title sizeWithFont:[UIFont fontWithName:[Util subTitleFontName] size:15] constrainedToSize:CGSizeMake(230 ,MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    
    CGSize size2 = [dateStr sizeWithFont:[UIFont fontWithName:[Util detailTextFontName] size:13] constrainedToSize:CGSizeMake(230, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    return size1.height + size2.height +10;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)cellWithAgendaItem:(AgendaItem*)item{
    NSString *dateStr = @"";
    
    if (item.startTime != nil)
    {
        dateStr = [dateStr stringByAppendingString:@" \n "];
        dateStr = [dateStr stringByAppendingString:item.startTime];
        
    }
    
    if (item.endTime != nil)
    {
        dateStr = [dateStr stringByAppendingString:@" - "];
        dateStr = [dateStr stringByAppendingString:item.endTime];
    }
    
    
    CGSize size = [item.title sizeWithFont:self.textLabel.font constrainedToSize:CGSizeMake(self.textLabel.frame.size.width ,MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    int lines = size.height/21+1;

    self.textLabel.text = item.title;
    self.textLabel.numberOfLines = lines;
    
    
    size = [dateStr sizeWithFont:self.detailTextLabel.font constrainedToSize:CGSizeMake(self.detailTextLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    
    self.detailTextLabel.text = dateStr;
    lines = size.height/20;
    self.detailTextLabel.numberOfLines = lines > 2 ? lines : 2;
    

    
}



- (void)dealloc
{
    
}

@end
