//
//  NearByDetailViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 04/07/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "NearByDetailViewController.h"
#import "AppNMediaAppDelegate.h"
#import "NearByTableViewCell.h"
#import "UIImage+scale.h"
#import "WebViewController.h"

#define kNearbyTableCellHeight 120
@implementation NearByDetailViewController
@synthesize selectedArray;
@synthesize selectedType;

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

-(void)makePhoneCall:(int )selctedLocation
{
    NSMutableDictionary *tmpDict = [selectedArray objectAtIndex:selctedLocation];
    if ([tmpDict objectForKey:@"phone"]!= nil)
    {
        NSString *strPhoneNumber = [tmpDict objectForKey:@"phone"] ;
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]])
        {
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
        
    }
    
    
}
-(void)photosViewClicked:(int )selected
{
    //[self makeaMap:selected];
    
    NSMutableDictionary *tmpDict = [selectedArray objectAtIndex:selected];
    if ([tmpDict objectForKey:@"website"]!= nil)
    {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[tmpDict objectForKey:@"website"]]]) 
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[tmpDict objectForKey:@"website"]]];
        }
    }
    
    
}
-(void)makeaMap :(int )selectedAddress
{
    NSMutableDictionary *tmpDict = [selectedArray objectAtIndex:selectedAddress];
    NSString *tmpStr = @"";
    
    
    if ([tmpDict objectForKey:@"address1"] != nil)
    {
        tmpStr=  [tmpStr stringByAppendingString:[tmpDict objectForKey:@"address1"]];
        tmpStr=  [tmpStr stringByAppendingString:@", "];
        
    }
    
    if ([tmpDict objectForKey:@"city"] != nil)
    {
        tmpStr=  [tmpStr stringByAppendingString:[tmpDict objectForKey:@"city"]];
        tmpStr=  [tmpStr stringByAppendingString:@", "];
    }   
    else
    {
        tmpStr=  [tmpStr stringByReplacingOccurrencesOfString:@"," withString:@""];
        
    }
    if ([tmpDict objectForKey:@"state"] != nil)
    {
        tmpStr=  [tmpStr stringByAppendingString:[tmpDict objectForKey:@"state"]];
        tmpStr=  [tmpStr stringByAppendingString:@", "];
    }
    else
    {
        tmpStr=  [tmpStr stringByReplacingOccurrencesOfString:@"," withString:@""];
        
    }
    
    if ([tmpDict objectForKey:@"zipcode"] != nil)
    {
        tmpStr=  [tmpStr stringByAppendingString:[tmpDict objectForKey:@"zipcode"]];
    }
    else
    {
        tmpStr=  [tmpStr stringByReplacingOccurrencesOfString:@"," withString:@""];
        
    }
    
   // NSLog(@"map adress = %@",tmpStr);

    openMap = [[mapViews alloc] init];
        
    openMap.urlString = tmpStr;
        
    [self presentModalViewController:openMap animated:YES];
    
//    if ([tmpDict objectForKey:@"website"]!= nil)
//    {
////        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[tmpDict objectForKey:@"website"]]]) 
////        {
////            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[tmpDict objectForKey:@"website"]]];
////        }
//        
//        NSString *urlString = [tmpDict objectForKey:@"website"];
//        
//                webViewController = [[WebViewController alloc] init];
//                
//                webViewController.urlString = urlString;
//               
//                [self presentModalViewController:webViewController animated:YES];
//        
//
//        
//    }
//    
    
    
}


- (void)dealloc
{
    
}
-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark Table View datasource and delegate methods 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  [selectedArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return kNearbyTableCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
   CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
    }

    
    NSMutableDictionary *tmpDict = [selectedArray objectAtIndex:indexPath.row];
    
    if ([tmpDict objectForKey:@"name"] != nil) 
    {
        cell.textLabel.text = [tmpDict objectForKey:@"name"];
    }
    
    NSString *tmpStr = @"";
    
    tmpStr = @"Ph : ";
    if ([tmpDict objectForKey:@"phone"] != nil)
    {
        tmpStr=  [tmpStr stringByAppendingString:[tmpDict objectForKey:@"phone"]];
        
    }
   
    if ([tmpDict objectForKey:@"address1"] != nil)
    {
        
        tmpStr=  [tmpStr stringByAppendingString:@" \n "];
        tmpStr=  [tmpStr stringByAppendingString:[tmpDict objectForKey:@"address1"]];
        tmpStr=  [tmpStr stringByAppendingString:@", "];
        
    }
    
    if ([tmpDict objectForKey:@"city"] != nil)
    {
        tmpStr=  [tmpStr stringByAppendingString:[tmpDict objectForKey:@"city"]];
        tmpStr=  [tmpStr stringByAppendingString:@", "];
    }   
    else
    {
        tmpStr=  [tmpStr stringByReplacingOccurrencesOfString:@"," withString:@""];
        
    }
//    if ([tmpDict objectForKey:@"state"] != nil)
//    {
//        tmpStr=  [tmpStr stringByAppendingString:[tmpDict objectForKey:@"state"]];
//        tmpStr=  [tmpStr stringByAppendingString:@", "];
//    }
//    else
//    {
//        tmpStr=  [tmpStr stringByReplacingOccurrencesOfString:@"," withString:@""];
//
//    }
    
    if ([tmpDict objectForKey:@"zipcode"] != nil)
    {
        tmpStr=  [tmpStr stringByAppendingString:[tmpDict objectForKey:@"zipcode"]];
    }
    else
    {
        tmpStr=  [tmpStr stringByReplacingOccurrencesOfString:@"," withString:@""];
        
    }
    

    cell.detailTextLabel.text = tmpStr;
    cell.detailTextLabel.numberOfLines = 5;

    
    NSString *logo =  [tmpDict objectForKey:@"logo"];
    
    
    if (logo != nil && ![logo isEqualToString:@""]) {
        
        NSMutableString *mainlogo = [NSMutableString stringWithString:BASE_URL];
        [mainlogo appendString:logo];
        NSLog(@" URL AT %d = %@  ", indexPath.row, mainlogo);
        [self loadImageAtIndexpath:indexPath urlString:mainlogo cell :cell];
    }else{
        
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableDictionary *tmpDict = [selectedArray objectAtIndex:indexPath.row];
       if ([tmpDict objectForKey:@"website"]!= nil)
       {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[tmpDict objectForKey:@"website"]]]) 
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[tmpDict objectForKey:@"website"]]];
            }
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
    self.title = selectedType;
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;
    
    
   
    nearbyArray = [[NSMutableArray alloc] initWithCapacity:0];
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"nearbylist"] objectForKey:@"nearby"] isKindOfClass:[NSDictionary class]]) 
    {
        [nearbyArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"nearbylist"] objectForKey:@"nearby"]];
    }
    else
    {
        [nearbyArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"nearbylist"] objectForKey:@"nearby"]];
    }   

   
       
    
    
//    int height = [selectedArray count] * kNearbyTableCellHeight;
//    
//    if (height > 270)
//    {
//        height = 270;
//    }
    
    nearbyTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, 310,280)];
    nearbyTableView.delegate = self;
    nearbyTableView.dataSource = self;
    nearbyTableView.showsVerticalScrollIndicator = NO;
    nearbyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    nearbyTableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:nearbyTableView];

//    transparentImageView.frame = CGRectMake(30, 70, 260, 250);
    
    
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
    [nearbyTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:loader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}




@end
