//
//  AgendaViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "AgendaViewController.h"
#import "AppNMediaAppDelegate.h"
#import "AgendaTableViewCell.h"
#import "AgendaDetailsViewController.h"

#define kAgendaTableCellHeight 100.0
@implementation AgendaViewController
@synthesize selectedAgendaLocation;
@synthesize fromWhichSection;
@synthesize sampleArray;
@synthesize dateString;
@synthesize fromWhichRow;

- (NSString *)dataFilePathForMyfavoritesAgendaInfo
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"myfavoriteAgenda.plist"];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)addOrDeleteFromMyFavorites:(int )selectedIndex checkMark:(BOOL)checkMark
{
    
    NSString *filePath = [self dataFilePathForMyfavoritesAgendaInfo];
    
    if (([[NSFileManager defaultManager] fileExistsAtPath:filePath])) 
    {
        myFavIndexesArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    }
    else
    {
        myFavIndexesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    
    if (checkMark ==YES)
    {
        NSMutableDictionary *tmpDict = [itemsArray objectAtIndex:selectedIndex];
        
        if ([tmpDict objectForKey:@"agendaid"]!= nil)
        {
            [myFavIndexesArray addObject:[tmpDict objectForKey:@"agendaid"]];
            [myFavAgendaArray addObject:[tmpDict objectForKey:@"agendaid"]];
        } 
    }
    else
    {
        if ([myFavIndexesArray count]>0)
        {
            NSMutableDictionary *tmpDict = [itemsArray objectAtIndex:selectedIndex];
            
            NSString *speakerIdStr = @"";
            if ([tmpDict objectForKey:@"agendaid"]!= nil)
            {
                speakerIdStr = [tmpDict objectForKey:@"agendaid"];
                
            }
            
            for (int i=0; i<[myFavIndexesArray count]; i++)
            {
                NSString *tmpStr = [myFavIndexesArray objectAtIndex:i];
                if ([tmpStr isEqualToString:speakerIdStr])
                {
                    [myFavIndexesArray removeObjectAtIndex:i];
                    [myFavAgendaArray removeObjectAtIndex:i];
                }
                
            }
        }
     
    }
    
    
    [myFavIndexesArray writeToFile:filePath atomically:YES];
    
}


#pragma mark Table View datasource and delegate methods   

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == agendaTableView)
    {
        return 60;
    }
    else
    {
        return 0;
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
    if (tableView == agendaTableView) 
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width - 5,30)] ;
        [headerView.layer setCornerRadius:2.0f];
        [headerView.layer setBorderWidth:0.1f];
        
        UIImage *bgImage = [UIImage imageNamed:@"list_head_bg.png"];
        
        headerView.backgroundColor = [UIColor clearColor];
        headerView.layer.backgroundColor = [UIColor colorWithPatternImage:bgImage].CGColor;
        
        NSMutableDictionary *tmpDict = [selectedAgendaLocation objectForKey:@"attributes"];
        
        
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 270, 10)];
        dateLabel.backgroundColor = [UIColor clearColor];
        [dateLabel setFont:[UIFont systemFontOfSize:15]];
         dateLabel.textColor = [UIColor whiteColor];
        dateLabel.text = dateString;
        [headerView addSubview:dateLabel];
        
        UITextView *addressTxtView = [[UITextView alloc] initWithFrame:CGRectMake(10, 15, 270, 40)];
        addressTxtView.backgroundColor = [UIColor clearColor];
        [addressTxtView setFont:[UIFont systemFontOfSize:15]];
        addressTxtView.editable = NO;
        addressTxtView.userInteractionEnabled = NO;
        addressTxtView.textColor = [UIColor whiteColor];
        addressTxtView.text = [tmpDict objectForKey:@"address"];
        [headerView addSubview:addressTxtView];
        
        
        return headerView;
        
    }
    else
    {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] ;
    return headerView;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [agendaArray count];
    if (tableView == agendaTableView)
    {
        return [itemsArray count];

    }
    else
    {
        return [searchArr count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kAgendaTableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AgendaTableViewCell *cell;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (AgendaTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[AgendaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    [cell.agendaNameLabel setFont:[UIFont systemFontOfSize:15]];
    
    [cell.byLabel setFont: [UIFont systemFontOfSize:13]];

    [cell.agendaDetailsLabel setFont:[UIFont systemFontOfSize:14]];
    
    cell.agendaDetailsLabel.textColor = [UIColor whiteColor];
    cell.byLabel.textColor = [UIColor whiteColor];

    if (tableView == agendaTableView)
    {
               
        NSMutableDictionary *tmpDict = [itemsArray objectAtIndex:indexPath.row];
    
        NSString *dateStr = @"";
        
        if ([tmpDict objectForKey:@"date"]!= nil)
        {
            dateStr = [dateStr stringByAppendingString:[tmpDict objectForKey:@"date"]];
            dateStr = [dateStr stringByAppendingString:@" "];
        }
        if ([tmpDict objectForKey:@"starttime"] != nil)
        {
            dateStr = [dateStr stringByAppendingString:[tmpDict objectForKey:@"starttime"]];
            dateStr = [dateStr stringByAppendingString:@" to\n"];
            
        }
        
        if ([tmpDict objectForKey:@"enddate"] != nil)
        {
            dateStr = [dateStr stringByAppendingString:[tmpDict objectForKey:@"enddate"]];
            dateStr = [dateStr stringByAppendingString:@" "];
            
        }
        
        if ([tmpDict objectForKey:@"endtime"] != nil)
        {
            dateStr = [dateStr stringByAppendingString:[tmpDict objectForKey:@"endtime"]];
            
        }

        
        cell.agendaNameLabel.text = dateStr;
        
        //cell.agendaNameLabel.text = [tmpDict objectForKey:@"agendaspeaker"];
        cell.agendaDetailsLabel.text = [tmpDict objectForKey:@"title"];
        if ([tmpDict objectForKey:@"agendaspeaker"]!= nil)
        {
            cell.byLabel.text =[NSString stringWithFormat:@"By : %@",[tmpDict objectForKey:@"agendaspeaker"]]; 
        }
               
        cell.agendaViewController= self;
        cell.selectButton.tag = indexPath.row;
        cell.selectedSection = indexPath.section;
        if ([myFavAgendaArray count]>0)                
        {
            for (int i=0; i<[myFavAgendaArray count]; i++)
            {
                NSString *tmpIdStr = [myFavAgendaArray objectAtIndex:i];
                NSString *speakerIdStr = @"";
                if ([tmpDict objectForKey:@"agendaid"] != nil)
                {
                    speakerIdStr = [tmpDict objectForKey:@"agendaid"];
                }
                
                if ([speakerIdStr isEqualToString:tmpIdStr])
                {
                    [cell.selectButton setImage:[UIImage imageNamed:@"gold_star.png"] forState:UIControlStateNormal];
                    cell.buttonSelected = YES;
                    i = [myFavAgendaArray count];
                }
                else
                {
                    [cell.selectButton setImage:[UIImage imageNamed:@"gray_star.png"] forState:UIControlStateNormal];
                    cell.buttonSelected = NO; 
                }
                
            }
            
            
            
        }        
        

        
    }
    else
    {
        if ([searchArr count] >0) 
        {
            NSMutableDictionary *tmpDict = [searchArr objectAtIndex:indexPath.row];
            
            [cell.agendaNameLabel setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];
            
            cell.agendaNameLabel.text = [tmpDict objectForKey:@"starttime"];  
            cell.agendaDetailsLabel.text = [tmpDict objectForKey:@"title"];
            if ([tmpDict objectForKey:@"agendaspeaker"]!= nil)
            {
                cell.byLabel.text =[NSString stringWithFormat:@"By : %@",[tmpDict objectForKey:@"agendaspeaker"]]; 
            }
            cell.selectButton.hidden = YES;
        }
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AgendaDetailsViewController *agendaDetailsViewController = [[AgendaDetailsViewController alloc] init];

    if (tableView == agendaTableView)
    {
        
        agendaDetailsViewController.selectedDict = [itemsArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:agendaDetailsViewController animated:YES];
    }
    else
    {
        agendaDetailsViewController.selectedDict = [searchArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:agendaDetailsViewController animated:YES];
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
-(void)viewWillDisappear:(BOOL)animated
{
       
     
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.title = @"Selected Agenda";
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;
    
    itemsArray = [[NSMutableArray alloc] initWithCapacity:0];
    myFavIndexesArray = [[NSMutableArray alloc] initWithCapacity:0];
    
       
    id items = [selectedAgendaLocation objectForKey:@"item"];
    
    if([items isKindOfClass:[NSDictionary class]])
        [itemsArray addObject:items];
    
    if([items isKindOfClass:[NSArray class]])
        [itemsArray addObjectsFromArray:items];

    
    NSString *filePath = [self dataFilePathForMyfavoritesAgendaInfo];
    
    if (([[NSFileManager defaultManager] fileExistsAtPath:filePath])) 
    {
        myFavAgendaArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    }
    else
    {
        myFavAgendaArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
        
    if ([selectedAgendaLocation count] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No details available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
        
    int height  = kAgendaTableCellHeight * [itemsArray count] + 60 ;
    
    if (height > 220)
    {
        height = 220;
    }

    agendaTableView.showsVerticalScrollIndicator = NO;
    
    
    //[subBgView setFrame:CGRectMake(5, 5, 310, 280)];
  
    for (UIView *view in agendaSearchBar.subviews)
    {
        if ([view isKindOfClass: [UITextField class]]) 
        {
            UITextField *tf = (UITextField *)view;
            tf.delegate = self;
            break;
        }
    }
    
    CGRect frame = 
     agendaTableView.frame;
    
    searchTableView =[[UITableView alloc] initWithFrame:frame];
    searchTableView.dataSource= self;
    searchTableView.delegate = self;
    searchTableView.backgroundColor = [UIColor clearColor];
    searchTableView.showsVerticalScrollIndicator = NO;
    [searchTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:searchTableView];

    [agendaSearchBar setShowsCancelButton:YES animated:YES];

    transparentImageView.frame = CGRectMake(30, 70, 260, 250);
    
    [self.view bringSubviewToFront:agendaTableView];
        
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

#pragma mark - searchBar
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) aSearchBar 
{
    [agendaSearchBar resignFirstResponder];
    agendaTableView.hidden = NO;
    CGRect viewFrame1 = agendaTableView.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration: 0.7];
    [searchTableView setFrame:viewFrame1];
    [UIView commitAnimations]; 

}
- (BOOL)textFieldShouldClear:(UITextField *)textField 
{
    agendaTableView.hidden = NO;
    CGRect viewFrame1 = agendaTableView.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration: 0.7];
    [searchTableView setFrame:viewFrame1];
    [UIView commitAnimations]; 
    return YES;
}



////////////// searchBar
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
   return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchString = searchBar.text;
    [self mainSearchMethod];
}
-(void)mainSearchMethod
{
    
    
    if (searchArr != nil)
    {
        [searchArr removeAllObjects];
    }
    else
    {
        searchArr = [[NSMutableArray alloc] initWithCapacity:0]; 
        
    }    
                
    for (int i=0; i<[itemsArray count]; i++)
    {
        NSMutableDictionary *tmpDic = [itemsArray objectAtIndex:i];
        

            if ([tmpDic objectForKey:@"agendaspeaker"] != nil) 
            {
                if ([[tmpDic objectForKey:@"agendaspeaker"] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound)   
                {
                    
                    [searchArr addObject:tmpDic];
                    continue;
                    
                }

            }
            
            
            if ([tmpDic objectForKey:@"address"] != nil) 
            {
                if ([[tmpDic objectForKey:@"address"] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound)   
                {
                    
                    [searchArr addObject:tmpDic];
                    continue;
                    
                }
            }
            
            
            if ([tmpDic objectForKey:@"room"] != nil) 
            {
                if ([[tmpDic objectForKey:@"room"] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound)   
                {
                    
                    [searchArr addObject:tmpDic];
                    continue;
                    
                }
            }
            
            
            
            if ([tmpDic objectForKey:@"description"] != nil) 
            {
                if ([[tmpDic objectForKey:@"description"] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound)   
                {
                    
                    [searchArr addObject:tmpDic];
                    continue;
                    
                }
            }
            
            
            if ([tmpDic objectForKey:@"title"] != nil) 
            {
                if ([[tmpDic objectForKey:@"title"] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound)   
                {
                    
                    [searchArr addObject:tmpDic];
                    continue;
                    
                }
            }
            
    }
    
    [self createSearchTable];    
    
}
-(void)createSearchTable
{
    if ([searchArr count]>0)
    {
        agendaTableView.hidden = YES;
        [searchTableView reloadData];
        int height  = kAgendaTableCellHeight * [searchArr count];
        if (height > 220)
        {
            height = 220;
        }

        CGRect viewFrame1 = CGRectMake(10, 60, 300, height);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration: 0.7];
        [searchTableView setFrame:viewFrame1];
        [UIView commitAnimations]; 
    }
    else
    {
        [searchTableView reloadData];
        CGRect viewFrame1 = CGRectMake(10, 500, 300, 200);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration: 0.7];
        [searchTableView setFrame:viewFrame1];
        [UIView commitAnimations]; 

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No results found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        agendaTableView.hidden = NO;
    }

    
}



@end
