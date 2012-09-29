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
    
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        [cell setDefaultImage:nil];
    }
    NSMutableDictionary *tmpDict = [partnersArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [tmpDict objectForKey:@"name"];
    cell.textLabel.numberOfLines=2;
    NSString *type = [tmpDict objectForKey:@"type"];
    cell.detailTextLabel.text = type;
    
    CGSize size = [type sizeWithFont:cell.detailTextLabel.font constrainedToSize:CGSizeMake(cell.detailTextLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    NSLog(@"");
    cell.detailTextLabel.numberOfLines = size.height/16;
    NSString *logo =  [tmpDict objectForKey:@"logo"];

    if (logo != nil && ![logo isEqualToString:@""]) {
        
        NSMutableString *mainlogo = [NSMutableString stringWithString:BASE_URL];
        [mainlogo appendString:logo];
        NSLog(@" URL AT %d = %@  ", indexPath.row, mainlogo);
        [self loadImageAtIndexpath:indexPath urlString:mainlogo cell :cell];
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
    

    
    partnersTableView =[[UITableView alloc] initWithFrame:CGRectMake(5, 5, 310, 300)];
    partnersTableView.dataSource= self;
    partnersTableView.delegate = self;
    partnersTableView.backgroundColor = [UIColor clearColor];
    partnersTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    partnersTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:partnersTableView];
 if ([partnersArray count]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No details available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
//        [alert release];
    }
    
    
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


-(void)updateCell:(ImageLoader*)loader{
    [partnersTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:loader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}



@end
