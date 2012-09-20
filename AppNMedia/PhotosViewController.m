//
//  PhotosViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "PhotosViewController.h"
#import "AppNMediaAppDelegate.h"
#import "PhotosTableViewCell.h"
#import "WebViewController.h"
#define kPhotosTableCellHeight 100

@implementation PhotosViewController
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

#pragma mark Table View datasource and delegate methods 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [photosArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kPhotosTableCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhotosTableViewCell *cell;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (PhotosTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[PhotosTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        
        NSMutableDictionary *tmpDict = [photosArray objectAtIndex:indexPath.row];
                
       
        [cell.nameLabel setFont:[UIFont fontWithName:subTitleFontName size:[subTitleFontSize intValue]]];

        cell.nameLabel.textColor = [UIColor whiteColor];
        
        
        if ([tmpDict objectForKey:@"photoname"]!= nil)
        {
            cell.nameLabel.text = [tmpDict objectForKey:@"photoname"];
        }
        
        
        if (appDelegate.runAppInOffline == NO)
        {
            BOOL network = [appDelegate networkCheckingMethod];
            
            if (network == YES)
            {
                if ([tmpDict objectForKey:@"logo"]!=nil)
                {
                    NSString *baseUrl = BASE_URL;
                    NSString *imageUrl = [tmpDict objectForKey:@"logo"];
                    baseUrl = [baseUrl stringByAppendingString:imageUrl];
                    
                    [cell performSelectorInBackground:@selector(assignImage:) withObject:baseUrl];
                }
                else
                {
                    cell.PhotoImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
   
                }
            }
            else
            {
                
                if ([offLinePhotosImagesArry count] == [photosArray count])
                {
                    NSData *tmpData = [offLinePhotosImagesArry objectAtIndex:indexPath.row];
                    cell.PhotoImageView.image = [UIImage imageWithData:tmpData];
                }
                else
                {
                    cell.PhotoImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
                }
                [cell.activityIndicator stopAnimating]; 
            }
        }
        else
        {
            if ([offLinePhotosImagesArry count] == [photosArray count])
            {
                NSData *tmpData = [offLinePhotosImagesArry objectAtIndex:indexPath.row];
                cell.PhotoImageView.image = [UIImage imageWithData:tmpData];
            }
            else
            {
                cell.PhotoImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
            }
            [cell.activityIndicator stopAnimating]; 
            
        }

    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSMutableDictionary *tmpDict = [photosArray objectAtIndex:indexPath.row];
    if ([tmpDict objectForKey:@"image"]!= nil)
    {
        NSString *imageUrl = [tmpDict objectForKey:@"image"];
       
//       webViewController = [[WebViewController alloc] init];
//    
//       webViewController.urlString = imageUrl;
//    
//    [self presentModalViewController:webViewController animated:YES];
        
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:imageUrl]])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:imageUrl]];
        }
            
    }
}

-(void)photosViewButtonClicked:(UIButton *)button
{
    NSMutableDictionary *dict = [photosArray objectAtIndex:button.tag];
    if ([dict objectForKey:@"photoname"]!= nil)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[dict objectForKey:@"photoname"]]];
    }
}
-(void)assignStyles
{
   
    titleFontName =@"Helvetica-Bold";
    titleFontSize = @"14";
    
    subTitleFontName =@"Helvetica";
    subTitleFontSize = @"12";
    

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
    self.title = @"Photos";
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;

    [self assignStyles];
    
    
    photosArray = [[NSMutableArray alloc] initWithCapacity:0];
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"photoslist"] objectForKey:@"photo"] isKindOfClass:[NSDictionary class]]) 
    {
        [photosArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"photoslist"] objectForKey:@"photo"]];
    }
    else
    {
        [photosArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"photoslist"] objectForKey:@"photo"]];
    }    
    
   // NSLog(@"%@",photosArray);
    
    offLinePhotosImagesArry = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *filePath  = [self dataFilePathForOfflineImages];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        
        if ([tmpDict objectForKey:@"offlinePhotosImagesArr"]!= nil)
        {
            [offLinePhotosImagesArry addObjectsFromArray:[tmpDict objectForKey:@"offlinePhotosImagesArr"]];
        }
        
    }    
    
    
    photosScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 5, 300, 280)];
    photosScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:photosScrollView];
    
    [subBgView setFrame:CGRectMake(5, 5, 312, 285)];
    int height = [photosArray count] * kPhotosTableCellHeight;
    if (height > 270)
    {
        height = 270;
    }
    
    
    photosTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 5, 300, height)];
    photosTableView.delegate = self;
    photosTableView.dataSource =self;
    photosTableView.showsVerticalScrollIndicator = NO;
    photosTableView.backgroundColor = [UIColor clearColor];
    photosTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:photosTableView];
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
