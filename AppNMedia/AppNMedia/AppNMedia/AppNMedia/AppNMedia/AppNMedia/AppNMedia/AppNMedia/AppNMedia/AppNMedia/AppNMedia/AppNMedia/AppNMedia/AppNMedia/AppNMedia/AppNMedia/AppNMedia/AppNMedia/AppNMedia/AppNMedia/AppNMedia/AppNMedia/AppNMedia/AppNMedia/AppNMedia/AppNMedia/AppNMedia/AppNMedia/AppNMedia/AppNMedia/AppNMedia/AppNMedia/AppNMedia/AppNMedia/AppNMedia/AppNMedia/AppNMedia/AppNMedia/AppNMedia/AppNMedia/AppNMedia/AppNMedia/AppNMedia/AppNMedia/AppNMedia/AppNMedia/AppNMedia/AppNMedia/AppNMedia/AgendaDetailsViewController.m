//
//  AgendaDetailsViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 10/05/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "AgendaDetailsViewController.h"
#import "AppNMediaAppDelegate.h"
#import "AgendaSpeakerDetailsViewController.h"

@implementation AgendaDetailsViewController
@synthesize selectedDict;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)makeaMap
{
            NSString *tmpStr = @"";     
        if ([selectedDict objectForKey:@"address"]!=nil)
        {
            tmpStr = [selectedDict objectForKey:@"address"];
        }
        
        openMap = [[mapViews alloc] init];
        
        openMap.urlString = tmpStr;
        
        [self presentModalViewController:openMap animated:YES];
}

-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView == byTxtView)
    {
        [self agendaSpeakerDetails];

    }
    return FALSE;
}



-(void)assignStyles
{
    
    titleFontName =@"Helvitica-Bold";
    titleFontSize = @"14";
    subTitleFontName = @"Helvitica";
    subTitleFontSize = @"12";
    
}
  
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
//    [self userShow:nil]; //Within this method a subsequent UIViewController subclass/object is created and pushed.
//    return FALSE;
//}
-(void)agendaSpeakerDetails
{
    asdvController = [[AgendaSpeakerDetailsViewController alloc] init];
    asdvController.selectedArray = speakersDetailsArray;
    [self.navigationController pushViewController:asdvController animated:YES];
}

