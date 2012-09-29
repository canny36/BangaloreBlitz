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
#import "Util.h"
#import "SpeakersViewController.h"
#import "AgendaItem.h"
#import "SpeakerInfo.h"
#import "SpeakerView.h"

@implementation AgendaDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}

//-(void)makeaMap
//{
//    NSString *tmpStr = @"";     
//    if ([selectedDict objectForKey:@"address"]!=nil)
//    {
//        tmpStr = [selectedDict objectForKey:@"address"];
//    }
//    
//    openMap = [[mapViews alloc] init];
//    
//    openMap.urlString = tmpStr;
//    
//    [self presentModalViewController:openMap animated:YES];
//}

-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


//-(void)agendaSpeakerDetails
//{
//    asdvController = [[AgendaSpeakerDetailsViewController alloc] init];
//    asdvController.selectedArray = speakersDetailsArray;
//    [self.navigationController pushViewController:asdvController animated:YES];
//}

-(void)initView
{
    float y = 0;
    
    UIFont *labelFont = [UIFont fontWithName:[Util detailTextFontName] size:15];
    UIColor *labelCOlor = [Util titleColor];
    UIFont *detailFont = [UIFont fontWithName:[Util subTitleFontName] size:14];
    
    CGSize size = [self.agendaItem.title sizeWithFont:[UIFont fontWithName:[Util titleFontName] size:16] constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10  , 10, 290, size.height+10)];
    
    titleLabel.font = [UIFont fontWithName:[Util titleFontName] size:16];
    titleLabel.textColor = [Util titleColor];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text  = self.agendaItem.title;
    titleLabel.numberOfLines = size.height/20;
    
   
    [scrollView addSubview:titleLabel];
     y = 10 + size.height + 10;
    
    UILabel *startLabel = [[UILabel alloc]initWithFrame:CGRectMake(10  , y, 290, 21)];
    startLabel.font = [UIFont fontWithName:[Util detailTextFontName] size:15];
    startLabel.textColor = labelCOlor;
    startLabel.textAlignment = UITextAlignmentCenter;
    startLabel.text= self.agendaItem.date;
    startLabel.backgroundColor = [UIColor clearColor];
       [scrollView addSubview:startLabel];
    
//    
//
//    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(100  , y, 179, 21)];
//    startLabel.font = detailFont;
//    startLabel.textColor = [Util detailTextColor];
//    startLabel.textAlignment = UITextAlignmentLeft;
//    startLabel.text= self.agendaItem.date;
//     startLabel.backgroundColor = [UIColor clearColor];
//    [scrollView addSubview:startLabel];
    
    
    y = y+5 + 21;
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(10  ,y, 290, 21)];
    startLabel.font = labelFont;
    startLabel.textColor = labelCOlor;
    startLabel.textAlignment = UITextAlignmentCenter;
    
    NSString *timeStr = self.agendaItem.startTime;
    if (self.agendaItem.endTime != nil) {
        timeStr = [timeStr stringByAppendingString:@" - "];
        timeStr = [timeStr stringByAppendingString:self.agendaItem.endTime];
    }

     startLabel.text= timeStr;
     startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
//    
//    y = y+10 + 21;
//    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(5  ,y, 91, 21)];
//    startLabel.font = labelFont;
//    startLabel.textColor = labelCOlor;
//    startLabel.textAlignment = UITextAlignmentRight;
//    startLabel.text=@" Start time :";
//     startLabel.backgroundColor = [UIColor clearColor];
//    [scrollView addSubview:startLabel];
//    
//    
//    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(100  , y, 170, 21)];
//    startLabel.font = detailFont;
//    startLabel.textColor = [Util detailTextColor];
//    startLabel.textAlignment = UITextAlignmentLeft;
//    startLabel.text= self.agendaItem.startTime;
//     startLabel.backgroundColor = [UIColor clearColor];
//    [scrollView addSubview:startLabel];
    
//    y = y+10 + 21;
//    
//    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(5  ,y, 91, 21)];
//    startLabel.font = labelFont;
//    startLabel.textColor = labelCOlor;
//    startLabel.textAlignment = UITextAlignmentRight;
//    startLabel.text=@" End time :";
//     startLabel.backgroundColor = [UIColor clearColor];
//    [scrollView addSubview:startLabel];
//    
//    
//    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(100 , y, 170, 21)];
//    startLabel.font = detailFont;
//    startLabel.textColor = [Util detailTextColor];
//    startLabel.textAlignment = UITextAlignmentLeft;
//    startLabel.text= self.agendaItem.endTime;
//    startLabel.backgroundColor = [UIColor clearColor];
//    [scrollView addSubview:startLabel];
    
    
    y = y+10 + 21;
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(10  ,y,91, 21)];
    startLabel.font = labelFont;
    startLabel.textColor = labelCOlor;
    startLabel.textAlignment = UITextAlignmentLeft;
    startLabel.text=@"Address :";
     startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
     y = y+10 + 21;
    
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(40 , y, 180, 90)];
    startLabel.font = detailFont;
    startLabel.textColor = [Util detailTextColor];
    startLabel.textAlignment = UITextAlignmentLeft;
    startLabel.text= self.agendaItem.address;
    startLabel.numberOfLines = 5;
      startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    
    y = y+10 + 90;

    
