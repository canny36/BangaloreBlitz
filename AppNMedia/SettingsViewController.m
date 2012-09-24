//
//  SettingsViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 22/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppNMediaAppDelegate.h"
#import "Util.h"

@implementation SettingsViewController
- (NSString *)dataFilePathForRunOfflineOnline
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"onlineOffline.plist"];
}

- (NSString *)dataFilePathForDataSynchMethod
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"dataSynch.plist"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    timeTextFiled.inputView = [[UIView alloc] initWithFrame:CGRectZero] ;
    
    
    if (appDelegate.runAppInOffline )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Enable application in online mode " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [timeTextFiled resignFirstResponder];
    }
    else
    {
    
    
    [self.view bringSubviewToFront:dataSynchTimePicker];
   
    CGRect viewFrame1 = CGRectMake(0,110, 320, 40);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration: 0.7];
    [toolBarpicker setFrame:viewFrame1];
    [UIView commitAnimations]; 
    
    
    CGRect viewFrame = CGRectMake(0,150, 320, 216);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration: 0.7];
    [dataSynchTimePicker setFrame:viewFrame];
    [UIView commitAnimations]; 
    }

    return YES;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

-(void)cancelAction
{
    CGRect viewFrame = CGRectMake(0,500, 320, 216);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration: 0.7];
    [dataSynchTimePicker setFrame:viewFrame];
    [UIView commitAnimations]; 
    
    CGRect viewFrame1 = CGRectMake(0,800, 320, 40);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration: 0.7];
    [toolBarpicker setFrame:viewFrame1];
    [UIView commitAnimations]; 
    [timeTextFiled resignFirstResponder];

}


-(void)doneButActionpicker
{ 
    
    CGRect viewFrame = CGRectMake(0,500, 320, 216);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration: 0.7];
    [dataSynchTimePicker setFrame:viewFrame];
    [UIView commitAnimations]; 
    
    CGRect viewFrame1 = CGRectMake(0,800, 320, 40);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration: 0.7];
    [toolBarpicker setFrame:viewFrame1];
    [UIView commitAnimations]; 
    [timeTextFiled resignFirstResponder];
    
    timeTextFiled.text = selectedTimeValue;
    
    BOOL network = [appDelegate isNetWorkAvailable];
    if (network)
    {
    [self performSelector:@selector(callDataSynchMethod:) withObject:selectedTimeValue];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enable your network connection " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }


}
#pragma mark - Picker view data source and delegate methods

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [pickerViewSourceArray objectAtIndex:row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
       
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 37)];
        label.text = [pickerViewSourceArray objectAtIndex:row];
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        return label;

}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectedTimeValue = [pickerViewSourceArray objectAtIndex:row];
}

-(void)callDataSynchMethod :(NSString *)selectedTime
{
    
        NSString *filePath = [self dataFilePathForDataSynchMethod];
        
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        [tmpDict setObject:selectedTime forKey:@"dataSynchTime"];
        
        [tmpDict writeToFile:filePath  atomically:YES];
        [appDelegate dataSynchMethod:selectedTime];

    

}

