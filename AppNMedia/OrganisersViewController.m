//
//  OrganisersViewController.m
//  AppNMedia
//
//  Created by apple on 08/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "OrganisersViewController.h"
#import "AppNMediaAppDelegate.h"
#import "Organizer.h"
#import "OrganiserTableViewCell.h"
#import "Util.h"

#define kfunFactsTableCellHeight 80.0
@interface OrganisersViewController ()

@end

@implementation OrganisersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


#pragma mark Table View datasource and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (organisersArray != nil && [organisersArray count]>0)
    {
        return [organisersArray count];

    }
   
        return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Organizer *organizer  =[organisersArray objectAtIndex:indexPath.row];
    
    CGSize size = [organizer.title sizeWithFont:[CustomTableViewCell titleFont] constrainedToSize:CGSizeMake(120, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    ;
        
  
    
    int height = size.height + 40;
    
    if (height > kfunFactsTableCellHeight) {
        return height;
    }
    
    return kfunFactsTableCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   CustomTableViewCell *cell;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
        [cell setDefaultImage:nil];
        cell.textLabel.contentMode = UILineBreakModeCharacterWrap;
    }
        
//    NSMutableDictionary *tmpDict = [organisersArray objectAtIndex:indexPath.row];
    Organizer *organizer  =[organisersArray objectAtIndex:indexPath.row];

   
    
    cell.detailTextLabel.text = organizer.description;
    cell.textLabel.text = organizer.title;

    cell.detailTextLabel.numberOfLines = 2;
    
    CGSize size = [organizer.title sizeWithFont:[CustomTableViewCell titleFont] constrainedToSize:CGSizeMake(cell.textLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    cell.textLabel.numberOfLines = size.height/21+1;
    
    NSLog(@"WIDTH 1 =%f 2= %f ",cell.textLabel.frame.size.width,cell.detailTextLabel.frame.size.width);

    NSString *logo =   organizer.logo;
    if (logo != nil && ![logo isEqualToString:@""]) {
        
        NSMutableString *mainlogo = [NSMutableString stringWithString:BASE_URL];
        [mainlogo appendString:logo];
        NSLog(@" URL AT %d = %@  ", indexPath.row, mainlogo);
        [self loadImageAtIndexpath:indexPath urlString:mainlogo cell:cell];

    }else{
        
    }
 return cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     Organizer *organizer  =[organisersArray objectAtIndex:indexPath.row];

    if (organizer.weblink !=nil)
    {
        [self openUrl:organizer.weblink];
        
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    self.title = @"Organizers";
    organisersArray = [Organizer collection];
    NSLog(@"the organisers array = %@",organisersArray);
    
    organisersTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 10, 310, 270)];
    organisersTableView.dataSource = self;
    organisersTableView.delegate = self;
    organisersTableView.backgroundColor = [UIColor clearColor];
    organisersTableView.showsVerticalScrollIndicator = NO;
    organisersTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    organisersTableView.separatorColor = [UIColor clearColor];

    [self.view addSubview:organisersTableView];

}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)updateCell:(ImageLoader*)loader{
    [organisersTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:loader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}




@end
