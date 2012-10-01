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
#import "Util.h"
#import "ImageLoader.h"

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
   CustomTableViewCell *cell = nil;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        [cell setDefaultImage:nil];
    }
    
    NSMutableDictionary *tmpDict = [socialArray objectAtIndex:indexPath.row];

    cell.textLabel.text = [tmpDict objectForKey:@"medianame"];
    
    NSString *logo =  [tmpDict objectForKey:@"logo"];
    NSLog(@" LOGO %@   ",logo);
    if (logo != nil && ![logo isEqualToString:@""]) {
        
        NSMutableString *mainlogo = [NSMutableString stringWithString:BASE_URL];
        [mainlogo appendString:logo];
        NSLog(@" URL AT %d = %@  ", indexPath.row, mainlogo);
        [self loadImageAtIndexpath:indexPath urlString:mainlogo cell : cell];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSMutableDictionary *tmpDict = [socialArray objectAtIndex:indexPath.row];
    
    NSString *urlString = [tmpDict objectForKey:@"meidaurl"];
    
    NSLog(@" MEDIA URL %@ ",urlString);
    
    if (urlString !=nil)
    {
        [self openUrl:urlString];
    
    }
    
}


- (BOOL) validateUrl: (NSString *) candidate {
    
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    
    return [urlTest evaluateWithObject:candidate];
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
    
    socialArray = [[NSMutableArray alloc] initWithCapacity:0];
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"sociallist"] objectForKey:@"social"] isKindOfClass:[NSDictionary class]]) 
    {
        [socialArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"sociallist"] objectForKey:@"social"]];
    }
    else
    {
        [socialArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"sociallist"] objectForKey:@"social"]];
    }    
    
    
    socialTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, 310, 290)];
    socialTableView.delegate = self;
    socialTableView.dataSource = self;
    socialTableView.showsVerticalScrollIndicator = NO;
    socialTableView.backgroundColor = [UIColor clearColor];
    socialTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    socialTableView.separatorColor
    =[UIColor clearColor];
    [self.view addSubview:socialTableView];
    

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
    
    [socialTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:loader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    
}


@end
