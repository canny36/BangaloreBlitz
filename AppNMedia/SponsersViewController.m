//
//  SponsersViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "SponsersViewController.h"
#import "AppNMediaAppDelegate.h"
#import "SponsorsTableCell.h"
#import "WebViewController.h"
#import "SPonsor.h"
#import "Util.h"
#import "ImageLoader.h"

#define kSponsersTableCellHeight 80.0

@implementation SponsersViewController

@synthesize sponsorsArray;
@synthesize categoryName;

- (NSString *)dataFilePathForOfflineImages
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"offlineImages.plist"];
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

-(void)assignStyles
{
    titleFontName =@"Helvetica-Bold";
    titleFontSize = @"14";
    
    subTitleFontName =@"Helvetica-Bold";
    subTitleFontSize = @"12";


}

#pragma mark Table View datasource and delegate methods 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [sponsorsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kSponsersTableCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SponsorsTableCell *cell;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (SponsorsTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[SponsorsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        
        [cell.sponserNameLabel setFont:[UIFont fontWithName:[Util titleFontName] size:16]];
       
        
        cell.sponserNameLabel.textColor = [Util titleColor];
        [cell.sponserDetailsLabel setFont: [UIFont fontWithName:[Util detailTextFontName] size:14]];
        
        cell.sponserDetailsLabel.textColor = [Util detailTextColor];
        
        [cell.sponserTypeLabel setFont:[UIFont fontWithName:[Util detailTextFontName] size:12]];
        cell.sponserTypeLabel.textColor = [Util detailTextColor];
        
    }

//        NSMutableDictionary *tmpDict = [sponsersArray objectAtIndex:indexPath.row];
    
    SPonsor *sponsor = [sponsorsArray objectAtIndex:indexPath.row];
    
    cell.sponserTypeLabel.text = sponsor.level;
    cell.sponserNameLabel.text = sponsor.name;
   
   
    NSString *logo =  sponsor.logo;
    NSLog(@" LOGO %@   ",logo);
    if (logo != nil && ![logo isEqualToString:@""]) {
        
        NSMutableString *mainlogo = [NSMutableString stringWithString:BASE_URL];
        [mainlogo appendString:logo];
        NSLog(@" URL AT %d = %@  ", indexPath.row, mainlogo);
        [self loadImageAtIndexpath:indexPath urlString:mainlogo cell : cell];
    }else{
        NSLog(@" NO LOGO   ");
        
    }
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
//    NSMutableDictionary *tmpDict = [sponsersArray objectAtIndex:indexPath.row];
//    
//    if ([tmpDict objectForKey:@"website"]!=nil)
//    {
//        
//        NSString *urlString = [tmpDict objectForKey:@"website"];
//        
//        webViewController = [[WebViewController alloc] init];
//        
//        webViewController.urlString = urlString;
//        
//        [self presentModalViewController:webViewController animated:YES];
//        
//    }
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
    
    [self assignStyles];
    
    categoryName = [categoryName stringByAppendingString:@" Sponsors"];
    self.title = categoryName;
    // Do any additional setup after loading the view from its nib.
    
    
    
//    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
//   
//    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
//    self.navigationItem.rightBarButtonItem = homeButton;
//    
//    
//    sponsersArray = [[NSMutableArray alloc] initWithCapacity:0];
//    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"sponsorslist"] objectForKey:@"sponsor"] isKindOfClass:[NSDictionary class]]) 
//    {
//        [sponsersArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"sponsorslist"] objectForKey:@"sponsor"]];
//    }
//    else
//    {
//        [sponsersArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"sponsorslist"] objectForKey:@"sponsor"]];
//    }    
// 
//    
//    offlineSponserImagesArr = [[NSMutableArray alloc] initWithCapacity:0];
//    
//    NSString *filePath  = [self dataFilePathForOfflineImages];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
//    {
//        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
//        
//        if ([tmpDict objectForKey:@"offlineSponserImagesArr"]!= nil)
//        {
//            [offlineSponserImagesArr addObjectsFromArray:[tmpDict objectForKey:@"offlineSponserImagesArr"]];
//        }
//        
//    }         

    
        
//    int height = kSponsersTableCellHeight * [sponsersArray count];
//    if (height > 270)
//    {
//        height = 270;
//    }
    sponsersTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, 300, 270)];
    sponsersTableView.delegate= self;
    sponsersTableView.dataSource = self;
    sponsersTableView.showsVerticalScrollIndicator = NO;
    sponsersTableView.backgroundColor = [UIColor clearColor];
    sponsersTableView.separatorColor = [UIColor clearColor];
    sponsersTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    sponsersTableView.separatorColor = [UIColor clearColor];
    
    [self.view addSubview:sponsersTableView];
    [subBgView setFrame:CGRectMake(5, 5, 310, 270+15)];
    transparentImageView.frame = CGRectMake(30, 70, 260, 250);

    
}

-(void)delayStart
 {
    [self performSelectorInBackground:@selector(callSponsersImagesLoading) withObject:nil]; 
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

-(void)loadImageAtIndexpath:(NSIndexPath*)indexpath urlString :(NSString*)url cell :(SponsorsTableCell*)cell{
    
    CGSize point  = CGSizeMake(100, 80);
    
    //    [NSInvocationOperation ];
    
    if (imageDownloader == nil) {
        imageDownloader =  [ImageDownloader shareInstance];
    }
    
    UIImage *image =  [imageDownloader getImage:url];
    if (image != nil) {
        NSLog(@"HIT AT %@ ",url);
        //        SupportedByTableViewCell *cell = (SupportedByTableViewCell*)[supportedByTableView cellForRowAtIndexPath:indexpath];
        
        cell.sponsersImageView.image = image;
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
    
//   SponsorsTableCell *cell = (SponsorsTableCell*)[sponsersTableView cellForRowAtIndexPath:imageLoader.indexPath];
//    cell.sponsersImageView.image = image;
    
//    [sponsersTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:imageLoader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    
    [self performSelectorOnMainThread:@selector(updateCell:) withObject:imageLoader waitUntilDone:YES];
    
}

-(void)updateCell:(ImageLoader*)loader{
    [sponsersTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:loader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)onErrorLoadingImage:(ImageLoader*)imageLoader{
    NSLog(@"ERROR DOWNLOADING ");
    [imageDownloader removeOperation:imageLoader];
    [currentDownloads removeObject:imageDownloader];
}





@end