-(void)assignStyles
{
    titleFontName = [Util subTitleFontName];
    titleFontSize = @"15";
    
    subTitleFontName = [Util detailTextFontName];
    subTitleFontSize = @"15";
    
   
    [onlineOfflinelabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    onlineOfflinelabel.textColor = [UIColor whiteColor];
    
    
    [syncTimeLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    syncTimeLabel.textColor = [UIColor whiteColor];
    
    [minutsLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    minutsLabel.textColor = [UIColor whiteColor];
    
    
}
-(void)homeButtonClicked
{
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
    if ([homeButton.title isEqualToString:@"Save"])
    {
        [self performSelector:@selector(callDataSynchMethod:) withObject:selectedTimeValue];

    }

}

-(void)switchValueChanged
{
    if (onlineOfflineSwitch.on) 
    {
        appDelegate.runAppInOffline = NO;
        [homeButton setTitle:@"Save"];
        [self homeButtonClicked];

    }
    else
    {
        appDelegate.runAppInOffline = YES;
        [homeButton setTitle:@"Edit"];

        
        CGRect viewFrame = CGRectMake(0,500, 320, 216);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration: 0.7];
        [dataSynchTimePicker setFrame:viewFrame];
        [UIView commitAnimations]; 
        
        CGRect viewFrame1 = CGRectMake(0,800, 320, 40);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration: 0.7];
        [toolBarpicker setFrame:viewFrame1];
        [UIView commitAnimations]; 
        [timeTextFiled resignFirstResponder];

    }
    
    
    NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    if (appDelegate.runAppInOffline == NO)
    {
        [tmpDict setObject:@"NO" forKey:@"runAppInOffline"];
        timeTextFiled.hidden = NO;
        minutsLabel.hidden = NO;
    }
    else
    {
        [tmpDict setObject:@"YES" forKey:@"runAppInOffline"];
        timeTextFiled.hidden = YES;
        minutsLabel.hidden = YES;

  
    }
    
    
    NSString *filePath = [self dataFilePathForRunOfflineOnline];
    
    [tmpDict writeToFile:filePath atomically:YES];
    
    
}

- (void)dealloc
{
  
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)newUpdate
{
    @autoreleasepool {
        
    [appDelegate callDataSynchMethod];
    }
}

#pragma mark - View lifecycle
-(void)viewWillDisappear:(BOOL)animated
{

    [self performSelectorInBackground:@selector(newUpdate) withObject:nil];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    self.title = @"Settings";
    [self assignStyles];
//    homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
//    self.navigationItem.rightBarButtonItem = homeButton;
//    
    [onlineOfflineSwitch addTarget: self action: @selector(switchValueChanged) forControlEvents:UIControlEventValueChanged];
   
    NSString *filePath = [self dataFilePathForRunOfflineOnline];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        NSString *tmpStr = [tmpDict objectForKey:@"runAppInOffline"];
        
        if ([tmpStr isEqualToString:@"YES"])
        {
            appDelegate.runAppInOffline = YES;
            [onlineOfflineSwitch setOn:NO];
            timeTextFiled.hidden = YES;
            minutsLabel.hidden = YES;
            [homeButton setTitle:@"Edit"];


        }
        else
        {
            BOOL network = [appDelegate isNetWorkAvailable];
            if (network)
            {
                appDelegate.runAppInOffline= NO;
                [onlineOfflineSwitch setOn:YES];
                timeTextFiled.hidden = NO;
                minutsLabel.hidden = NO;
                [homeButton setTitle:@"Save"];
            }
            else
            {
                appDelegate.runAppInOffline = YES;
                [onlineOfflineSwitch setOn:NO];
                timeTextFiled.hidden = YES;
                minutsLabel.hidden = YES;
                [homeButton setTitle:@"Edit"];
            }
           

              
        }
        
    }
    else
    {
        BOOL network = [appDelegate isNetWorkAvailable];
        if (network)
        {
            appDelegate.runAppInOffline= NO;
            [onlineOfflineSwitch setOn:YES];
            timeTextFiled.hidden = NO;
            minutsLabel.hidden = NO;
            [homeButton setTitle:@"Save"];
        }
        else
        {
            appDelegate.runAppInOffline = YES;
            [onlineOfflineSwitch setOn:NO];
            timeTextFiled.hidden = YES;
            minutsLabel.hidden = YES;
            [homeButton setTitle:@"Edit"];
        }

    }
    
    pickerViewSourceArray = [[NSMutableArray alloc] initWithObjects:@"6",@"10",@"15",@"30",@"60", nil];
    selectedTimeValue = [pickerViewSourceArray objectAtIndex:0
                         ];
    timeTextFiled.text = selectedTimeValue;
    
    dataSynchTimePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 800, 320, 216)];
    dataSynchTimePicker.dataSource =self;
    dataSynchTimePicker.delegate = self;
    dataSynchTimePicker.showsSelectionIndicator = YES;
    //[dataSynchTimePicker selectedRowInComponent:2];
    [self.view addSubview:dataSynchTimePicker];
    
    
    toolBarpicker = [[UIToolbar alloc] initWithFrame:CGRectMake(10,800,300,40)];
    toolBarpicker.barStyle = UIBarStyleBlackTranslucent;
    [self.view addSubview:toolBarpicker];
    
    UIBarButtonItem *donepicker= [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneButActionpicker)];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] ;
    
    UIBarButtonItem *cancel= [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelAction)];
    
    toolBarpicker.items =  [NSArray arrayWithObjects:cancel,space,donepicker,nil];
    
    
    NSString *filePathForDataSynch = [self dataFilePathForDataSynchMethod];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePathForDataSynch]) 
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePathForDataSynch];
        
        timeTextFiled.text = [tmpDict objectForKey:@"dataSynchTime"];
    }
    
   transparentImageView.frame = CGRectMake(30, 70, 260, 250);
    selectedTimeValue = @"6";
    

    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
