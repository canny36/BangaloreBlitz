//
//  GalleryViewController.h
//  AppNMedia
//
//  Created by Srinivas on 25/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryViewController : UIViewController{
    
    
    IBOutlet UIButton *videosButton;
    IBOutlet UIButton *photosButton;
    IBOutlet UIButton *pressButton;
}

-(IBAction)onButtonClick :(id)sender;

@end
