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
   CustomTableViewCell *cell;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (CustomTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        [cell setDefaultImage:nil];
    }
    
    cell.textLabel.text = @"NEWS";
     NSMutableDictionary *tmpDict = [newsArray objectAtIndex:indexPath.row];

     NSString *logo =  [tmpDict objectForKey:@"logo"];
    
    
    if (logo != nil && ![logo isEqualToString:@""]) {
        
        NSMutableString *mainlogo = [NSMutableString stringWithString:BASE_URL];
        [mainlogo appendString:logo];
        NSLog(@" URL AT %d = %@  ", indexPath.row, mainlogo);
        [self loadImageAtIndexpath:indexPath urlString:mainlogo cell :cell];
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
 
    newsArray = [[NSMutableArray alloc] initWithCapacity:0];
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"newslist"] objectForKey:@"news"] isKindOfClass:[NSDictionary class]]) 
    {
        [newsArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"newslist"] objectForKey:@"news"]];
    }
    else
    {
        [newsArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"newslist"] objectForKey:@"news"]];
    }    
    
    newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, 310, 290)];
    newsTableView.delegate = self;
    newsTableView.dataSource =self;
    newsTableView.showsVerticalScrollIndicator = NO;
    newsTableView.backgroundColor = [UIColor clearColor];
    newsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    newsTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:newsTableView];
    
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
    
    [newsTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:loader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    
}

@end
