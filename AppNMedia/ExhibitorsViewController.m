//
//  ExhibitorsViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 24/05/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "ExhibitorsViewController.h"
#import "AppNMediaAppDelegate.h"
#import "ExhibitorsTableCell.h"
#import "WebViewController.h"
#define kExhibitorsTableCellHeight 150

@implementation ExhibitorsViewController
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


-(void)makeaMap :(int )selectedAddress
{
    NSMutableDictionary *tmpDict = [exhibitorsArray objectAtIndex:selectedAddress];
    NSString *tmpStr = @"";
    
    if ([tmpDict objectForKey:@"location_address"] != nil)
    {
        tmpStr=  [tmpStr stringByAppendingString:[tmpDict objectForKey:@"location_address"]];
        
    }
   
    
    openMap = [[mapViews alloc] init];
    
    openMap.urlString = tmpStr;
    
    [self presentModalViewController:openMap animated:YES];
}



-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)dealloc
{
    exhibitorsArray = nil;
//    [exhibitorsArray release];
//    [exhibitorsTableView release];
    offlineExhibitorsImagesArr = nil;
//    [offlineExhibitorsImagesArr release];
//    [super dealloc];

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
    return [exhibitorsArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kExhibitorsTableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    ExhibitorsTableCell *cell = (ExhibitorsTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[ExhibitorsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
   
    NSMutableDictionary *tmpDict = [exhibitorsArray objectAtIndex:indexPath.row];

    
    [cell.nameLabel setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];
    cell.nameLabel.textColor = [UIColor whiteColor];
    
    
    [cell.locationTxtView setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];
    cell.locationTxtView.textColor = [UIColor whiteColor];
    
    
    [cell.roomTxtView setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];
    cell.roomTxtView.textColor = [UIColor whiteColor];
    
    
    cell.nameLabel.text = [tmpDict objectForKey:@"name"]; 
    cell.evc =self;
    cell.locationTxtView.tag = indexPath.row;
    if ([tmpDict objectForKey:@"location_address"] != nil) 
    {
        cell.locationTxtView.text = [tmpDict objectForKey:@"location_address"]; 
        //NSLog(@"%@",[tmpDict objectForKey:@"location_address"]);

    }
    if ([tmpDict objectForKey:@"room"] != nil) 
    {
        cell.roomTxtView.text = [tmpDict objectForKey:@"room"]; 
        
    }
    
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
            if ([offlineExhibitorsImagesArr count] == [exhibitorsArray count])
            {
                NSData *tmpData = [offlineExhibitorsImagesArr objectAtIndex:indexPath.row];
                cell.exhibitorsImageView.image = [UIImage imageWithData:tmpData];
            }
            else
            {
                cell.exhibitorsImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
            }
            [cell.activityIndicator stopAnimating]; 
        }
   
    }
    else
    {
        if ([offlineExhibitorsImagesArr count] == [exhibitorsArray count])
        {
            NSData *tmpData = [offlineExhibitorsImagesArr objectAtIndex:indexPath.row];
            cell.exhibitorsImageView.image = [UIImage imageWithData:tmpData];
        }
        else
        {
            cell.exhibitorsImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
        }
        [cell.activityIndicator stopAnimating]; 

    }

    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSMutableDictionary *tmpDict = [exhibitorsArray objectAtIndex:indexPath.row];
    if ([tmpDict objectForKey:@"website"] != nil)
    {
        NSString *urlString = [tmpDict objectForKey:@"website"];
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];

    webViewController = [[WebViewController alloc] init];
    
    webViewController.urlString = urlString;
    
    [self presentModalViewController:webViewController animated:YES];
        
    }

       
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
    [self assignStyles];
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;

    
    self.title = @"Exhibitors";
    
    exhibitorsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"exhibitorslist"] objectForKey:@"exhibitor"] isKindOfClass:[NSDictionary class]]) 
    {
        [exhibitorsArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"exhibitorslist"] objectForKey:@"exhibitor"]];
    }
    else
    {
        [exhibitorsArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"exhibitorslist"] objectForKey:@"exhibitor"]];
    }    
        
    offlineExhibitorsImagesArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSString *filePath  = [self dataFilePathForOfflineImages];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        
        if ([tmpDict objectForKey:@"offlineExhibitorsImagesArr"]!= nil)
        {
            [offlineExhibitorsImagesArr addObjectsFromArray:[tmpDict objectForKey:@"offlineExhibitorsImagesArr"]];
        }
        
//        [tmpDict release];
    }
    
    
    int height = [exhibitorsArray count] * kExhibitorsTableCellHeight;
    
    if (height > 270)
    {
        height = 270;
    }

    
    exhibitorsTableView =[[UITableView alloc] initWithFrame:CGRectMake(10, 5, 300, height)];
    exhibitorsTableView.dataSource= self;
    exhibitorsTableView.delegate = self;
    exhibitorsTableView.backgroundColor = [UIColor clearColor];
    exhibitorsTableView.showsVerticalScrollIndicator= NO;
    exhibitorsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:exhibitorsTableView];
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
