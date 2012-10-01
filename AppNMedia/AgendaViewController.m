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
#import "Util.h"
#import "AgendaItem.h"
#import "SubAgendaViewController.h"

@interface CellItem : NSObject{
    
    NSString *_title;
    NSString *_subTitle;
    
}

@property(retain,readwrite)NSString *title;
@property(retain,readwrite)NSString *subTitle;

@end

@implementation CellItem

@synthesize title = _title;
@synthesize subTitle = _subTitle;

@end

#define kAgendaTableCellHeight 80.0

@implementation AgendaViewController

@synthesize dateString=_dateString;
@synthesize loc=_loc;

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



#pragma mark Table View datasource and delegate methods   

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width - 5,25)] ;
          UIImage *bgImage = [UIImage imageNamed:@"list_head_bg.png"];
        
        bgImage = [bgImage stretchableImageWithLeftCapWidth:bgImage.size.width topCapHeight:bgImage.size.height-1];
        headerView.backgroundColor = [UIColor colorWithPatternImage:bgImage];
        
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 270, 13)];
        dateLabel.backgroundColor = [UIColor clearColor];
        [dateLabel setFont:[UIFont fontWithName:[Util titleFontName] size:15]];
         dateLabel.textColor = [Util titleColor];
        dateLabel.text = self.dateString;
        [headerView addSubview:dateLabel];
       
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
    return ( tableView == agendaTableView ) ?  [self.loc.itemArray count] : [searchArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AgendaItem *item = nil ;
    
    if (tableView == agendaTableView) {
        item =  [self.loc.itemArray objectAtIndex:indexPath.row];
    }else{
        item = [searchArr objectAtIndex:indexPath.row];
    }
    
    int calHeight = [self heightForItem:item];
    if ( calHeight > kAgendaTableCellHeight) {
        return calHeight;
    }
    
    return kAgendaTableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AgendaTableViewCell *cell;
    NSString *CellIdentifier = @"agenda identifier";
    cell = (AgendaTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[AgendaTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier hideImageView:YES];
        cell.imageView.image = nil;
        [cell enableBookmarkWithTarget:self];
    }
    
    AgendaItem *item = nil ;
    cell.imageView.image = nil;

    if (tableView == agendaTableView) {
       item =  [self.loc.itemArray objectAtIndex:indexPath.row];
    }else{
       item = [searchArr objectAtIndex:indexPath.row];
    }
    
     [self cellWithAgendaItem:item:cell];
        cell.accessoryView.tag = indexPath.row;
       BOOL selected = [self checkIfFavorite:item];
       [cell selectFavorite:selected];
    
        return cell;
}

    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    AgendaDetailsViewController *agendaDetailsViewController = [[AgendaDetailsViewController alloc] init];
    AgendaItem *item = [ tableView == agendaTableView ? self.loc.itemArray  : searchArr objectAtIndex:indexPath.row];

        
        if (item.subAgendaItems != nil  && [item.subAgendaItems count ] > 0) {
            SubAgendaViewController *controller = [[SubAgendaViewController alloc]init];
            controller.subAgendaArray = item.subAgendaItems;
            [self.navigationController pushViewController:controller animated:YES];
        }else{
            AgendaDetailsViewController *controller = [[AgendaDetailsViewController alloc]init];
            controller.agendaItem = item;
            [self.navigationController pushViewController:controller animated:YES];
        }
}


