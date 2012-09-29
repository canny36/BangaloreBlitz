//
//  SponsersViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "SponsersViewController.h"
#import "AppNMediaAppDelegate.h"
#import "SponsorsTableCell.h"
#import "WebViewController.h"
#import "SPonsor.h"
#import "Util.h"
#import "ImageLoader.h"

#define kSponsersTableCellHeight 80.0

@implementation SponsersViewController

@synthesize sponsorsArray;
@synthesize categoryName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}


#pragma mark Table View datasource and delegate methods 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [sponsorsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kSponsersTableCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        [cell setDefaultImage:nil];
    }
    
    SPonsor *sponsor = [sponsorsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = sponsor.level;
    cell.detailTextLabel.text = sponsor.name;
   
   
    NSString *logo =  sponsor.logo;
    NSLog(@" LOGO %@   ",logo);
    if (logo != nil && ![logo isEqualToString:@""]) {
        
        NSMutableString *mainlogo = [NSMutableString stringWithString:BASE_URL];
        [mainlogo appendString:logo];
        NSLog(@" URL AT %d = %@  ", indexPath.row, mainlogo);
        [self loadImageAtIndexpath:indexPath urlString:mainlogo cell : cell];
    }else{
        NSLog(@" NO LOGO   ");
        
    }
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
//    NSMutableDictionary *tmpDict = [sponsersArray objectAtIndex:indexPath.row];
//    
//    if ([tmpDict objectForKey:@"website"]!=nil)
//    {
//        
//        NSString *urlString = [tmpDict objectForKey:@"website"];
//        
//        webViewController = [[WebViewController alloc] init];
//        
//        webViewController.urlString = urlString;
//        
//        [self presentModalViewController:webViewController animated:YES];
//        
//    }
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
    
    categoryName = [categoryName stringByAppendingString:@" Sponsors"];
    self.title = categoryName;
    sponsersTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, 310, 290)];
    sponsersTableView.delegate= self;
    sponsersTableView.dataSource = self;
    sponsersTableView.showsVerticalScrollIndicator = NO;
    sponsersTableView.backgroundColor = [UIColor clearColor];
    sponsersTableView.separatorColor = [UIColor clearColor];
    sponsersTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    sponsersTableView.separatorColor = [UIColor clearColor];
    
    [self.view addSubview:sponsersTableView];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)updateCell:(ImageLoader*)loader{
    [sponsersTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:loader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}

@end
