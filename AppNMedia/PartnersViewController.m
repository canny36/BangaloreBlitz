//
//  PartnersViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 24/05/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "PartnersViewController.h"
#import "AppNMediaAppDelegate.h"
#import "PartnersTableCell.h"
#import "WebViewController.h"
#import "ImageDownloader.h"
#import "Util.h"

#define kPartnersTableCellHeight 80
@implementation PartnersViewController

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
-(void)makePhoneCall:(int )selctedPartner
{
    NSMutableDictionary *tmpDict = [partnersArray objectAtIndex:selctedPartner];
    if ([tmpDict objectForKey:@"phone"]!= nil)
    {
        NSString *strPhoneNumber = [tmpDict objectForKey:@"phone"] ;
//        
//        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]])
//        {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", strPhoneNumber ]]];
//        } 
//        else 
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You can't call from this device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
////            [alert release];
//        }
        
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]])
        {
            
            NSMutableString *strippedString = [NSMutableString 
                                               stringWithCapacity:strPhoneNumber.length];
            
            NSScanner *scanner = [NSScanner scannerWithString:strPhoneNumber];
            NSCharacterSet *numbers = [NSCharacterSet 
                                       characterSetWithCharactersInString:@"0123456789"];
            
            while ([scanner isAtEnd] == NO) {
                NSString *buffer;
                if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
                    [strippedString appendString:buffer];
                    
                } else {
                    [scanner setScanLocation:([scanner scanLocation] + 1)];
                }
            }
            
           // NSLog(@"%@", strippedString); 
            
        
            strPhoneNumber = [strPhoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
            strPhoneNumber = [strPhoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];

            
            
                              
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", strPhoneNumber ]]];
        } 
        else 
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You can't call from this device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }

        

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No details available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
//        [alert release];
 
    }
    
    
}

 
-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)assignStyles
{
    titleFontName =@"HelveticaNeue-Bold";
    titleFontSize = @"16";
    
    subTitleFontName =@"HelveticaNeue";
    subTitleFontSize = @"12";

}