-(int)heightForItem:(AgendaItem*)item{
    
    NSString *dateStr = @"";
    
    if (item.startTime != nil)
    {
        dateStr = [dateStr stringByAppendingString:@" \n "];
        dateStr = [dateStr stringByAppendingString:item.startTime];
        
    }
    
    if (item.endTime != nil)
    {
        dateStr = [dateStr stringByAppendingString:@" - "];
        dateStr = [dateStr stringByAppendingString:item.endTime];
    }
    
    
    CGSize size1 = [item.title sizeWithFont:[UIFont fontWithName:[Util subTitleFontName] size:15] constrainedToSize:CGSizeMake(230 ,MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    
    CGSize size2 = [dateStr sizeWithFont:[UIFont fontWithName:[Util detailTextFontName] size:13] constrainedToSize:CGSizeMake(230, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    return size1.height + size2.height +10;
    
}

-(void)cellWithAgendaItem:(AgendaItem*)item:(CustomTableViewCell*)cell{
    NSString *dateStr = @"";
    
    if (item.startTime != nil)
    {
        dateStr = [dateStr stringByAppendingString:@" \n "];
        dateStr = [dateStr stringByAppendingString:item.startTime];
        
    }
    
    if (item.endTime != nil)
    {
        dateStr = [dateStr stringByAppendingString:@" - "];
        dateStr = [dateStr stringByAppendingString:item.endTime];
    }
    
    
    CGSize size = [item.title sizeWithFont:cell.textLabel.font constrainedToSize:CGSizeMake(cell.textLabel.frame.size.width ,MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    int lines = size.height/21+1;
    
    cell.textLabel.text = item.title;
    cell.textLabel.numberOfLines = lines;
    
    
    size = [dateStr sizeWithFont:cell.detailTextLabel.font constrainedToSize:CGSizeMake(cell.detailTextLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    
   cell.detailTextLabel.text = dateStr;
    lines = size.height/20;
    cell.detailTextLabel.numberOfLines = lines > 2 ? lines : 2;
    
    
    
}


-(void)onFavoriteSelection:(UIButton*)sender{
    
    int tag = sender.tag;
    
    AgendaItem *info  = [self.loc.itemArray objectAtIndex:tag];
    NSLog(@"BOOKMARK C=BUTTON CLICK %@ ",info.agendaId);
    if (searchTableView.hidden == NO) {
        info = [searchArr objectAtIndex:tag];
    }
    
    if (sender.selected) {
        if ([myFavAgendaArray indexOfObject:info.agendaId] == NSNotFound) {
            [myFavAgendaArray addObject:info.agendaId];
        }
        
    }else{
        if ([myFavAgendaArray indexOfObject:info.agendaId] != NSNotFound) {
            [myFavAgendaArray removeObject:info.agendaId];
        }
    }
}



-(BOOL)checkIfFavorite:(AgendaItem*)info{
    
    if ([myFavAgendaArray indexOfObject:info.agendaId] != NSNotFound) {
        return YES;
    }
    return NO;
}

-(void)saveFavorites{
    
    NSString *filePath = [self dataFilePathForMyfavoritesAgendaInfo];
    
    NSLog(@"SAVE FAVORITES =  %@ ",myFavAgendaArray);
    [myFavAgendaArray writeToFile:filePath atomically:YES];

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
       [self saveFavorites];
     
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.title = @"Agenda";
    
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;
      
    NSString *filePath = [self dataFilePathForMyfavoritesAgendaInfo];
    
    if (([[NSFileManager defaultManager] fileExistsAtPath:filePath])) 
    {
        myFavAgendaArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    }
   
    if (myFavAgendaArray == nil)
    {
        myFavAgendaArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
        
    if ([self.loc.itemArray count] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No details available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
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
    agendaTableView.separatorColor = [UIColor clearColor];
    
    searchTableView =[[UITableView alloc] initWithFrame:frame];
    searchTableView.dataSource= self;
    searchTableView.delegate = self;
    searchTableView.backgroundColor = [UIColor clearColor];
    searchTableView.showsVerticalScrollIndicator = NO;
    [searchTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
    [searchTableView setSeparatorColor:[UIColor clearColor]];
    [self.view addSubview:searchTableView];
    [searchTableView setHidden:YES];

    [agendaSearchBar setShowsCancelButton:YES animated:YES];

//    transparentImageView.frame = CGRectMake(30, 70, 260, 250);
    
    [self.view bringSubviewToFront:agendaTableView];
    
    
//    for (AgendaItem *aItem in itemsArray) {
//        
//        CellItem *item = [[CellItem alloc]init];
//        
//        NSString *dateStr = @"";
//      
//        if (aItem.startTime != nil)
//        {
//            dateStr = [dateStr stringByAppendingString:@" \n "];
//            dateStr = [dateStr stringByAppendingString:aItem.startTime];
//            dateStr = [dateStr stringByAppendingString:@" - "];
//            
//        }
//        
//        if (aItem.endTime != nil)
//        {
//            dateStr = [dateStr stringByAppendingString:aItem.endTime];
//        }
//        
//         NSString *title = aItem.title;
//        
//        item.subTitle = dateStr;
//        item.title = title;
//        
//        if (cellItems == nil) {
//            cellItems = [[NSMutableArray alloc]initWithCapacity:itemsArray.count];
//        }
//        
//        [cellItems addObject:item];
//       
//    }
   
    
    
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
    searchTableView.hidden = YES;
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
                
    for (int i=0 , count = [self.loc.itemArray count]; i<count; i++)
    {
       AgendaItem *item  = [self.loc.itemArray objectAtIndex:i];
        
             if (item.title != nil)
            {
                if ([item.title rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound)
                {
                     [searchArr addObject:item];
                    continue;
                  }
            }
        
            if (item.address != nil)
            {
                if ([item.address rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound)
                {
                    
                    [searchArr addObject:item];
                    continue;
                }
            }
          
            if (item.description != nil)
            {
                if ([item.description rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound)
                {
                     [searchArr addObject:item];
                    continue;
                }
            }
    }
    
    [self createSearchTable];    
    
}

-(void)createSearchTable
{
    
    NSLog(@"SEARCH AGENDAAAAAA %d ",searchArr.count);
    if ([searchArr count]>0)
    {
        agendaTableView.hidden = YES;
        [searchTableView setHidden:NO];
        [searchTableView reloadData];


        CGRect viewFrame1 = agendaTableView.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration: 0.7];
        [searchTableView setFrame:viewFrame1];
        [UIView commitAnimations]; 
    }
    else
    {
        [searchTableView reloadData];
        CGRect viewFrame1 = agendaTableView.frame;
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
