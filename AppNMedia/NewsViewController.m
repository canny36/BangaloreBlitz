//
//  NewsViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "NewsViewController.h"
#import "AppNMediaAppDelegate.h"
#import "NewsTableCell.h"
#import "WebViewController.h"
#import "ImageLoader.h"
#import "Util.h"

#define kNewsTableCellHeight 100
@implementation NewsViewController

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
    return [newsArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kNewsTableCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTableCell *cell;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (NewsTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[NewsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;

        NSMutableDictionary *tmpDict = [newsArray objectAtIndex:indexPath.row];
        //cell.titleLabel.textColor = [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:1];
        //cell.titleLabel.text =[tmpDict objectForKey:@"newsurl"];
        [cell.titleLabel setFont:[UIFont fontWithName:[Util subTitleFontName] size:15]];
         cell.titleLabel.textColor = [Util subTitleColor];
           
        cell.descriptionTextView.text =[tmpDict objectForKey:@"description"];
        [cell.descriptionTextView setFont:[UIFont fontWithName:[Util subTitleFontName] size:15]];
        
        cell.descriptionTextView.textColor = [Util subTitleColor];
        
        
        
//        CGRect frame = cell.descriptionTextView.frame;
//        int height = cell.descriptionTextView.contentSize.height;
//        if (height > 80)
//        {
//            frame.size.height = 80;
//        }
//        else
//        {
//            frame.size.height = height;
//        }
//        cell.descriptionTextView.frame = frame;
        
        
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
//                
//                if ([offLineNewsImagesArry count] == [newsArray count])
//                {
//                    NSData *tmpData = [offLineNewsImagesArry objectAtIndex:indexPath.row];
//                    cell.newsImageView.image = [UIImage imageWithData:tmpData];
//                }
//                else
//                {
//                    cell.newsImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
//                }
//                [cell.activityIndicator stopAnimating];            
//            }
// 
//        }
//        else
//        {
//            if ([offLineNewsImagesArry count] == [newsArray count])
//            {
//                NSData *tmpData = [offLineNewsImagesArry objectAtIndex:indexPath.row];
//                cell.newsImageView.image = [UIImage imageWithData:tmpData];
//            }
//            else
//            {
//                cell.newsImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
//            }
//            [cell.activityIndicator stopAnimating];   
//        }
        
        
        
    }
    
     NSMutableDictionary *tmpDict = [newsArray objectAtIndex:indexPath.row];
     NSString *logo =  [tmpDict objectForKey:@"logo"];
    
    
    if (logo != nil && ![logo isEqualToString:@""]) {
        
        NSMutableString *mainlogo = [NSMutableString stringWithString:BASE_URL];
        [mainlogo appendString:logo];
        NSLog(@" URL AT %d = %@  ", indexPath.row, mainlogo);
        [self loadImageAtIndexpath:indexPath urlString:mainlogo cell :(NewsTableCell*)cell];
    }else{
        NSLog(@" NO LOGO   ");

    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
     NSMutableDictionary *tmpDict = [newsArray objectAtIndex:indexPath.row];
    if ([tmpDict objectForKey:@"newsurl"]!=nil)
    {
        
        NSString *urlString = [tmpDict objectForKey:@"newsurl"];
        
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
    self.title = @"News";
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;

    [self assignStyles];
    
    newsArray = [[NSMutableArray alloc] initWithCapacity:0];
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"newslist"] objectForKey:@"news"] isKindOfClass:[NSDictionary class]]) 
    {
        [newsArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"newslist"] objectForKey:@"news"]];
    }
    else
    {
        [newsArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"newslist"] objectForKey:@"news"]];
    }    
    
    
    
    
    offLineNewsImagesArry = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *filePath  = [self dataFilePathForOfflineImages];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        
        if ([tmpDict objectForKey:@"offlineNewsImagesArr"]!= nil)
        {
            [offLineNewsImagesArry addObjectsFromArray:[tmpDict objectForKey:@"offlineNewsImagesArr"]];
        }
        
    }        
  
    
//    int height = [newsArray count] * kNewsTableCellHeight;
//    if (height > 270)
//    {
//        height = 270;
//    }
    
    
    newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 5, 300, 270)];
    newsTableView.delegate = self;
    newsTableView.dataSource =self;
    newsTableView.showsVerticalScrollIndicator = NO;
    newsTableView.backgroundColor = [UIColor clearColor];
    newsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    newsTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:newsTableView];
    
    [subBgView setFrame:CGRectMake(5, 5, 310, 280)];
   
     transparentImageView.frame = CGRectMake(30, 70, 260, 250);

    
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



-(void)loadImageAtIndexpath:(NSIndexPath*)indexpath urlString :(NSString*)url cell :(NewsTableCell*)cell{
    
    CGSize point  = CGSizeMake(100, 80);
    
    if (imageDownloader == nil) {
        imageDownloader =  [ImageDownloader shareInstance];
    }
    
    UIImage *image =  [imageDownloader getImage:url];
    if (image != nil) {
        NSLog(@"HIT AT %@ ",url);
        //        SupportedByTableViewCell *cell = (SupportedByTableViewCell*)[supportedByTableView cellForRowAtIndexPath:indexpath];
        
        cell.newsImageView.image = image;
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
    
   NewsTableCell *cell = (NewsTableCell*)[newsTableView cellForRowAtIndexPath:imageLoader.indexPath];
    cell.newsImageView.image = image;
    
}

-(void)onErrorLoadingImage:(ImageLoader*)imageLoader{
    NSLog(@"ERROR DOWNLOADING ");
    
    [currentDownloads removeObject:imageDownloader];
}



@end
