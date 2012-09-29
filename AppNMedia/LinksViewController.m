//
//  LinksViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "LinksViewController.h"
#import "AppNMediaAppDelegate.h"
#import "WebViewController.h"
#import "LinksTableCell.h"

#define kLinksTableCellHeight 100.0
@implementation LinksViewController

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
    return [linksArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kLinksTableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell;
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
        if (cell == nil)
        {
            cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
            [cell setDefaultImage:nil];
        }
        NSMutableDictionary *tmpDict = [linksArray objectAtIndex:indexPath.row];

        cell.textLabel.text = [tmpDict objectForKey:@"linkname"];
        NSString *logo =           
        [tmpDict objectForKey:@"logo"];
        
        if (logo != nil && ![logo isEqualToString:@""]) {
            
            NSMutableString *mainlogo = [NSMutableString stringWithString:BASE_URL];
            [mainlogo appendString:logo];
            NSLog(@" URL AT %d = %@  ", indexPath.row, mainlogo);
            [self loadImageAtIndexpath:indexPath urlString:mainlogo cell:cell];
            
        }   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSMutableDictionary *tmpDict = [linksArray objectAtIndex:indexPath.row];
    
    NSLog(@"LINK URL %@ ",[tmpDict objectForKey:@"linkurl"]);
    
    if ([tmpDict objectForKey:@"linkurl"]!=nil)
    {
        
        NSString *urlString = [tmpDict objectForKey:@"linkurl"];
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
    self.title = @"Links";
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;
   
    linksArray = [[NSMutableArray alloc] initWithCapacity:0];
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"linkslist"] objectForKey:@"link"] isKindOfClass:[NSDictionary class]]) 
    {
        [linksArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"linkslist"] objectForKey:@"link"]];
    }
    else
    {
        [linksArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"linkslist"] objectForKey:@"link"]];
    }    
  

    linksTableView = [[UITableView alloc]initWithFrame:CGRectMake(5, 5,310, 300)];
    linksTableView.delegate=self;
    linksTableView.dataSource = self;
    linksTableView.showsVerticalScrollIndicator = NO;
    linksTableView.backgroundColor = [UIColor clearColor];
    linksTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    linksTableView.separatorColor = [UIColor clearColor];
    
    [self.view addSubview:linksTableView];
    
}




-(void)updateCell:(ImageLoader*)loader{
    [linksTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:loader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
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
