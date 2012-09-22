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



@interface AgendaItem : NSObject{
    
//    <item><agendaid>5</agendaid><title>Inauguration of the Conference</title><date>Wednesday. 10/17/2012</date><enddate>Wednesday. 10/17/2012</enddate><starttime>10:00 am</starttime><endtime>11:15 am</endtime><locationid>2</locationid><address>KTPO Bangalore, Plot No.121, EPIP,,  Whitefield Industrial Area,, Bangalore, Karnataka 560052</address><room></room><level></level><agendaspeaker></agendaspeaker><presenter_type></presenter_type><description></description><url></url><createddate>08/28/2012</createddate><modifieddate>08/28/2012</modifieddate><status>1</status><agendaspeakers></agendaspeakers></item>
    
    
    NSString *_title;
    NSString *_date;
    NSString *_startTime;
    NSString *_endTime;
    NSString *_agendaSpeaker;
    NSString *_description;
    NSString *_address;
    NSString *_endDate;
    
}

@property(nonatomic , retain) NSString *title;
@property(nonatomic , retain) NSString *date;
@property(nonatomic , retain) NSString *startTime;
@property(nonatomic , retain) NSString *endTime;
@property(nonatomic , retain) NSString *agendaSpeaker;
@property(nonatomic , retain) NSString *description;
@property(nonatomic , retain) NSString *address;
@property(nonatomic , retain) NSString *endDate;

@end


@implementation AgendaItem

@synthesize address = _address;
@synthesize date = _date;
@synthesize startTime = _startTime;
@synthesize endTime = _endTime;
@synthesize agendaSpeaker = _agendaSpeaker;
@synthesize description = _description;
@synthesize title = _title;
@synthesize endDate = _endDate;

-(id)initWithDict:(NSDictionary*)dict{
    self = [super init];
    
    if (self != nil) {
        
        self.title = [dict objectForKey:@"title"];
        self.description= [dict objectForKey:@"description"];
        self.date = [dict objectForKey:@"date"];
        self.startTime = [dict objectForKey:@"starttime"];
        self.endTime = [dict objectForKey:@"endtime"];
        self.agendaSpeaker = [dict objectForKey:@"agendaspeaker"];
        self.address = [dict objectForKey:@"address"];
        self.endDate = [dict objectForKey:@"enddate"];
        
    }
    return self;
}

@end

@implementation AgendaDetailsViewController

static AgendaItem *agendaItem;

@synthesize selectedDict;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
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


-(void)agendaSpeakerDetails
{
    asdvController = [[AgendaSpeakerDetailsViewController alloc] init];
    asdvController.selectedArray = speakersDetailsArray;
    [self.navigationController pushViewController:asdvController animated:YES];
}

-(void)initView
{
    float y = 0;
    
    UIFont *labelFont = [UIFont fontWithName:[Util detailTextFontName] size:15];
    UIColor *labelCOlor = [Util titleColor];
    UIFont *detailFont = [UIFont fontWithName:[Util subTitleFontName] size:14];
    
    CGSize size = [agendaItem.title sizeWithFont:[UIFont fontWithName:[Util titleFontName] size:16] constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10  , 10, 300, size.height+10)];
    titleLabel.font = [UIFont fontWithName:[Util titleFontName] size:16];
    titleLabel.textColor = [Util titleColor];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text  = agendaItem.title;
    titleLabel.numberOfLines = size.height/20;
    
   
    [scrollView addSubview:titleLabel];
     y = 10 + size.height + 10;
    
    UILabel *startLabel = [[UILabel alloc]initWithFrame:CGRectMake(20  , y, 91, 21)];
    startLabel.font = [UIFont fontWithName:[Util detailTextFontName] size:15];
    startLabel.textColor = labelCOlor;
    startLabel.textAlignment = UITextAlignmentCenter;
    startLabel.text=@" Start Date  :";
    startLabel.backgroundColor = [UIColor clearColor];
       [scrollView addSubview:startLabel];
    
    

    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(115  , y, 179, 21)];
    startLabel.font = detailFont;
    startLabel.textColor = [Util detailTextColor];
    startLabel.textAlignment = UITextAlignmentCenter;
    startLabel.text= agendaItem.date;
     startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    
    y = y+10 + 21;
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(20  ,y, 91, 21)];
    startLabel.font = labelFont;
    startLabel.textColor = labelCOlor;
    startLabel.textAlignment = UITextAlignmentCenter;
    startLabel.text=@" End Date  :";
     startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(115  , y, 179, 21)];
    startLabel.font = detailFont;
    startLabel.textColor = [Util detailTextColor];
    startLabel.textAlignment = UITextAlignmentCenter;
    startLabel.text= agendaItem.endDate;
     startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    
    y = y+10 + 21;
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(20  ,y, 91, 21)];
    startLabel.font = labelFont;
    startLabel.textColor = labelCOlor;
    startLabel.textAlignment = UITextAlignmentCenter;
    startLabel.text=@" Start time  :";
     startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(115  , y, 170, 21)];
    startLabel.font = detailFont;
    startLabel.textColor = [Util detailTextColor];
    startLabel.textAlignment = UITextAlignmentLeft;
    startLabel.text= agendaItem.startTime;
     startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    y = y+10 + 21;
    
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(20  ,y, 91, 21)];
    startLabel.font = labelFont;
    startLabel.textColor = labelCOlor;
    startLabel.textAlignment = UITextAlignmentCenter;
    startLabel.text=@" End time  :";
     startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(115 , y, 170, 21)];
    startLabel.font = detailFont;
    startLabel.textColor = [Util detailTextColor];
    startLabel.textAlignment = UITextAlignmentLeft;
    startLabel.text= agendaItem.endTime;
    startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    
    y = y+10 + 21;
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(20  ,y, 91, 21)];
    startLabel.font = labelFont;
    startLabel.textColor = labelCOlor;
    startLabel.textAlignment = UITextAlignmentCenter;
    startLabel.text=@"Address   :";
     startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(115 , y, 170, 90)];
    startLabel.font = detailFont;
    startLabel.textColor = [Util detailTextColor];
    startLabel.textAlignment = UITextAlignmentCenter;
    startLabel.text= agendaItem.address;
    startLabel.numberOfLines = 5;
      startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    y = y+10 + 90;
    
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(20  ,y, 170, 21)];
    startLabel.font = labelFont;
    startLabel.textColor = labelCOlor;
    startLabel.textAlignment = UITextAlignmentLeft;
    startLabel.text=@"Description  :";
      startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    agendaItem.description  = @"DESCRIPTION DESCRIPTION DESCRIPTION DESCRIPTION DESCRIPTION DESCRIPTION DESCRIPTION DESCRIPTION DESCRIPTION DESCRIPTION ";
    
    size= [agendaItem.description sizeWithFont:detailFont constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
   
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 ,y+30, 280, size.height +10)];
    startLabel.font = detailFont;
    startLabel.textColor = [Util detailTextColor];
    startLabel.textAlignment = UITextAlignmentCenter;
    startLabel.text= agendaItem.description;
    startLabel.numberOfLines = size.height/20 + 2;
     startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    [scrollView setContentSize:CGSizeMake(300, 300 + size.height + 50)];

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
    
    agendaItem = nil;
    
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;

                                    
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
    
    agendaItem = [[AgendaItem alloc]initWithDict:selectedDict];
    [self initView];
    
//    UITapGestureRecognizer *txtTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeaMap)];
//    [addressTxtView addGestureRecognizer:txtTapGesture];
//    addressTxtView.userInteractionEnabled = YES;
//
//    transparentImageView.frame = CGRectMake(30, 70, 260, 250);

    
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
