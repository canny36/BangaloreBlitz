//
//  SubAgendaCell.h
//  BangaloreItBiz
//
//  Created by Srinivas on 28/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubAgendaViewController.h"

@interface SubAgendaCell : UITableViewCell{
    
    UIButton *selectButton;
    SubAgendaViewController *_controller;
    
}

@property(nonatomic,retain) SubAgendaViewController *controller;

-(void)selectButton:(BOOL)select;

@end
