//
//  FunFactsViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 04/07/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "FunFactsViewController.h"
#import "AppNMediaAppDelegate.h"
#import "FunFactsTableViewCell.h"
#import "WebViewController.h"

#define kfunFactsTableCellHeight 80.0

@implementation FunFactsViewController

- (NSString *)dataFilePathForOfflineImages
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"offlineImages.plist"];
}

-(void)makeaMap :(int )selectedAddress
{
    NSMutableDictionary *tmpDict = [funFactsArray objectAtIndex:selectedAddress];
    if ([tmpDict objectForKey:@"pictureurl"] != nil)
    {
        NSString *urlString = [tmpDict objectForKey:@"pictureurl"];
        
       // NSLog(@"picture url = %@",urlString);
        
        webViewController = [[WebViewController alloc] init];
        
        webViewController.urlString = urlString;
        
        [self presentModalViewController:webViewController animated:YES];
        
    }
    
}
-(void)openWeb:(int)intSelected
{
    NSMutableDictionary *tmpDict = [funFactsArray objectAtIndex:intSelected];
    if ([tmpDict objectForKey:@"pictureurl"] != nil)
    {
        NSString *urlString = [tmpDict objectForKey:@"pictureurl"];
        
        webViewController = [[WebViewController alloc] init];
        
        webViewController.urlString = urlString;
        
        [self presentModalViewController:webViewController animated:YES];
        
    }

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark Table View datasource and delegate methods 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [funFactsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kfunFactsTableCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FunFactsTableViewCell *cell;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (FunFactsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[FunFactsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    [cell.descriptionTextView setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];
    
    cell.descriptionTextView.textColor = [UIColor whiteColor];
    
    NSMutableDictionary *tmpDict = [funFactsArray objectAtIndex:indexPath.row];

    
    cell.descriptionTextView.tag = indexPath.row;
    cell.ffvc = self;
    
    if ([tmpDict objectForKey:@"description"]!= nil) 
    {
        cell.descriptionTextView.text = [tmpDict objectForKey:@"description"];
    }
    
    cell.funFactsImageView.tag = indexPath.row;
    
    if (appDelegate.runAppInOffline == NO)
    {
        BOOL network = [appDelegate networkCheckingMethod];
        
        if (network == YES)
        {
            
            NSString *baseUrl = BASE_URL;
            if ([tmpDict objectForKey:@"picture"] != nil) 
            {
                NSString *imageUrl = [tmpDict objectForKey:@"picture"];
                baseUrl = [baseUrl stringByAppendingString:imageUrl];
                
            }
            
            [cell performSelectorInBackground:@selector(assignImage:) withObject:baseUrl];
        }
        else
        {
            if ([offLineFunFactsImagesArray count] == [funFactsArray count])
            {
                NSData *tmpData = [offLineFunFactsImagesArray objectAtIndex:indexPath.row];
                cell.funFactsImageView.image = [UIImage imageWithData:tmpData];
            }
            else
            {
                cell.funFactsImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
            }
            [cell.activityIndicator stopAnimating];
            
        }
        
    }
    else
    {
        if ([offLineFunFactsImagesArray count] == [funFactsArray count])
        {
            NSData *tmpData = [offLineFunFactsImagesArray objectAtIndex:indexPath.row];
            cell.funFactsImageView.image = [UIImage imageWithData:tmpData];
        }
        else
        {
            cell.funFactsImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
        }
        [cell.activityIndicator stopAnimating];
        
    }
    

    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSMutableDictionary *tmpDict = [funFactsArray objectAtIndex:indexPath.row];
//    if ([tmpDict objectForKey:@"pictureurl"] != nil)
//    {
//        NSString *urlString = [tmpDict objectForKey:@"pictureurl"];
//                
//        webViewController = [[WebViewController alloc] init];
//        
//        webViewController.urlString = urlString;
//        
//        [self presentModalViewController:webViewController animated:YES];
//        
//    }
//    
    
}
-(void)assignStyles
{
    titleFontName =@"Helvetica-Bold";
    titleFontSize = @"14";
    
    subTitleFontName =@"Helvetica";
    subTitleFontSize = @"12";
    


    
}
-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    self.title = @"Fun Facts";
    
    [self assignStyles];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;
    
    
    funFactsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"funfactslist"] objectForKey:@"funfact"]  isKindOfClass:[NSDictionary class]]) 
    {
        [funFactsArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"funfactslist"] objectForKey:@"funfact"] ];
    }
    else
    {
        [funFactsArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"funfactslist"] objectForKey:@"funfact"]];
    }  

   // NSLog(@"%@",funFactsArray);
    offLineFunFactsImagesArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSString *filePath  = [self dataFilePathForOfflineImages];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        
        if ([tmpDict objectForKey:@"offlineFunFactsImagesArr"]!= nil)
        {
            [offLineFunFactsImagesArray addObjectsFromArray:[tmpDict objectForKey:@"offlineFunFactsImagesArr"]];
        }
        
    }

    funFactsTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, 310,280)];
    funFactsTableView.dataSource = self;
    funFactsTableView.delegate = self;
    funFactsTableView.backgroundColor = [UIColor clearColor];
    funFactsTableView.showsVerticalScrollIndicator = NO;
    [funFactsTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    funFactsTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:funFactsTableView];
    
    [subBgView setFrame:CGRectMake(0, 5, 320 , 290)];

}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{

    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