//    if (self.agendaItem.agendaSpeaker != nil && ![self.agendaItem.agendaSpeaker isEqualToString:@""]) {
//        
//        
//        startLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 ,y, 91, 21)];
//        startLabel.font = labelFont;
//        startLabel.textColor = labelCOlor;
//        startLabel.textAlignment = UITextAlignmentLeft;
//        startLabel.text=@"Speakers :";
//        startLabel.backgroundColor = [UIColor clearColor];
//        [scrollView addSubview:startLabel];
//        
//        CGSize size = [self.agendaItem.agendaSpeaker sizeWithFont:detailFont constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
//        
//       UIButton *speakerLabel = [[UIButton alloc]initWithFrame:CGRectMake(100 , y, size.width +10,size.height+10)];
//        speakerLabel.backgroundColor = [UIColor clearColor];
//        [speakerLabel setTitle:self.agendaItem.agendaSpeaker forState:UIControlStateNormal];
//        speakerLabel.titleLabel.font = detailFont;
//        [speakerLabel setTitleColor:[Util detailTextColor] forState:UIControlStateNormal];
//        [speakerLabel setTitleColor:[Util linkTextColor] forState:UIControlStateHighlighted];
//        speakerLabel.titleLabel.textAlignment = UITextAlignmentLeft;
//        speakerLabel.titleLabel.text= self.agendaItem.agendaSpeaker;
//        [speakerLabel addTarget:self action:@selector(onSpeakerClick) forControlEvents:UIControlEventTouchUpInside];
//         
//        [scrollView addSubview:speakerLabel];
//        
//        y = y+10+size.height+10;
//        
//        
//    }
    
    if (self.agendaItem.description != nil && ![self.agendaItem.description isEqualToString:@""]) {
      
        startLabel = [[UILabel alloc]initWithFrame:CGRectMake(10  ,y, 91, 21)];
        startLabel.font = labelFont;
        startLabel.textColor = labelCOlor;
        startLabel.textAlignment = UITextAlignmentLeft;
        startLabel.text=@"Description :";
        startLabel.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:startLabel];
        
        
        size= [self.agendaItem.description sizeWithFont:detailFont constrainedToSize:CGSizeMake(250, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        
        startLabel = [[UILabel alloc]initWithFrame:CGRectMake(40 ,y+30, 280, size.height +10)];
        startLabel.font = detailFont;
        startLabel.textColor = [Util detailTextColor];
        startLabel.textAlignment = UITextAlignmentLeft;
        startLabel.text= self.agendaItem.description;
        startLabel.numberOfLines = size.height/20 + 1;
        startLabel.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:startLabel];
        
         y = y+30+size.height+6;
    }
  
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    if (self.agendaItem.speakers.count >0 ) {
        startLabel = [[UILabel alloc]initWithFrame:CGRectMake(10  ,y, 91, 21)];
        startLabel.font = labelFont;
        startLabel.textColor = labelCOlor;
        startLabel.textAlignment = UITextAlignmentLeft;
        startLabel.text=@"Speakers :";
        startLabel.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:startLabel];
        
        y= y+5+21;
    }

    
    for (SpeakerInfo *info in  self.agendaItem.speakers) {
        
        SpeakerView *speakerView = [[SpeakerView alloc]initWithFrame:CGRectMake(0, y, 280, 90)] ;
        speakerView.titleLabel.text = info.type;
        
        NSLog(@"TITLE of speaker %@ \n %@ ",info.name,info.type);
        speakerView.nameLabel.text = info.name;
        speakerView.presenterlabel.hidden = NO;
        
        if (info.presenterType != nil) {
            if ([array indexOfObject:info.presenterType] == NSNotFound) {
                speakerView.presenterlabel.text = info.presenterType;
                [array addObject:info.presenterType];
                
            }else{
                speakerView.presenterlabel.hidden = YES;
            }
        }else{
             speakerView.presenterlabel.hidden = YES;
        }
        

        [speakerView reDraw];
        
        y = y+ speakerView.frame.size.height+5;
        [scrollView addSubview:speakerView];
        
    }
    
     y= y+20;
    [scrollView setContentSize:CGSizeMake(300,y)];

}




