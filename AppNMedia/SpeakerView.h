//
//  SpeakerView.h
//  BangaloreItBiz
//
//  Created by Srinivas on 28/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeakerView : UIView{
    
    UILabel *_presenterlabel;
    UILabel *_nameLabel;
    UILabel *_titleLabel;
    
}

@property (nonatomic , retain) UILabel *presenterlabel;
@property (nonatomic , retain) UILabel *nameLabel;
@property (nonatomic , retain) UILabel *titleLabel;

-(void)reDraw;

@end
