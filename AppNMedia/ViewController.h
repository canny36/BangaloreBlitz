//
//  ViewController.h
//  PhotoPager1
//
//  Created by Logic2 on 19/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate>{

    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *label;
    NSArray *urlArray;
    
    IBOutlet UIButton *lButton;
    IBOutlet UIButton *rButton;
    
    
    
    
    
}
-(void)scrollItems;
-(void)scrollItemsLocal;
- (IBAction)onLeftClick;
- (IBAction)onRightClick;
@end
