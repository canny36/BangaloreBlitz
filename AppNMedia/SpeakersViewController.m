//
//  SpeakersViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "SpeakersViewController.h"
#import "SpeakersViewDetailsController.h"
#import "AppNMediaAppDelegate.h"
#import "SpeakersTableViewCell.h"
#import "AgendaDetailsViewController.h"
#import "ImageLoader.h"
#import "Util.h"
#import "SpeakersViewDetailsController.h"
#import "SpeakerInfo.h"
#import "CustomTableViewCell.h"
#import "UIImage+scale.h"

#define kSpeakersTableCellHeight 100.0
@implementation SpeakersViewController
@synthesize offlineSpeakersImagesArr;

- (void)dealloc
{
   
    
}

- (NSString *)dataFilePathForMyfavoritesSpeakersInfo
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"myfavoriteSpeakers.plist"];
}

//- (NSString *)dataFilePathForOfflineImages
//{ 
//	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
//	NSString *documentsDirectory = [paths objectAtIndex:0];
//	return [documentsDirectory stringByAppendingPathComponent:@"offlineImages.plist"];
//}


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


-(void)saveFavorites{
    NSString *filePath = [self dataFilePathForMyfavoritesSpeakersInfo];
    
    NSLog(@"SAVE FAVORITES =  %@ ", myFavoriteSpeakers);
    [myFavoriteSpeakers writeToFile:filePath atomically:YES];
 
    NSMutableArray *array = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
    NSLog(@"SAVE FAVORITES array =  %@ ", array);
}



