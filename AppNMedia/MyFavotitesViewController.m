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
#import "SpeakerInfo.h"
#import "SpeakersTableViewCell.h"
#import "ImageLoader.h"
#import "SpeakersViewDetailsController.h"
#import "AgendaTableViewCell.h"
#import "SubAgendaViewController.h"

#define kmyFavoritesTableCellHeight 60
#define kSpeakersTableCellHeight 100

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
        return [agendaArray count];
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
        label.text = @"Speakers"; 
    }
    
    [headerView addSubview:label];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return [AgendaTableViewCell heightForItem:[agendaArray objectAtIndex:indexPath.row]];
    }
    else
    {
        SpeakerInfo *info = nil;
        
            info = [selectedSpeakersArr objectAtIndex:indexPath.row];
        CGSize size = [info.name sizeWithFont:[UIFont fontWithName:[Util subTitleFontName] size:15] constrainedToSize:CGSizeMake(220 ,MAXFLOAT ) lineBreakMode:UILineBreakModeWordWrap];
        
        CGSize size1 = [info.name sizeWithFont:[UIFont fontWithName:[Util detailTextFontName] size:13] constrainedToSize:CGSizeMake(220 ,MAXFLOAT ) lineBreakMode:UILineBreakModeWordWrap];
        
        CGFloat height = kSpeakersTableCellHeight;
        height = size.height + size1.height +20;
        
        if (height< kSpeakersTableCellHeight) {
            return kSpeakersTableCellHeight;
        }
        
        return kSpeakersTableCellHeight;
        
          
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CellIdentifier = [CellIdentifier stringByAppendingFormat:@"%d",indexPath.section];
     
    if (indexPath.section == 0)
    {

       AgendaTableViewCell *cell = (AgendaTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
         if (cell == nil)
        {
            cell = [[AgendaTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
        }
        AgendaItem *item =  [agendaArray objectAtIndex:indexPath.row];
        [cell cellWithAgendaItem:item];
        cell.accessoryView = nil;
        return cell;
    }
    else
    {
        
        SpeakersTableViewCell *cell = nil;
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
        cell = (SpeakersTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            cell = [[SpeakersTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
            [cell.textLabel setFont:[UIFont fontWithName:[Util subTitleFontName] size:15]];
            cell.textLabel.textColor = [Util subTitleColor];
            
            [cell.detailTextLabel setFont:[UIFont fontWithName:[Util detailTextFontName] size:13]];
            
            cell.detailTextLabel.textColor = [Util detailTextColor];
        };

        SpeakerInfo *info = [selectedSpeakersArr objectAtIndex:indexPath.row
                             ];
        CGSize size = [info.name sizeWithFont:cell.textLabel.font constrainedToSize:CGSizeMake(cell.textLabel.frame.size.width ,MAXFLOAT ) lineBreakMode:UILineBreakModeWordWrap];
        
        cell.textLabel.numberOfLines = size.height/21 +1;
        cell.textLabel.text = info.name;
        
        size = [info.type sizeWithFont:cell.textLabel.font constrainedToSize:CGSizeMake(cell.textLabel.frame.size.width ,MAXFLOAT )];
        cell.detailTextLabel.numberOfLines = size.height/21;
        cell.detailTextLabel.text = info.type;
        
        NSString *logo  = info.logo;
        NSLog(@" LOGO %@   ",logo);
        if (logo != nil && ![logo isEqualToString:@""]) {
            
            NSMutableString *mainlogo = [NSMutableString stringWithString:BASE_URL];
            [mainlogo appendString:logo];
            NSLog(@" URL AT %d = %@  ", indexPath.row, mainlogo);
            [self loadImageAtIndexpath:indexPath urlString:mainlogo cell : cell];
        }else{
            NSLog(@" NO LOGO   ");
            
        }
        cell.selectButton.hidden = YES;
        return cell;

        }

    
    }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated: NO];
    
    if (indexPath.section == 0)
    {
        AgendaItem *item = [agendaArray objectAtIndex:indexPath.row];
       
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
    else
    {
        SpeakersViewDetailsController *controller  = [[SpeakersViewDetailsController alloc] init];

       
        controller.speakerInfo = [selectedSpeakersArr objectAtIndex:indexPath.row];
        
        [self.navigationController pushViewController:controller animated:YES];

    }

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

    NSMutableArray *speakerIdArray = nil;
    
    NSString *speakerFilePath = [self dataFilePathForMyfavoritesSpeakersInfo];
    if ([[NSFileManager defaultManager] fileExistsAtPath:speakerFilePath]) {
        speakerIdArray = [[NSMutableArray alloc]initWithContentsOfFile:speakerFilePath];
    }
    
    if (speakerIdArray != nil && [speakerIdArray count] > 0) {
        selectedSpeakersArr = [SpeakerInfo favorites:speakerIdArray];
    }
    
    NSString *agendaFilePath = [self dataFilePathForMyfavoritesAgendaInfo];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:agendaFilePath])
    {
        NSMutableArray *tmpArr = [[NSMutableArray alloc]initWithContentsOfFile:agendaFilePath];
        NSLog(@" MYFAVORITE AGENDA ARRAY %@ ",tmpArr);
        agendaArray = [AgendaItem favorites:tmpArr];
        
    }
    
    myFavoritesTableView =[[UITableView alloc] initWithFrame:CGRectMake(5, 5, 310, 290)];
    myFavoritesTableView.dataSource= self;
    myFavoritesTableView.delegate = self;
    myFavoritesTableView.backgroundColor = [UIColor clearColor];
    myFavoritesTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myFavoritesTableView.separatorColor=[UIColor clearColor];
    myFavoritesTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myFavoritesTableView];
    
   
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




-(void)loadImageAtIndexpath:(NSIndexPath*)indexpath urlString :(NSString*)url cell :(SpeakersTableViewCell*)cell{
    
    CGSize point  = CGSizeMake(100, 80);
    
    if (imageDownloader == nil) {
        imageDownloader =  [ImageDownloader shareInstance];
    }
    //    [NSInvocationOperation ];
    
    UIImage *image =  [imageDownloader getImage:url];
    
    if (image != nil) {
        NSLog(@"HIT AT %@ ",url);
        //        SupportedByTableViewCell *cell = (SupportedByTableViewCell*)[supportedByTableView cellForRowAtIndexPath:indexpath];
        
        cell.imageView.image = image;
        //        [supportedByTableView reloadData];
        
    }else{
        
        NSLog(@"FAIL AT %@ ",url);
        ImageLoader *loader = [[ImageLoader alloc]initWithUrl:url withSize:point delegate:self];
        loader.indexPath = indexpath;
        
        
        [imageDownloader addOperation:loader];
        [currentDownloads addObject:loader];
        
    }
}

-(void)onDownloadCompletion:(UIImage*)image : (ImageLoader*)imageLoader{
    
    NSLog(@" DOWNLOAD COMPLETED FOR %d ",imageLoader.indexPath.row);
    
    [currentDownloads removeObject:imageLoader];
    [imageDownloader removeOperation:imageLoader];
    
    [self performSelectorOnMainThread:@selector(updateCell:) withObject:imageLoader waitUntilDone:YES];
    
}

-(void)updateCell:(ImageLoader*)loader{
    [myFavoritesTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:loader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)onErrorLoadingImage:(ImageLoader*)imageLoader{
    
    NSLog(@"ERROR DOWNLOADING ");
    [imageDownloader removeOperation:imageLoader];
    [currentDownloads removeObject:imageDownloader];
}


-(void)viewDidDisappear:(BOOL)animated{
    
    for (ImageLoader *loader in currentDownloads) {
        [loader cancel];
    }
    
    [currentDownloads removeAllObjects];

}


@end