#pragma mark Table View datasource and delegate methods 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [partnersArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kPartnersTableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    PartnersTableCell *cell = (PartnersTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[PartnersTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.pvController = self;
    cell.phoneLabel.tag = indexPath.row;

    
       
    [cell.nameLabel setFont:[UIFont fontWithName:[Util titleFontName] size:15]];
    cell.nameLabel.textColor = [Util titleColor];
    
    [cell.phoneLabel setFont:[UIFont fontWithName:[Util subTitleFontName] size:13]];
    cell.phoneLabel.textColor = [Util subTitleColor];
    
    NSMutableDictionary *tmpDict = [partnersArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = [tmpDict objectForKey:@"name"];
    NSString *type = [tmpDict objectForKey:@"type"];
    cell.phoneLabel.text = type;
    
//        if ([tmpDict objectForKey:@"phone"]!= nil)
//        {
//            [cell.phoneLabel setText:[NSString stringWithFormat:@"Ph : %@", [tmpDict objectForKey:@"phone"]]];
//        }
//       else
//       {
//           [cell.phoneLabel setText:@"No details available"];
//
//       }
    
//    if (appDelegate.runAppInOffline == NO)
//    {
//        BOOL network = [appDelegate networkCheckingMethod];
//        
//        if (network == YES)
//        {
//            
//            NSString *baseUrl =  BASE_URL;
//            if ([tmpDict objectForKey:@"logo"] != nil) 
//            {
//                NSString *imageUrl = [tmpDict objectForKey:@"logo"];
//                baseUrl = [baseUrl stringByAppendingString:imageUrl];
//                
//            }
//            
//            [cell performSelectorInBackground:@selector(assignImage:) withObject:baseUrl];
//        }
//        else
//        {
//            if ([offlinePartnerImagesArr count] == [partnersArray count])
//            {
//                NSData *tmpData = [offlinePartnerImagesArr objectAtIndex:indexPath.row];
//                cell.partnerImageView.image = [UIImage imageWithData:tmpData];
//            }
//            else
//            {
//                cell.partnerImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
//            }
//            [cell.activityIndicator stopAnimating]; 
//        }
//        
//    }
//    else
//    {
//        if ([offlinePartnerImagesArr count] == [partnersArray count])
//        {
//            NSData *tmpData = [offlinePartnerImagesArr objectAtIndex:indexPath.row];
//            cell.partnerImageView.image = [UIImage imageWithData:tmpData];
//        }
//        else
//        {
//            cell.partnerImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
//        }
//        [cell.activityIndicator stopAnimating]; 
//        
//    }

    
    NSString *logo =  [tmpDict objectForKey:@"logo"];

    if (logo != nil && ![logo isEqualToString:@""]) {
        
        NSMutableString *mainlogo = [NSMutableString stringWithString:BASE_URL];
        [mainlogo appendString:logo];
        NSLog(@" URL AT %d = %@  ", indexPath.row, mainlogo);
        [self loadImageAtIndexpath:indexPath urlString:mainlogo cell :(PartnersTableCell*)cell];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    NSMutableDictionary *tmpDict = [partnersArray objectAtIndex:indexPath.row];
    
    if ([tmpDict objectForKey:@"website"]!= nil)
    {
        
    NSString *urlString = [tmpDict objectForKey:@"website"];
    
    webViewController = [[WebViewController alloc] init];
    
    webViewController.urlString = urlString;
    
    [self presentModalViewController:webViewController animated:YES];
    }
}


- (void)dealloc
{
//    [super dealloc];
    partnersArray = nil;
//    [partnersArray release];
//    [partnersTableView release];
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

    self.title = @"Partners";
    
    partnersArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"partnerslist"] objectForKey:@"partner"] isKindOfClass:[NSDictionary class]]) 
    {
        [partnersArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"partnerslist"] objectForKey:@"partner"]];
    }
    else
    {
        [partnersArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"partnerslist"] objectForKey:@"partner"]];
    }  
    
    
    offlinePartnerImagesArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSString *filePath  = [self dataFilePathForOfflineImages];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        
        if ([tmpDict objectForKey:@"offlinePartnersImagesArr"]!= nil)
        {
            [offlinePartnerImagesArr addObjectsFromArray:[tmpDict objectForKey:@"offlinePartnersImagesArr"]];
        }
        
//        [tmpDict release];
    }

    
    
    int height = [partnersArray count] * kPartnersTableCellHeight;
    
    if (height > 270)
    {
        height = 270;
    }
    
    partnersTableView =[[UITableView alloc] initWithFrame:CGRectMake(10, 5, 300, height)];
    partnersTableView.dataSource= self;
    partnersTableView.delegate = self;
    partnersTableView.backgroundColor = [UIColor clearColor];
    partnersTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    partnersTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:partnersTableView];
    [subBgView setFrame:CGRectMake(5, 5, 310, height+15)];

    if ([partnersArray count]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No details available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
//        [alert release];
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


-(void)loadImageAtIndexpath:(NSIndexPath*)indexpath urlString :(NSString*)url cell :(PartnersTableCell*)cell{
    
    CGSize point  = CGSizeMake(100, 80);
    
    //    [NSInvocationOperation ];
    if (imageDownloader == nil) {
        imageDownloader =  [ImageDownloader shareInstance];
    }
    
    
    UIImage *image =  [imageDownloader getImage:url];
    if (image != nil) {
        NSLog(@"HIT AT %@ ",url);
        //        SupportedByTableViewCell *cell = (SupportedByTableViewCell*)[supportedByTableView cellForRowAtIndexPath:indexpath];
        
        cell.partnerImageView.image = image;
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
    [partnersTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:loader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}



-(void)onErrorLoadingImage:(ImageLoader*)imageLoader{
    NSLog(@"ERROR DOWNLOADING ");
    [imageDownloader removeOperation:imageLoader];
    [currentDownloads removeObject:imageDownloader];
}



@end