#pragma mark Table View datasource and delegate methods 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == speakersTableView) 
    {
        return [speakersArray count];

    }
    else
    {
        return [searchArr count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpeakerInfo *info = nil;
    if (tableView == speakersTableView) {
        info = [speakersArray objectAtIndex:indexPath.row];
    }else{
        info  = [searchArr objectAtIndex:indexPath.row];
    }
 
    CGSize size = [info.name sizeWithFont:[UIFont fontWithName:[Util subTitleFontName] size:15] constrainedToSize:CGSizeMake(220 ,MAXFLOAT ) lineBreakMode:UILineBreakModeWordWrap];
    
    CGSize size1 = [info.name sizeWithFont:[UIFont fontWithName:[Util detailTextFontName] size:13] constrainedToSize:CGSizeMake(220 ,MAXFLOAT ) lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = kSpeakersTableCellHeight;
    height = size.height + size1.height +20;
    
    if (height< kSpeakersTableCellHeight) {
        return kSpeakersTableCellHeight;
    }
    
    return kSpeakersTableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
      CustomTableViewCell *cell;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
        [cell enableBookmarkWithTarget:self];
        UIImage *image = [UIImage imageNamed:@"no_image.png"];
        image = [image scaleImageToSize:CGSizeMake( image.size.width/2, image.size.height/2)];
        [cell setDefaultImage:image];
        
    };

     SpeakerInfo *info = nil;
 
    if (tableView == speakersTableView) 
    {
      
        info = [speakersArray objectAtIndex:indexPath.row];
        
    }else{
        
         info = [searchArr objectAtIndex:indexPath.row];
    }
    
     CGSize size = [info.name sizeWithFont:cell.textLabel.font constrainedToSize:CGSizeMake(cell.textLabel.frame.size.width ,MAXFLOAT ) lineBreakMode:UILineBreakModeWordWrap];
    
     cell.textLabel.numberOfLines = size.height/21 +1;
     cell.textLabel.text = info.name;
    
     size = [info.type sizeWithFont:cell.textLabel.font constrainedToSize:CGSizeMake(cell.detailTextLabel.frame.size.width ,MAXFLOAT )];
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

        cell.accessoryView.tag = indexPath.row;
        BOOL selected= [self checkIfFavorite:info];

        [cell selectFavorite:selected];
    
    return cell;
}

-(BOOL)checkIfFavorite:(SpeakerInfo*)info{
    
    if ([myFavoriteSpeakers indexOfObject:info.speakerId] != NSNotFound) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
    speakersDetailsViewController = [[SpeakersViewDetailsController alloc] init];

    if (tableView == speakersTableView)
    {
   
        speakersDetailsViewController.svc = self;
        speakersDetailsViewController.speakerInfo = [speakersArray objectAtIndex:indexPath.row];

        [self.navigationController pushViewController:speakersDetailsViewController animated:YES];
     }
    else
    {

        speakersDetailsViewController.svc = self;
        speakersDetailsViewController.speakerInfo = [searchArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:speakersDetailsViewController animated:YES];    
    }

}

-(void)onFavoriteSelection:(UIButton *)sender{
    
    NSLog(@"onfavorite selection");
    
    int tag = sender.tag;
    
    SpeakerInfo *info  = [speakersArray objectAtIndex:tag];
    
    if (sender.selected) {
        if ([myFavoriteSpeakers indexOfObject:info.speakerId] == NSNotFound) {
            [myFavoriteSpeakers addObject:info.speakerId];
        }
        
    }else{
        if ([myFavoriteSpeakers indexOfObject:info.speakerId] != NSNotFound) {
            [myFavoriteSpeakers removeObject:info.speakerId];
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];  
}


#pragma mark - View lifecycle
-(void)viewWillDisappear:(BOOL)animated
{
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Speakers";
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;

         
    speakersArray = [SpeakerInfo collection];
    
//    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"speakerslist"] objectForKey:@"speaker"] isKindOfClass:[NSDictionary class]]) 
//    {
//        [speakersArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"speakerslist"] objectForKey:@"speaker"]];
//    }
//    else
//    {
//        [speakersArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"speakerslist"] objectForKey:@"speaker"]];
//    }
//    
//    NSLog(@" SPEAKERS ARRAY %d ", [speakersArray count]);
    
   
    
    NSString *filePath = [self dataFilePathForMyfavoritesSpeakersInfo];
    
    if (([[NSFileManager defaultManager] fileExistsAtPath:filePath]))
    {
        myFavoriteSpeakers = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    }
   
    
        
    NSLog(@"DATA MYFAVORITES %@  %d ",myFavoriteSpeakers , [myFavoriteSpeakers count]);
    if (myFavoriteSpeakers == nil) {
         myFavoriteSpeakers = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    
    speakersTableView = [[UITableView alloc] initWithFrame:CGRectMake(5,50, 310, 250)];
    speakersTableView.dataSource = self;
    speakersTableView.delegate = self;
    speakersTableView.backgroundColor = [UIColor clearColor];
    speakersTableView.showsVerticalScrollIndicator = NO;
    [speakersTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    speakersTableView.separatorColor = [UIColor clearColor] ;
    
    [self.view addSubview:speakersTableView];
    
    for (UIView *view in participantsSearchBar.subviews)
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
    [searchTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    searchTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:searchTableView];
    [participantsSearchBar setShowsCancelButton:YES animated:YES];
 
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


//-(NSArray *)extractMethod:(NSInteger)value
//{
//    NSMutableDictionary *mainDic = [agendaArray objectAtIndex:value];
//    id data =   [mainDic objectForKey:@"agendalocation"];
//   
//    array = [[NSMutableArray alloc]init];
//    if([data isKindOfClass:[NSArray class]])
//        [array addObjectsFromArray:data];
//    
//    if([data isKindOfClass:[NSDictionary class]])
//        [array addObject:data];
//    return array;
//}

#pragma mark - searchBar
- (void)searchBarCancelButtonClicked:(UISearchBar *) aSearchBar 
{
    speakersTableView.hidden = NO;
    [participantsSearchBar resignFirstResponder];
    participantsSearchBar.text =@"";
      
    CGRect viewFrame1 = CGRectMake(10, 500, 300, 200);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration: 0.7];
    [searchTableView setFrame:viewFrame1];
    [UIView commitAnimations]; 
    
}
- (BOOL)textFieldShouldClear:(UITextField *)textField 
{
    speakersTableView.hidden = NO;
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

    [self mainSearchMethod:searchBar.text];
}

-(void)mainSearchMethod:(NSString*)searchStr
{
    if (searchArr != nil)
    {
        [searchArr removeAllObjects];
    }
    else
    {
        searchArr = [[NSMutableArray alloc] initWithCapacity:0]; 
 
    }
   
    
    if ([searchStr length]>3)
    {

        for (int i=0; i<[speakersArray count]; i++)
        {
            SpeakerInfo *info = [speakersArray objectAtIndex:i];
            
            if([info.name rangeOfString:searchStr options:NSCaseInsensitiveSearch ].location != NSNotFound){
                [searchArr addObject:info];
                continue;
            }
             if([info.type rangeOfString:searchStr options:NSCaseInsensitiveSearch ].location != NSNotFound){
                [searchArr addObject:info];
                
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
        speakersTableView.hidden = YES;
        [searchTableView reloadData];

        CGRect viewFrame1 = speakersTableView.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration: 0.7];
        [searchTableView setFrame:viewFrame1];
        [UIView commitAnimations]; 
    }
    else
    {
        [searchTableView reloadData];

        CGRect viewFrame1 = speakersTableView.frame;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration: 0.7];
        [searchTableView setFrame:viewFrame1];
        [UIView commitAnimations]; 
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No results found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        speakersTableView.hidden = NO;
    }
    
    
}



-(void)loadImageAtIndexpath:(NSIndexPath*)indexpath urlString :(NSString*)url cell :(CustomTableViewCell*)cell{
    
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
    [speakersTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:loader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
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
    
    [self saveFavorites];
}

@end