-(void)createLabelsWithStyles
{
   
    
    [levelLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    levelLabel.textColor = [UIColor whiteColor];
    
    [byLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    byLabel.textColor = [UIColor whiteColor];

    [levelDataLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    levelDataLabel.textColor = [UIColor whiteColor];
       
    [roomLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    roomLabel.textColor = [UIColor whiteColor];
    
    [instructorLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    instructorLabel.textColor = [UIColor whiteColor];
  
    [addressTxtView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
   addressTxtView.textColor = [UIColor whiteColor];

    if ([selectedDict objectForKey:@"room"]!= nil)
    {
        roomTxtView.text = [selectedDict objectForKey:@"room"];
    }
    roomTxtView.editable = NO;

    
    if ([selectedDict objectForKey:@"presenter_type"]!= nil)
    {
        instructorLabel.text = [selectedDict objectForKey:@"presenter_type"];
    }
    
    
    if ([selectedDict objectForKey:@"address"]!= nil)
    {
        addressTxtView.text = [selectedDict objectForKey:@"address"];
    }
    if ([selectedDict objectForKey:@"level"]!= nil)
    {
        levelDataLabel.text = [selectedDict objectForKey:@"level"];
    }
    if ([selectedDict objectForKey:@"title"]!= nil)
    {
        titleTxtView.text = [selectedDict objectForKey:@"title"];
    }

    
    
    if ([selectedDict objectForKey:@"date"] != nil) 
    {
        NSString *timeStr = [selectedDict objectForKey:@"date"];
        if ([selectedDict objectForKey:@"starttime"]!= nil) 
        {
            timeStr = [timeStr stringByAppendingString:@"   "];
            timeStr = [timeStr stringByAppendingString:[selectedDict objectForKey:@"starttime"]];
            timeStr = [timeStr stringByAppendingString:@" to "];
            timeStr = [timeStr stringByAppendingString:@"\n"];

            if ([selectedDict objectForKey:@"enddate"]!= nil) 
            {
                timeStr = [timeStr stringByAppendingString:[selectedDict objectForKey:@"enddate"]];
                timeStr = [timeStr stringByAppendingString:@"   "];

                if ([selectedDict objectForKey:@"endtime"]!= nil) 
                {
                    timeStr = [timeStr stringByAppendingString:[selectedDict objectForKey:@"endtime"]];

                }

            }

        }
        timeTxtView.text = timeStr;

    }
    
       
    [descriptionLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    descriptionLabel.textColor = [UIColor whiteColor];
    
    descriptionTextView.text = [selectedDict objectForKey:@"description"];
    [descriptionTextView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    descriptionTextView.textColor = [UIColor whiteColor];
    
    [timeTxtView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    timeTxtView.textColor = [UIColor whiteColor];
    
    [titleTxtView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    titleTxtView.textColor = [UIColor whiteColor];
    
    [roomTxtView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    roomTxtView.textColor = [UIColor whiteColor];

    [byTxtView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    byTxtView.textColor = [UIColor whiteColor];
    

    
    CGRect frame = descriptionTextView.frame;
    int height = descriptionTextView.contentSize.height;
    if (height > 125)
    {
        frame.size.height = 125;
    }
    else
    {
        frame.size.height = height;
    }
    descriptionTextView.frame = frame;

    NSString *nameStr = @"";
    for (int i=0; i<[speakersDetailsArray count]; i++)
    {
        NSMutableDictionary *tmpDict = [speakersDetailsArray objectAtIndex:i] ;
        nameStr = [nameStr stringByAppendingString:[tmpDict objectForKey:@"firstname"]];
        nameStr = [nameStr stringByAppendingString:@" "];
        
        if ([tmpDict objectForKey:@"lastname"] != nil)
        {
            nameStr = [nameStr stringByAppendingString:[tmpDict objectForKey:@"lastname"]];
        }
        if (i<[speakersDetailsArray count]-1)
        {
            nameStr = [nameStr stringByAppendingString:@" & "];

        }
          
    }
    byTxtView.text= nameStr;
    byTxtView.userInteractionEnabled = YES;
    
    
    

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;
    
    
    byTxtView.delegate = self;
                                    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-20, 0, 250, 25)];
    label.backgroundColor = [UIColor clearColor];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text =[selectedDict objectForKey:@"title"];
    self.navigationItem.titleView = label;
    
    scrollView.frame = CGRectMake(10, 0, 300, 285);
    [scrollView setContentSize:CGSizeMake(300, 600)];
    scrollView.showsVerticalScrollIndicator = NO;
    
    
   // NSLog(@"%@",selectedDict);
        
    speakersDetailsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    if ([[[selectedDict objectForKey:@"agendaspeakers"] objectForKey:@"agendaspeaker"] isKindOfClass:[NSDictionary class]]) 
    {
        [speakersDetailsArray addObject:[[selectedDict objectForKey:@"agendaspeakers"] objectForKey:@"agendaspeaker"]];
    }
    else
    {
        [speakersDetailsArray addObjectsFromArray:[[selectedDict objectForKey:@"agendaspeakers"] objectForKey:@"agendaspeaker"]];
    } 
     
    [self assignStyles];
    [self createLabelsWithStyles];
    
    
    UITapGestureRecognizer *txtTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeaMap)];
    [addressTxtView addGestureRecognizer:txtTapGesture];
    addressTxtView.userInteractionEnabled = YES;

    transparentImageView.frame = CGRectMake(30, 70, 260, 250);

    
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
