//
//  SpeakerView.m
//  BangaloreItBiz
//
//  Created by Srinivas on 28/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "SpeakerView.h"
#import "Util.h"

@implementation SpeakerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
        
        self.presenterlabel = [[UILabel alloc]initWithFrame:CGRectMake(10,10, 200, 25)];
        self.presenterlabel.font = [UIFont fontWithName:[Util titleFontName] size:14];
        self.presenterlabel.backgroundColor  = [UIColor clearColor];
        
        self.presenterlabel.textColor = [Util titleColor];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 40,250, 21)];
        self.nameLabel.font = [UIFont fontWithName:[Util subTitleFontName] size:15];
        self.nameLabel.textColor = [Util subTitleColor];
        self.nameLabel.backgroundColor  = [UIColor clearColor];
        
        
        self.titleLabel  =  [[UILabel alloc] initWithFrame:CGRectMake(30, 65, 180, 21)];
        self.titleLabel.textColor = [Util detailTextColor];
   
        self.titleLabel.font = [UIFont fontWithName:[Util detailTextFontName] size:13];
        self.titleLabel.backgroundColor  = [UIColor clearColor];
        
         [self addSubview:self.nameLabel];
         [self addSubview:self.titleLabel];
         [self addSubview:self.presenterlabel];
        
    }
    return self;
}

-(void)reDraw{
    
    CGFloat height = 5;
    
   CGSize size =  [self.nameLabel.text sizeWithFont:self.nameLabel.font constrainedToSize:CGSizeMake(self.nameLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect frame = self.nameLabel.frame;
    frame.size.height = size.height;
    height += size.height;
    
    self.nameLabel.numberOfLines = size.height/20;
    
    if (self.presenterlabel.hidden == YES) {
        frame.origin.y -= 25;
    }else{
        height += 25;
    }
    
    self.nameLabel.frame = frame;
    size =  [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(self.titleLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    frame = self.titleLabel.frame;
    frame.size.height = size.height;
    frame.origin.y = self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height+10;
    self.titleLabel.frame = frame;
    height +=  size.height;
    
//    CGSize s = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
//    NSLog(@" speakerview width %f ",s.height);
    self.titleLabel.numberOfLines = size.height/16+1;
  
    
    frame = self.frame;
    frame.size.height = height+5;
    self.frame = frame;
}


@end