-(void)initViewForSubItem
{
    float y = 0;
    
    UIFont *labelFont = [UIFont fontWithName:[Util detailTextFontName] size:15];
    UIColor *labelCOlor = [Util titleColor];
    UIFont *detailFont = [UIFont fontWithName:[Util subTitleFontName] size:14];
    
    CGSize size = [self.subAgendaItem.title sizeWithFont:[UIFont fontWithName:[Util titleFontName] size:16] constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10  , 10, 290, size.height+10)];
    
    titleLabel.font = [UIFont fontWithName:[Util titleFontName] size:16];
    titleLabel.textColor = [Util titleColor];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text  = self.subAgendaItem.title;
    titleLabel.numberOfLines = size.height/20;
    
    
    [scrollView addSubview:titleLabel];
    y = 10 + size.height + 10;
    
    UILabel *startLabel = [[UILabel alloc]initWithFrame:CGRectMake(10  , y, 290, 21)];
    startLabel.font = [UIFont fontWithName:[Util detailTextFontName] size:15];
    startLabel.textColor = labelCOlor;
    startLabel.textAlignment = UITextAlignmentCenter;
    startLabel.text= self.subAgendaItem.date;
    startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    //
    //
    //    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(100  , y, 179, 21)];
    //    startLabel.font = detailFont;
    //    startLabel.textColor = [Util detailTextColor];
    //    startLabel.textAlignment = UITextAlignmentLeft;
    //    startLabel.text= self.agendaItem.date;
    //     startLabel.backgroundColor = [UIColor clearColor];
    //    [scrollView addSubview:startLabel];
    
    
    y = y+5 + 21;
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(10  ,y, 290, 21)];
    startLabel.font = labelFont;
    startLabel.textColor = labelCOlor;
    startLabel.textAlignment = UITextAlignmentCenter;
    
    NSString *timeStr = self.subAgendaItem.startTime;
    if (self.agendaItem.endTime != nil) {
        timeStr = [timeStr stringByAppendingString:@" - "];
        timeStr = [timeStr stringByAppendingString:self.agendaItem.endTime];
    }
    
    startLabel.text= timeStr;
    startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    //
    //    y = y+10 + 21;
    //    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(5  ,y, 91, 21)];
    //    startLabel.font = labelFont;
    //    startLabel.textColor = labelCOlor;
    //    startLabel.textAlignment = UITextAlignmentRight;
    //    startLabel.text=@" Start time :";
    //     startLabel.backgroundColor = [UIColor clearColor];
    //    [scrollView addSubview:startLabel];
    //
    //
    //    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(100  , y, 170, 21)];
    //    startLabel.font = detailFont;
    //    startLabel.textColor = [Util detailTextColor];
    //    startLabel.textAlignment = UITextAlignmentLeft;
    //    startLabel.text= self.agendaItem.startTime;
    //     startLabel.backgroundColor = [UIColor clearColor];
    //    [scrollView addSubview:startLabel];
    
    //    y = y+10 + 21;
    //
    //    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(5  ,y, 91, 21)];
    //    startLabel.font = labelFont;
    //    startLabel.textColor = labelCOlor;
    //    startLabel.textAlignment = UITextAlignmentRight;
    //    startLabel.text=@" End time :";
    //     startLabel.backgroundColor = [UIColor clearColor];
    //    [scrollView addSubview:startLabel];
    //
    //
    //    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(100 , y, 170, 21)];
    //    startLabel.font = detailFont;
    //    startLabel.textColor = [Util detailTextColor];
    //    startLabel.textAlignment = UITextAlignmentLeft;
    //    startLabel.text= self.agendaItem.endTime;
    //    startLabel.backgroundColor = [UIColor clearColor];
    //    [scrollView addSubview:startLabel];
    
    
    y = y+10 + 21;
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(10  ,y,91, 21)];
    startLabel.font = labelFont;
    startLabel.textColor = labelCOlor;
    startLabel.textAlignment = UITextAlignmentLeft;
    startLabel.text=@"Address :";
    startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    y = y+10 + 21;
    
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(40 , y, 180, 90)];
    startLabel.font = detailFont;
    startLabel.textColor = [Util detailTextColor];
    startLabel.textAlignment = UITextAlignmentLeft;
    startLabel.text= self.subAgendaItem.address;
    startLabel.numberOfLines = 5;
    startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    
    y = y+10 + 90;
    
    
