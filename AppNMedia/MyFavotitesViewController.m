//
//  MyFavotitesViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 06/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "MyFavotitesViewController.h"
#import "AppNMediaAppDelegate.h"
#import "MyFavoritesTableCell.h"
#import "MyFavoritesDetailsViewontroller.h"
#import "AgendaDetailsViewController.h"
#import "Util.h"

#define kmyFavoritesTableCellHeight 60

@implementation MyFavotitesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (NSString *)dataFilePathForMyfavoritesSpeakersInfo
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"myfavoriteSpeakers.plist"];
}
- (NSString *)dataFilePathForMyfavoritesAgendaInfo
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"myfavoriteAgenda.plist"];
}
-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(NSArray *)extractMethod:(NSInteger)value
{
    NSMutableDictionary *mainDic = [agendaArray objectAtIndex:value];
    id data =   [mainDic objectForKey:@"agendalocation"];
    
    array = [[NSMutableArray alloc]init];
    if([data isKindOfClass:[NSArray class]])
        [array addObjectsFromArray:data];
    
    if([data isKindOfClass:[NSDictionary class]])
        [array addObject:data];
    return array;
}


#pragma mark Table View datasource and delegate methods 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0)
    {
        return [selectedAgendaArr count];  
    }
    else
    {
        return [selectedSpeakersArr count]; 
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, 300, 30)];
    

    
    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"list_head_bg.png"]];
   
   
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 180, 30)];
    label.backgroundColor = [UIColor clearColor];
    [label setFont:[UIFont fontWithName:[Util titleFontName] size:15]];
    label.textColor = [Util titleColor];
    
    if (section ==0) 
    {
        label.text = @"Agenda";
    }
    else
    {
        label.text = @"Artists"; 
    }
    
    [headerView addSubview:label];
    
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 80;
    }
    else
    {
        return kmyFavoritesTableCellHeight;
   
    }
}


-(void)assignStyles
{
    titleFontName =@"Helvetica-Bold";
    titleFontSize = @"14";
    
    subTitleFontName =@"Helvetica";
    subTitleFontSize = @"12";
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CellIdentifier = [CellIdentifier stringByAppendingFormat:@"%d",indexPath.section];
    
    MyFavoritesTableCell *cell = (MyFavoritesTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    

    if (cell == nil) 
    {
        cell = [[MyFavoritesTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        
        cell.timeLabel.textColor = [Util detailTextColor];
        cell.titleLabel.textColor = [Util subTitleColor];
        
        cell.byLabel.textColor = [Util detailTextColor];
        
        
        [cell.timeLabel setFont:[UIFont fontWithName:[ Util detailTextFontName] size:12]];
        
        [cell.titleLabel setFont:[UIFont fontWithName:[Util subTitleFontName] size:14]];
        
        [cell.byLabel setFont:[UIFont fontWithName:[Util detailTextFontName] size:12]];
    }
    
    


    
    if (indexPath.section == 0)
    {


        ////
        NSMutableDictionary *tmpDict = [selectedAgendaArr  objectAtIndex:indexPath.row];
        
        NSString *dateStr = @"";
        
        if ([tmpDict objectForKey:@"date"]!= nil)
        {
            dateStr = [dateStr stringByAppendingString:[tmpDict objectForKey:@"date"]];
            dateStr = [dateStr stringByAppendingString:@" \n "];
        }
        if ([tmpDict objectForKey:@"starttime"] != nil)
        {
            dateStr = [dateStr stringByAppendingString:[tmpDict objectForKey:@"starttime"]];
            dateStr = [dateStr stringByAppendingString:@" - "];
            
        }
        
//        if ([tmpDict objectForKey:@"enddate"] != nil)
//        {
//            dateStr = [dateStr stringByAppendingString:[tmpDict objectForKey:@"enddate"]];
//            dateStr = [dateStr stringByAppendingString:@" "];
//            
//        }
        
        if ([tmpDict objectForKey:@"endtime"] != nil)
        {
            dateStr = [dateStr stringByAppendingString:[tmpDict objectForKey:@"endtime"]];
            
        }
        

        
        
        cell.timeLabel.text = dateStr;  
        cell.titleLabel.text = [tmpDict objectForKey:@"title"];
        if ([tmpDict objectForKey:@"agendaspeaker"]!= nil)
        {
            cell.byLabel.text =[NSString stringWithFormat:@"By : %@",[tmpDict objectForKey:@"agendaspeaker"]]; 
        }
    }
    else
    {
        cell.bgView.frame = CGRectMake(0, 3, 300, 55);
        cell.titleLabel.frame = CGRectMake(5, 0, 300, 40);
        cell.titleLabel.numberOfLines = 2;
        [cell.titleLabel setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];

        NSMutableDictionary *tmpDict = [selectedSpeakersArr objectAtIndex:indexPath.row];
        NSString *nameStr = [tmpDict objectForKey:@"firstname"];
        nameStr = [nameStr stringByAppendingString:@" "];
        
        if ([tmpDict objectForKey:@"lastname"] != nil)
        {
            nameStr = [nameStr stringByAppendingString:[tmpDict objectForKey:@"lastname"]];
        }
        cell.titleLabel.text = nameStr;

    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated: NO];
    
   MyFavoritesDetailsViewontroller *myFavoritesDetailsViewController = [[MyFavoritesDetailsViewontroller alloc] init];
    
    if (indexPath.section == 0)
    {
//        myFavoritesDetailsViewController.agendaSelected = YES; 
//        myFavoritesDetailsViewController.selectedDict = [selectedAgendaArr objectAtIndex:indexPath.row];
        
        AgendaDetailsViewController *advc = [[AgendaDetailsViewController alloc] init];
        advc.selectedDict = [selectedAgendaArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:advc animated:YES];

        
    }
    else
    {
      myFavoritesDetailsViewController.agendaSelected = NO;  
        myFavoritesDetailsViewController.selectedDict = [selectedSpeakersArr objectAtIndex:indexPath.row];
        myFavoritesDetailsViewController.selectedIndex = [[selectedIndexArr objectAtIndex:indexPath.row] intValue];
        [self.navigationController pushViewController:myFavoritesDetailsViewController animated:YES];

    }
    
//    [myFavoritesDetailsViewController release];
     
    [myFavoritesTableView reloadData];
}



- (void)dealloc
{
//    [super dealloc];
//    [selectedAgendaArr release];
//    [selectedSpeakersArr release];
//    [selectedIndexArr release];
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
    self.title = @"My Favorites";
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;

    selectedAgendaArr = [[NSMutableArray alloc] initWithCapacity:0];
    selectedSpeakersArr = [[NSMutableArray alloc] initWithCapacity:0];
    selectedIndexArr = [[NSMutableArray alloc] initWithCapacity:0];
   
  
    NSMutableArray *speakersArray = [[NSMutableArray alloc] initWithCapacity:0];
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"speakerslist"] objectForKey:@"speaker"] isKindOfClass:[NSDictionary class]]) 
    {
        [speakersArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"speakerslist"] objectForKey:@"speaker"]];
    }
    else
    {
        [speakersArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"speakerslist"] objectForKey:@"speaker"]];
    }    
    
    
    NSString *speakerFilePath = [self dataFilePathForMyfavoritesSpeakersInfo];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:speakerFilePath])
    {
        NSMutableArray *tmpArr = [[NSMutableArray alloc]initWithContentsOfFile:speakerFilePath];
        
        for (int i = 0; i <[tmpArr count]; i++)
        {
            NSString *tmpIdStr = [tmpArr objectAtIndex:i];
            for (int j=0; j<[speakersArray count]; j++)
            {
                NSMutableDictionary *tmpDict = [speakersArray objectAtIndex:j];
                NSString *speakerIdStr = @"";
                if ([tmpDict objectForKey:@"speakerid"]!= nil)
                {
                    speakerIdStr = [tmpDict objectForKey:@"speakerid"];
                    
                }
                
                if ([speakerIdStr  isEqualToString:tmpIdStr])
                {
                    [selectedSpeakersArr addObject:tmpDict];
                    [selectedIndexArr addObject:[NSString stringWithFormat:@"%d",j]];
                }
               
            }
            
     
        }
        
//        [tmpArr release];
        
    }
    
