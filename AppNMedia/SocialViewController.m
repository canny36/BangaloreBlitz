//
//  SocialViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "SocialViewController.h"
#import "AppNMediaAppDelegate.h"
#import "SocialTableCell.h"
#import "WebViewController.h"
#define kSocialTableCellHeight 80.0
@implementation SocialViewController
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
    
    subTitleFontName =@"Helvetica";
    subTitleFontSize = @"12";


}
#pragma mark Table View datasource and delegate methods 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [socialArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kSocialTableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SocialTableCell *cell;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (SocialTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[SocialTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        NSMutableDictionary *tmpDict = [socialArray objectAtIndex:indexPath.row];
        
        [cell.socialNameLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
        cell.socialNameLabel.text = [tmpDict objectForKey:@"medianame"];
      
        cell.socialNameLabel.textColor = [UIColor whiteColor];
        
        [cell.socialUrlTxtView setFont:[UIFont fontWithName:weblinkFontName size:[weblinkFontSize intValue]]];

        
        cell.socialUrlTxtView.textColor = [UIColor blueColor];
        
        //cell.socialUrlTxtView.text = [tmpDict objectForKey:@"meidaurl"];

        
        
        
        if (appDelegate.runAppInOffline == NO)
        {
            BOOL network = [appDelegate networkCheckingMethod];
            
            if (network == YES)
            {
                
                NSString *baseUrl = BASE_URL;
                if ([tmpDict objectForKey:@"logo"] != nil) 
                {
                    NSString *imageUrl = [tmpDict objectForKey:@"logo"];
                    baseUrl = [baseUrl stringByAppendingString:imageUrl];
                    
                }
                
                [cell performSelectorInBackground:@selector(assignImage:) withObject:baseUrl];
            }
            else
            {
                
                if ([offlineSocialImagesArr count] == [socialArray count])
                {
                    NSData *tmpData = [offlineSocialImagesArr objectAtIndex:indexPath.row];
                    cell.socilImageView.image = [UIImage imageWithData:tmpData];
                }
                else
                {
                    cell.socilImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
                }
                [cell.activityIndicator stopAnimating];
                
            }

        }
        else
        {
            if ([offlineSocialImagesArr count] == [socialArray count])
            {
                NSData *tmpData = [offlineSocialImagesArr objectAtIndex:indexPath.row];
                cell.socilImageView.image = [UIImage imageWithData:tmpData];
            }
            else
            {
                cell.socilImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
            }
            [cell.activityIndicator stopAnimating];
        }
        
                
        
   
       
        
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSMutableDictionary *tmpDict = [socialArray objectAtIndex:indexPath.row];
    
    if ([tmpDict objectForKey:@"meidaurl"]!=nil)
    {
     
    NSString *urlString = [tmpDict objectForKey:@"meidaurl"];
    
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
    self.title = @"Social Media";
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;

    [self assignStyles];
    
    socialArray = [[NSMutableArray alloc] initWithCapacity:0];
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"sociallist"] objectForKey:@"social"] isKindOfClass:[NSDictionary class]]) 
    {
        [socialArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"sociallist"] objectForKey:@"social"]];
    }
    else
    {
        [socialArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"sociallist"] objectForKey:@"social"]];
    }    
    
    
    offlineSocialImagesArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSString *filePath  = [self dataFilePathForOfflineImages];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        
        if ([tmpDict objectForKey:@"offLineSocialImagesArry"]!= nil)
        {
            [offlineSocialImagesArr addObjectsFromArray:[tmpDict objectForKey:@"offLineSocialImagesArry"]];
        }
        
    }
       

    int height = [socialArray count] * kSocialTableCellHeight;
    if (height > 270)
    {
        height = 270;
    }
    socialTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 5, 300, height)];
    socialTableView.delegate = self;
    socialTableView.dataSource = self;
    socialTableView.showsVerticalScrollIndicator = NO;
    socialTableView.backgroundColor = [UIColor clearColor];
    socialTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:socialTableView];
    [subBgView setFrame:CGRectMake(5, 5, 310, height+15)];
    
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
