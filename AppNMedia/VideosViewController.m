//
//  VideosViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "VideosViewController.h"
#import "AppNMediaAppDelegate.h"
#import "VideosTableCell.h"
#import "WebViewController.h"
#define kVideosTableCellheight 70
@implementation VideosViewController
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

-(void)loadVediosToWebview:(UIWebView *)vedioWebView url:(NSURL *)vedioUrl
{
    
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
    return [videosArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kVideosTableCellheight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideosTableCell *cell;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (VideosTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[VideosTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        
        [cell.titleTxtView setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];

        cell.titleTxtView.textColor = [UIColor whiteColor];
        

        NSMutableDictionary *tmpDict = [videosArray objectAtIndex:indexPath.row];
        cell.titleTxtView.text = [tmpDict objectForKey:@"videoname"];
        
        NSString *tmpStr = [tmpDict objectForKey:@"videourl"];
        cell.vedioUrl = [NSURL URLWithString:tmpStr];
        [cell loadWebView:[NSURL URLWithString:tmpStr]];
        
        
        if (appDelegate.runAppInOffline == NO)
        {
            BOOL network = [appDelegate networkCheckingMethod];
            
            if (network == YES)
            {
                
                NSString *baseUrl =BASE_URL;
                if ([tmpDict objectForKey:@"logo"] != nil) 
                {
                    NSString *imageUrl = [tmpDict objectForKey:@"logo"];
                    baseUrl = [baseUrl stringByAppendingString:imageUrl];
                    
                }
                [cell performSelectorInBackground:@selector(assignImage:) withObject:baseUrl];
                
                
            }
            else
            {
                if ([offlineVediosImagesArray count] == [videosArray count])
                {
                    NSData *tmpData = [offlineVediosImagesArray objectAtIndex:indexPath.row];
                    cell.vedioImageView.image = [UIImage imageWithData:tmpData];
                }
                else
                {
                    cell.vedioImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
                }
                [cell.activityIndicator stopAnimating];
                
            }
            
        }
        else
        {
            if ([offlineVediosImagesArray count] == [videosArray count])
            {
                NSData *tmpData = [offlineVediosImagesArray objectAtIndex:indexPath.row];
                cell.vedioImageView.image = [UIImage imageWithData:tmpData];
            }
            else
            {
                cell.vedioImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
            }
            [cell.activityIndicator stopAnimating];
            
        }
        

        
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
   NSMutableDictionary *tmpDict = [videosArray objectAtIndex:indexPath.row];
    
    if ([tmpDict objectForKey:@"videourl"]!= nil)
    {
        NSString *urlString = [tmpDict objectForKey:@"videourl"];
             
//        webViewController = [[WebViewController alloc] init];
//        
//        webViewController.urlString = urlString;
//        
//        [self presentModalViewController:webViewController animated:YES];
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
        

        
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
    self.title = @"Videos";
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;

    [self assignStyles];
    
    
    videosArray = [[NSMutableArray alloc] initWithCapacity:0];
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"videoslist"] objectForKey:@"video"] isKindOfClass:[NSDictionary class]]) 
    {
        [videosArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"videoslist"] objectForKey:@"video"]];
    }
    else
    {
        [videosArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"videoslist"] objectForKey:@"video"]];
    }    

    //NSLog(@"%@",videosArray);
    
    
    offlineVediosImagesArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *filePath  = [self dataFilePathForOfflineImages];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        
        if ([tmpDict objectForKey:@"offlineVediosImagesArray"]!= nil)
        {
            [offlineVediosImagesArray addObjectsFromArray:[tmpDict objectForKey:@"offlineVediosImagesArray"]];
        }
        
    }    

    
    int height = [videosArray count] * kVideosTableCellheight;
    if (height > 270)
    {
        height = 270;
    }
    videosTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 5, 300, height)];
    videosTableView.dataSource = self;
    videosTableView.delegate = self;
    videosTableView.showsVerticalScrollIndicator = NO;
    videosTableView.backgroundColor = [UIColor clearColor];
    videosTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:videosTableView];
    [subBgView setFrame:CGRectMake(5, 5, 310, 280)];
    
    
    if ([videosArray count] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No details available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
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

@end
