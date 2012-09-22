//
//  LinksViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "LinksViewController.h"
#import "AppNMediaAppDelegate.h"
#import "WebViewController.h"
#import "LinksTableCell.h"

#define kLinksTableCellHeight 100.0
@implementation LinksViewController

- (NSString *)dataFilePathForOfflineImages
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"offlineImages.plist"];
}


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

-(void)assignStyles
{
    titleFontName =@"Helvetica-Bold";
    titleFontSize = @"14";
    
    subTitleFontName =@"Helvetica";
    subTitleFontSize = @"12";
      
}

#pragma mark Table View datasource and delegate methods 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [linksArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kLinksTableCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LinksTableCell *cell;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (LinksTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[LinksTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        NSMutableDictionary *tmpDict = [linksArray objectAtIndex:indexPath.row];
        
        [cell.linkNameLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
        cell.linkNameLabel.text = [tmpDict objectForKey:@"linkname"];

        cell.linkNameLabel.textColor = [UIColor whiteColor];
        
        [cell.linkUrlLabel setFont:[UIFont fontWithName:weblinkFontName size:[weblinkFontSize intValue]]];
        

     
        //cell.linkUrlLabel.text = [tmpDict objectForKey:@"linkurl"];
        cell.linkUrlLabel.textColor = [UIColor whiteColor];

        NSString *logo =           
        [tmpDict objectForKey:@"logo"];
        
        if (logo != nil && ![logo isEqualToString:@""]) {
            
            NSMutableString *mainlogo = [NSMutableString stringWithString:BASE_URL];
            [mainlogo appendString:logo];
            NSLog(@" URL AT %d = %@  ", indexPath.row, mainlogo);
            [self loadImageAtIndexpath:indexPath urlString:mainlogo cell:cell];
            
        }else{
            
        }
        

        
//        if (appDelegate.runAppInOffline == NO)
//        {
//            BOOL network = [appDelegate networkCheckingMethod];
//            
//            if (network == YES)
//            {
//                
//                NSString *baseUrl = BASE_URL;
//                if ([tmpDict objectForKey:@"logo"] != nil) 
//                {
//                    NSString *imageUrl = [tmpDict objectForKey:@"logo"];
//                    baseUrl = [baseUrl stringByAppendingString:imageUrl];
//                    
//                }
//                
//                [cell performSelectorInBackground:@selector(assignImage:) withObject:baseUrl];
//            }
//            else
//            {
//                if ([offlineLinksImagesArr count] == [linksArray count])
//                {
//                    NSData *tmpData = [offlineLinksImagesArr objectAtIndex:indexPath.row];
//                    cell.linksImageView.image = [UIImage imageWithData:tmpData];
//                }
//                else
//                {
//                    cell.linksImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
//                }
//                [cell.activityIndicator stopAnimating];
//                
//            }
//
//        }
//        else
//        {
//            if ([offlineLinksImagesArr count] == [linksArray count])
//            {
//                NSData *tmpData = [offlineLinksImagesArr objectAtIndex:indexPath.row];
//                cell.linksImageView.image = [UIImage imageWithData:tmpData];
//            }
//            else
//            {
//                cell.linksImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
//            }
//            [cell.activityIndicator stopAnimating];
//
//        }
//        
        
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSMutableDictionary *tmpDict = [linksArray objectAtIndex:indexPath.row];
    
    if ([tmpDict objectForKey:@"linkurl"]!=nil)
    {
        
        NSString *urlString = [tmpDict objectForKey:@"linkurl"];
        
        webViewController = [[WebViewController alloc] init];
        
        webViewController.urlString = urlString;
        
        [self presentModalViewController:webViewController animated:YES];
        
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
    self.title = @"Links";
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;

    [self assignStyles];
   
    linksArray = [[NSMutableArray alloc] initWithCapacity:0];
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"linkslist"] objectForKey:@"link"] isKindOfClass:[NSDictionary class]]) 
    {
        [linksArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"linkslist"] objectForKey:@"link"]];
    }
    else
    {
        [linksArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"linkslist"] objectForKey:@"link"]];
    }    
    
    
    
    offlineLinksImagesArr = [[NSMutableArray alloc] initWithCapacity:0];

    NSString *filePath  = [self dataFilePathForOfflineImages];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        
        if ([tmpDict objectForKey:@"offlineLinksImagesArr"]!= nil)
        {
            [offlineLinksImagesArr addObjectsFromArray:[tmpDict objectForKey:@"offlineLinksImagesArr"]];
        }
        
    }         
    
    int height = [linksArray count] * kLinksTableCellHeight;
    if (height > 270)
    {
        height = 270;
    }
    linksTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 10, 300, height)];
    linksTableView.delegate=self;
    linksTableView.dataSource = self;
    linksTableView.showsVerticalScrollIndicator = NO;
    linksTableView.backgroundColor = [UIColor clearColor];
    linksTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    linksTableView.separatorColor = [UIColor clearColor];
    
    [self.view addSubview:linksTableView];
    [subBgView setFrame:CGRectMake(5, 5, 310, height+15)];
   transparentImageView.frame = CGRectMake(30, 70, 260, 250);

    
}


-(void)loadImageAtIndexpath:(NSIndexPath*)indexpath urlString :(NSString*)url cell :(LinksTableCell*)cell{
    
    CGSize point  = CGSizeMake(100, 80);
    
    if (imageDownloader == nil) {
        imageDownloader =  [ImageDownloader shareInstance];
    }
    
    UIImage *image =  [imageDownloader getImage:url];
    if (image != nil) {
        NSLog(@"HIT AT %@ ",url);
        //        SupportedByTableViewCell *cell = (SupportedByTableViewCell*)[supportedByTableView cellForRowAtIndexPath:indexpath];
        
        cell.linksImageView.image = image;
        
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
    
    [self performSelectorOnMainThread:@selector(updateCell:) withObject:imageLoader waitUntilDone:NO];
    
}

-(void)updateCell:(ImageLoader*)loader{
    [linksTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:loader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}


-(void)onErrorLoadingImage:(ImageLoader*)imageLoader{
    NSLog(@"ERROR DOWNLOADING ");
    [imageDownloader removeOperation:imageLoader];
    [currentDownloads removeObject:imageLoader];
}


-(void)stopDownloads{
    for (ImageLoader *loader in currentDownloads) {
        [loader cancel];
    }
    
    [currentDownloads removeAllObjects];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void)viewWillDisappear:(BOOL)animated{
    [self stopDownloads];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
