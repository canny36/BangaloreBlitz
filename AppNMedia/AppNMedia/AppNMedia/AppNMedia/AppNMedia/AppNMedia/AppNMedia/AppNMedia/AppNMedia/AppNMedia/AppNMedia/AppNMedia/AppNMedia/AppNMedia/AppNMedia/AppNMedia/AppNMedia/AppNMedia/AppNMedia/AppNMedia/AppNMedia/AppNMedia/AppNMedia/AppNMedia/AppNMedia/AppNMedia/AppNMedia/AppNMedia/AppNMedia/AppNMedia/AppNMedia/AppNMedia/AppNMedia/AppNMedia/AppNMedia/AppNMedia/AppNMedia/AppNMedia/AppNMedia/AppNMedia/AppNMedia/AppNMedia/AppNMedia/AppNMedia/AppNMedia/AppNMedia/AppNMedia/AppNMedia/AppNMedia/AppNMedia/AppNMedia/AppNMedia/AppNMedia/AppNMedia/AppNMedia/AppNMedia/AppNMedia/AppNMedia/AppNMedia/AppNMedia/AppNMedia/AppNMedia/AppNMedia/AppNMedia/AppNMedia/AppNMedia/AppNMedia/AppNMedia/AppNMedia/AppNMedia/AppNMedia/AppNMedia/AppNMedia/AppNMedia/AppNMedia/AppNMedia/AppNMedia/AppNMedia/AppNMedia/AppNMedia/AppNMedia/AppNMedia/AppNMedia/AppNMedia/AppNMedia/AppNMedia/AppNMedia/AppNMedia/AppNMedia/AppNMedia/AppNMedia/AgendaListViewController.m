//
//  AgendaListViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 22/05/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "AgendaListViewController.h" 
#import "AgnedaListTableViewCell.h"
#import "AgendaViewController.h"
#import "AppNMediaAppDelegate.h"
#import "AgendaDetailsViewController.h"
#define kAgendaTableCellHeight 60.0

