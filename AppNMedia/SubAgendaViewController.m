//
//  SubAgendaViewController.m
//  AppNMedia
//
//  Created by Srinivas on 27/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "SubAgendaViewController.h"
#import "SubAgendaItem.h"
#import "Util.h"
#import "AgendaDetailsViewController.h"
#import "CustomTableViewCell.h"

@interface SubAgendaViewController ()

@end

@implementation SubAgendaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Agenda";
    
    NSString *path = [self dataFilePathForMyfavoritesAgendaInfo];
    if (path != nil) {
        _myFavAgendaArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    }
    
    if (_myFavAgendaArray == nil) {
       _myFavAgendaArray =  [[NSMutableArray alloc]init];
    }
    
    _tableView.tag = 1;
    [_searchBar setShowsCancelButton:YES animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark Table View datasource and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ( tableView.tag ==1 ) ?  [self.subAgendaArray count] : [_searchArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   SubAgendaItem *item = nil ;
    
    if (tableView.tag == 1 ) {
        item =  [self.subAgendaArray objectAtIndex:indexPath.row];
    }else{
        item = [_searchArray objectAtIndex:indexPath.row];
    }
    
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
    int calHeight = size1.height + size2.height +10;
    if ( calHeight > 80) {
        return calHeight;
    }
    
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   CustomTableViewCell *cell;
    NSString *CellIdentifier = @"agenda identifier";
    cell = (CustomTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier hideImageView:YES] ;
        [cell enableBookmarkWithTarget:self];
        
    }
    
   SubAgendaItem *item = nil ;
    
    if (tableView.tag == 1) {
        item =  [self.subAgendaArray objectAtIndex:indexPath.row];
    }else{
        item = [_searchArray objectAtIndex:indexPath.row];
    }
    
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
    NSLog(@" AGENDA VIEW LINES at row %d  %f  for \n %@ ",indexPath.row,size.height,item.title);
    cell.textLabel.text = item.title;
    cell.textLabel.numberOfLines = lines;
    
    
    size = [dateStr sizeWithFont:cell.detailTextLabel.font constrainedToSize:CGSizeMake(cell.detailTextLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    
    cell.detailTextLabel.text = dateStr;
    lines = size.height/20;
    cell.detailTextLabel.numberOfLines = lines > 2 ? lines : 2;
    
    BOOL selected = [self checkIfFavorite:item];
    [cell selectFavorite:selected];
    cell.accessoryView.tag = indexPath.row;
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    AgendaDetailsViewController *controller = [[AgendaDetailsViewController alloc]init];
    controller.subAgendaItem = [tableView.tag == 1 ? (self.subAgendaArray ) : (_searchArray)objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
    
}

-(void)onFavoriteSelection:(UIButton *)sender{
    
    int tag = sender.tag;
    
    SubAgendaItem *info  = [self.subAgendaArray objectAtIndex:tag];
    NSLog(@"BOOKMARK C=BUTTON CLICK %@ ",info.agendaId);
    if (_tableView.hidden == YES) {
        info = [_searchArray objectAtIndex:tag];
    }
    
    if (sender.selected) {
        if ([_myFavAgendaArray indexOfObject:info.agendaId] == NSNotFound) {
            [_myFavAgendaArray addObject:info.agendaId];
        }
        
    }else{
        if ([_myFavAgendaArray indexOfObject:info.agendaId] != NSNotFound) {
            [_myFavAgendaArray removeObject:info.agendaId];
        }
    }
    
}

-(BOOL)checkIfFavorite:(SubAgendaItem*)info{
    
    if ([_myFavAgendaArray indexOfObject:info.agendaId] != NSNotFound) {
        return YES;
    }
    return NO;
}

-(void)saveFavorites{
    
    NSString *filePath = [self dataFilePathForMyfavoritesAgendaInfo];
    
    NSLog(@"SAVE FAVORITES =  %@ ",_myFavAgendaArray);
    [_myFavAgendaArray writeToFile:filePath atomically:YES];
    
}

- (NSString *)dataFilePathForMyfavoritesAgendaInfo
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"myfavoriteSubAgenda.plist"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self saveFavorites];
}

#pragma mark - searchBar

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) aSearchBar
{

    [_searchBar resignFirstResponder];
    [_tableView setTag:1];
    [_tableView reloadData];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [_tableView setTag:1];
    [_tableView reloadData];
    return YES;
}



////////////// searchBar
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    NSString *str = searchBar.text;
    [self mainSearchMethod:str];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    NSString *str = searchBar.text;
    [self mainSearchMethod:str];
    
}
-(void)mainSearchMethod:(NSString*)str
{
    
    if ([str length ]==0) {
        _tableView.tag=1;
        [_tableView reloadData];
        return;
    }
    
    if (_searchArray== nil) {
        _searchArray = [[NSMutableArray alloc]init];
    }
    
    [_searchArray removeAllObjects];
    
    for (int i=0; i<[self.subAgendaArray count]; i++)
    {
        SubAgendaItem *item  = [self.subAgendaArray objectAtIndex:i];
        
        
        
        if (item.title != nil)
        {
            if ([item.title rangeOfString:str options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                
                [_searchArray addObject:item];
                continue;
                
            }
            
        }
        
        if (item.address != nil)
        {
            if ([item.address rangeOfString:str options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                
                [_searchArray addObject:item];
                continue;
                
            }
        }
        
        if (item.description != nil)
        {
            if ([item.description rangeOfString:str options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                
                [_searchArray addObject:item];
                continue;
                
            }
        }
    }
    
    [self createSearchTable];
    
}

-(void)createSearchTable
{
    if (_searchArray != nil) {
        [_tableView setTag:0];
        [_tableView reloadData];
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [self saveFavorites];
}



@end
