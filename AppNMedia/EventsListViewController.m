//
//  EventsListViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "EventsListViewController.h"
#import "AppNMediaAppDelegate.h"
#import "EventsTableCell.h"
#import "EventsParserClass.h"
#import "MainViewController.h"
#define kEventsTableCellHeight 50
@implementation EventsListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)assignStyles
{
    
    titleFontName =@"Helvitica-Bold";
    titleFontSize = @"14";
    subTitleFontName = @"Helvitica";
    subTitleFontSize = @"12";
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [appDelegate.eventsArray count];
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kEventsTableCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventsTableCell *cell;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (EventsTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[EventsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        
//        NSMutableDictionary *tmpDict = [appDelegate.eventsArray objectAtIndex:indexPath.row];
//        cell.textLabel.text = [tmpDict objectForKey:@"eventtitle"];
//        
//        [cell.textLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
//        int r,g,b;
//        r= [[[appDelegate.customStylesDict objectForKey:@"listHeadingFontColor"] objectForKey:@"r"] intValue];
//        g= [[[appDelegate.customStylesDict objectForKey:@"listHeadingFontColor"] objectForKey:@"g"] intValue];
//        b= [[[appDelegate.customStylesDict objectForKey:@"listHeadingFontColor"] objectForKey:@"b"] intValue];
//        
//        cell.textLabel.backgroundColor = [UIColor clearColor];
//        cell.backgroundColor = [UIColor clearColor];
//        cell.textLabel.textColor = [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:1];
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    appDelegate.selectedEvent = indexPath.row;
    if(indexPath.row < [appDelegate.allEventsInfoArray count])
    {
        appDelegate.mainResponseDict = [appDelegate.allEventsInfoArray objectAtIndex:indexPath.row];
        
        mainViewController = [[MainViewController alloc] init];
        [self.navigationController pushViewController:mainViewController animated:YES];
        [appDelegate createCommonUI];

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Loading..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    
    
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
    
//    int height = [appDelegate.eventsArray count] * kEventsTableCellHeight;
//    
//    if (height > 380)
//    {
//        height = 380;
//    }
//    
    
    
//    eventsTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, 300, height)];
//    eventsTableView.dataSource = self;
//    eventsTableView.delegate = self;
//    eventsTableView.backgroundColor = [UIColor clearColor];
//    eventsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:eventsTableView];
//   
//    [subBgView setFrame:CGRectMake(5, 5, 310, height+15)];
    [self assignStyles];
    
    self.title = @"EVENTS LIST";
    
    
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