@implementation AgendaListViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}
-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//-(void)assignStyles
//{
//    
//    titleFontName =[appDelegate.customStylesDict objectForKey:@"listHeadingFontName"];
//    titleFontSize = [appDelegate.customStylesDict objectForKey:@"listHeadingFontSize"];
//    subTitleFontName =[appDelegate.customStylesDict objectForKey:@"listContentFontName"];
//    subTitleFontSize = [appDelegate.customStylesDict objectForKey:@"listContentFontSize"];
//    mainBgView.image = [UIImage imageWithData:[appDelegate.customStylesDict objectForKey:@"bgImageData"]];
//    subBgView.image = [UIImage imageWithData:[appDelegate.customStylesDict objectForKey:@"subBgImageData"]];
//    transparentImageView.image = [UIImage imageWithData:[appDelegate.customStylesDict objectForKey:@"transparentImageData"]];
//
//    
//}
#pragma mark Table View datasource and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == agendaTableView)
    {
        return [agendaArray count];
    }
    else
    {
        return  1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == agendaTableView)
    {
        return 35;

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
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 30)] ;
    
    [headerView.layer setCornerRadius:10.0f];
    [headerView.layer setBorderWidth:0.1f];
    [headerView.layer setCornerRadius:15.0f];
        UIImage *bgImage = [UIImage imageNamed:@"list_head_bg.png"];
    headerView.backgroundColor = [UIColor clearColor];
    headerView.layer.backgroundColor = [UIColor colorWithPatternImage:bgImage].CGColor;

    
    //NSMutableDictionary *tmpDict = [agendaArray objectAtIndex:section];
    NSMutableDictionary *tmpDict1 = [agendaArray objectAtIndex:section];
    NSMutableDictionary *tmpDict = [tmpDict1 objectForKey:@"attributes"];
    //NSLog(@"%@",tmpDict);
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 25)];
    dateLabel.backgroundColor = [UIColor clearColor];
    [dateLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.text = [tmpDict objectForKey:@"date"];
    [headerView addSubview:dateLabel];
    
   
    return headerView;
    }
    else
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
        return headerView;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [agendaArray count];
   // return 1;
    
    if (tableView == agendaTableView)
    {
        if(section < [agendaArray count])
        {
            return [[self extractMethod:section]count];
            
        }
        else
        {
            return 0;
        }
    }
   
    else
    {
        return [searchArr count];
    }
    
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




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kAgendaTableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AgnedaListTableViewCell *cell;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (AgnedaListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[AgnedaListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
              
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.agendaNameTxtView.textColor = [UIColor whiteColor];
    
    [cell.agendaNameTxtView setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];
    
    if (tableView == agendaTableView )
    {
        NSArray *array1 = [self extractMethod:indexPath.section];
        cell.agendaNameTxtView.text = [[array1 objectAtIndex:indexPath.row]valueForKeyPath:@"attributes.address"];
    }
    else
    {
        if ([searchArr count] >0) 
        {
            NSMutableDictionary *tmpDict = [searchArr objectAtIndex:indexPath.row];
            
            [cell.agendaNameTxtView setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];
            
            cell.agendaNameTxtView.text = [tmpDict objectForKey:@"title"];            
        } 
    }

    
   
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == agendaTableView)
    {
        agendaViewController = [[AgendaViewController alloc] init];
        NSArray *array1 = [self extractMethod:indexPath.section];
        
        NSMutableDictionary *tmpDict1 = [agendaArray objectAtIndex:indexPath.section];
        NSMutableDictionary *tmpDict = [tmpDict1 objectForKey:@"attributes"];
        agendaViewController.dateString = [tmpDict objectForKey:@"date"];
        agendaViewController.selectedAgendaLocation = [array1 objectAtIndex:indexPath.row];
        agendaViewController.fromWhichRow =indexPath.row;
        agendaViewController.fromWhichSection = indexPath.section;
        [self.navigationController  pushViewController:agendaViewController animated:YES];
//        [agendaViewController release];
    }
    else
    {
        AgendaDetailsViewController *agendaDetailsViewController = [[AgendaDetailsViewController alloc] init];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.  
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];


    self.title = @"Agenda";
    
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;
    
    agendaArray =[[NSMutableArray alloc] initWithCapacity:0];
    
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"agendalist"] objectForKey:@"agenda"] isKindOfClass:[NSDictionary class]]) 
    {
        [agendaArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"agendalist"] objectForKey:@"agenda"]];
    }
    else
    {
        [agendaArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"agendalist"] objectForKey:@"agenda"]];
    }   
    

    
    int height  = kAgendaTableCellHeight * [agendaArray count] + 35 *[agendaArray count] ;
    if (height > 220)
    {
        height = 220;
    }
    agendaTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 60, 300, height)];
    agendaTableView.delegate = self;
    agendaTableView.dataSource = self;
    agendaTableView.showsVerticalScrollIndicator = NO;
    agendaTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    agendaTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:agendaTableView];
    
    [subBgView setFrame:CGRectMake(5, 5, 310, 280)];
    
    if ([agendaArray count] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No details available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

    [agendaSearchBar setShowsCancelButton:YES animated:YES];

    for (UIView *view in agendaSearchBar.subviews)
    {
        if ([view isKindOfClass: [UITextField class]]) 
        {
            UITextField *tf = (UITextField *)view;
            tf.delegate = self;
            break;
        }
    }
    
    searchTableView =[[UITableView alloc] initWithFrame:CGRectMake(10, 500, 300, 200)];
    searchTableView.dataSource= self;
    searchTableView.delegate = self;
    searchTableView.backgroundColor = [UIColor clearColor];
    searchTableView.showsVerticalScrollIndicator = NO;
    [searchTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:searchTableView];
    //transparentImageView.frame = CGRectMake(30, 70, 260, 250);


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
    CGRect viewFrame1 = CGRectMake(10, 500, 300, 200);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration: 0.7];
    [searchTableView setFrame:viewFrame1];
    [UIView commitAnimations]; 
    
}
- (BOOL)textFieldShouldClear:(UITextField *)textField 
{
    agendaTableView.hidden = NO;
    CGRect viewFrame1 = CGRectMake(10, 500, 300, 200);
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