//    if (self.agendaItem.agendaSpeaker != nil && ![self.agendaItem.agendaSpeaker isEqualToString:@""]) {
//        
//        
//        startLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 ,y, 91, 21)];
//        startLabel.font = labelFont;
//        startLabel.textColor = labelCOlor;
//        startLabel.textAlignment = UITextAlignmentLeft;
//        startLabel.text=@"Speakers :";
//        startLabel.backgroundColor = [UIColor clearColor];
//        [scrollView addSubview:startLabel];
//        
//        CGSize size = [self.agendaItem.agendaSpeaker sizeWithFont:detailFont constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
//        
//        UIButton *speakerLabel = [[UIButton alloc]initWithFrame:CGRectMake(100 , y, size.width +10,size.height+10)];
//        speakerLabel.backgroundColor = [UIColor clearColor];
//        [speakerLabel setTitle:self.subAgendaItem.agendaSpeaker forState:UIControlStateNormal];
//        speakerLabel.titleLabel.font = detailFont;
//        [speakerLabel setTitleColor:[Util detailTextColor] forState:UIControlStateNormal];
//        [speakerLabel setTitleColor:[Util linkTextColor] forState:UIControlStateHighlighted];
//        speakerLabel.titleLabel.textAlignment = UITextAlignmentLeft;
//        speakerLabel.titleLabel.text= self.agendaItem.agendaSpeaker;
//        [speakerLabel addTarget:self action:@selector(onSpeakerClick) forControlEvents:UIControlEventTouchUpInside];
//        
//        [scrollView addSubview:speakerLabel];
//        
//        y = y+10+size.height+10;
//        
//        
//    }
    
    if (self.subAgendaItem.description != nil && ![self.subAgendaItem.description isEqualToString:@""]) {
        
        startLabel = [[UILabel alloc]initWithFrame:CGRectMake(10  ,y, 91, 21)];
        startLabel.font = labelFont;
        startLabel.textColor = labelCOlor;
        startLabel.textAlignment = UITextAlignmentLeft;
        startLabel.text=@"Description :";
        startLabel.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:startLabel];
        
        
        size= [self.subAgendaItem.description sizeWithFont:detailFont constrainedToSize:CGSizeMake(250, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        
        startLabel = [[UILabel alloc]initWithFrame:CGRectMake(40 ,y+30, 280, size.height +10)];
        startLabel.font = detailFont;
        startLabel.textColor = [Util detailTextColor];
        startLabel.textAlignment = UITextAlignmentLeft;
        startLabel.text= self.subAgendaItem.description;
        startLabel.numberOfLines = size.height/20 + 1;
        startLabel.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:startLabel];
        
        y = y+30+size.height+6;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    if (self.subAgendaItem.speakers.count >0 ) {
        startLabel = [[UILabel alloc]initWithFrame:CGRectMake(10  ,y, 91, 21)];
        startLabel.font = labelFont;
        startLabel.textColor = labelCOlor;
        startLabel.textAlignment = UITextAlignmentLeft;
        startLabel.text=@"Speakers :";
        startLabel.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:startLabel];
        
        y= y+5+21;
    }
    
    
    for (SpeakerInfo *info in  self.subAgendaItem.speakers) {
        
        SpeakerView *speakerView = [[SpeakerView alloc]initWithFrame:CGRectMake(0, y, 280, 90)] ;
        speakerView.titleLabel.text = info.type;
        
        NSLog(@"TITLE of speaker %@ \n %@ ",info.name,info.type);
        speakerView.nameLabel.text = info.name;
        speakerView.presenterlabel.hidden = NO;
        
        if (info.presenterType != nil) {
            if ([array indexOfObject:info.presenterType] == NSNotFound) {
                speakerView.presenterlabel.text = info.presenterType;
                [array addObject:info.presenterType];
                
            }else{
                speakerView.presenterlabel.hidden = YES;
            }
        }else{
            speakerView.presenterlabel.hidden = YES;
        }
        
        
        [speakerView reDraw];
        
        y = y+ speakerView.frame.size.height+5;
        [scrollView addSubview:speakerView];
        
    }
    
    y= y+20;
    [scrollView setContentSize:CGSizeMake(300,y)];
    
}



-(void)onSpeakerClick{
    SpeakersViewController *controller = [[SpeakersViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
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

    self.title = @"Agenda Info";
    
    scrollView.frame = CGRectMake(10, 0, 300, 285);
    [scrollView setContentSize:CGSizeMake(300, 600)];
    scrollView.showsVerticalScrollIndicator = NO;
    
    if(self.agendaItem != nil){
        [self initView];
    }else{
        [self initViewForSubItem];
    }
        
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
