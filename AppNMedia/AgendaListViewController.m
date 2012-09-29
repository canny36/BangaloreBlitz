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
#import "Util.h"
#import "Agenda.h"
#import "AgendaLoc.h"
#import "CustomTableViewCell.h"

#define kAgendaTableCellHeight 100.0

@implementation AgendaListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        
    }
    return self;
}

-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

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
        return 30;

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
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,25)] ;

    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"list_head_bg.png"]];
        Agenda *agenda = [agendaArray objectAtIndex:section];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 25)];
    dateLabel.backgroundColor = [UIColor clearColor];
    [dateLabel setFont:[UIFont fontWithName:[Util titleFontName] size:15]];
    dateLabel.textColor = [Util titleColor];
    dateLabel.text = agenda.date;
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
    Agenda *agenda = [agendaArray objectAtIndex:section];
    if (tableView == agendaTableView)
    {
        return [agenda.locArray count];
    }
   
       
}






- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
      return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
  CustomTableViewCell *cell;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier hideImageView:YES] ;
        
    }
    
    Agenda *agenda = [agendaArray objectAtIndex:indexPath.section];
    AgendaLoc *loc = [agenda.locArray objectAtIndex:indexPath.row];
    
    CGSize size =  [loc.address sizeWithFont:cell.textLabel.font constrainedToSize:CGSizeMake(cell.textLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    cell.textLabel.numberOfLines = size.height/21+1;
    cell.textLabel.text = loc.address;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
        Agenda *agenda = [agendaArray objectAtIndex:indexPath.section];
       AgendaLoc *loc = [agenda.locArray objectAtIndex:indexPath.row];
        AgendaViewController *controller = [[AgendaViewController alloc] init];

        controller.dateString = agenda.date;
        controller.loc = loc;
    
        [self.navigationController  pushViewController:controller animated:YES];

       
}

- (void)dealloc
{
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    
    agendaArray =   [Agenda collection];
    
    agendaTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, 310,300)];
    agendaTableView.delegate = self;
    agendaTableView.dataSource = self;
    agendaTableView.showsVerticalScrollIndicator = NO;
    agendaTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    agendaTableView.separatorColor = [UIColor clearColor];
    agendaTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:agendaTableView];
    
    
    if ([agendaArray count] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No details available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
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
