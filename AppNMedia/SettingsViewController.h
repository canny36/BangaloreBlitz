//
//  SettingsViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 22/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppNMediaAppDelegate;
@interface SettingsViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
{
    AppNMediaAppDelegate    *appDelegate;
    IBOutlet UIImageView *mainBgView;
    IBOutlet UIImageView *subBgView;
    
    IBOutlet UILabel *minutsLabel;
    IBOutlet UISwitch *onlineOfflineSwitch;
    IBOutlet UILabel  *onlineOfflinelabel;
    IBOutlet UILabel  *syncTimeLabel;
    IBOutlet UITextField *timeTextFiled;
    IBOutlet UILabel  *appUpdateLabel;
    IBOutlet UILabel  *appUpdateDetail;
        
    UIBarButtonItem *homeButton;
    UIPickerView *dataSynchTimePicker;
    NSMutableArray *pickerViewSourceArray;
    UIToolbar *toolBarpicker;
    NSString *selectedTimeValue;
    //////////// Styles data
    NSString *titleColor;
    NSString *subTitleColor;
    
    NSString *titleFontName;
    NSString *subTitleFontName;
    
    NSString *titleFontSize;
    NSString *subTitleFontSize;
    IBOutlet UIImageView *transparentImageView;
}
-(void)homeButtonClicked;
-(void)assignStyles;
-(void)switchValueChanged;
-(void)callDataSynchMethod :(NSString *)selectedTime;
-(void)newUpdate;
@end