//    [speakersArray release];
    
    
   agendaArray =[[NSMutableArray alloc] initWithCapacity:0];
    
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"agendalist"] objectForKey:@"agenda"] isKindOfClass:[NSDictionary class]]) 
    {
        [agendaArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"agendalist"] objectForKey:@"agenda"]];
    }
    else
    {
        [agendaArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"agendalist"] objectForKey:@"agenda"]];
    }   

    itemsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i=0; i<[agendaArray count]; i++)
    {
          NSArray *array1 = [self extractMethod:i];
        for (int i=0; i<[array1 count]; i++)
        {
            NSMutableDictionary *selectedAgendaLocation = [array1 objectAtIndex:i];
            id items = [selectedAgendaLocation objectForKey:@"item"];
            
            if([items isKindOfClass:[NSDictionary class]])
                [itemsArray addObject:items];
            
            if([items isKindOfClass:[NSArray class]])
                [itemsArray addObjectsFromArray:items];
        }
        
        
    }
    
    
    NSString *agendaFilePath = [self dataFilePathForMyfavoritesAgendaInfo];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:agendaFilePath])
    {
        NSMutableArray *tmpArr = [[NSMutableArray alloc]initWithContentsOfFile:agendaFilePath];
        
        for (int i = 0; i <[tmpArr count]; i++)
        {
            NSString *tmpIdStr = [tmpArr objectAtIndex:i];
            for (int j=0; j<[itemsArray count]; j++)
            {
                NSMutableDictionary *tmpDict = [itemsArray objectAtIndex:j];
                NSString *agendaIdStr = @"";
                if ([tmpDict objectForKey:@"agendaid"]!= nil)
                {
                    agendaIdStr = [tmpDict objectForKey:@"agendaid"];
                    
                }
                
                if ([agendaIdStr  isEqualToString:tmpIdStr])
                {
                    [selectedAgendaArr addObject:tmpDict];
                }
                
            }
            
            
        }
        
//        [tmpArr release];
        
    }

    
//    [agendaArray release];
//    [itemsArray release];
    
//    int k = [selectedAgendaArr count]+[selectedSpeakersArr count] ;
//    int height = k * kmyFavoritesTableCellHeight;
//    height = height+100;
//    if (height > 270)
//    {
//        height = 270;
//    }
    
    myFavoritesTableView =[[UITableView alloc] initWithFrame:CGRectMake(10, 10, 300, 270)];
    myFavoritesTableView.dataSource= self;
    myFavoritesTableView.delegate = self;
    myFavoritesTableView.backgroundColor = [UIColor clearColor];
    myFavoritesTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myFavoritesTableView.separatorColor=[UIColor clearColor];
    myFavoritesTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myFavoritesTableView];
    [subBgView setFrame:CGRectMake(5, 5, 310, 280)];
    
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
