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
#import "VideosViewController.h"
#import "VideosTableCell.h"
#import "Util.h"

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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return section == 1 ? @"Videos":@"Photos";
//}


#pragma mark Table View datasource and delegate methods 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return section == 0 ? [photosArray count] : [videosArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kPhotosTableCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        CustomTableViewCell *cell = nil;
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
        cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil)
        {
            cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
          
        }
        
        NSMutableDictionary *tmpDict = [photosArray objectAtIndex:indexPath.row];

    if ([tmpDict objectForKey:@"photoname"]!= nil)
        {
            cell.textLabel.text = [tmpDict objectForKey:@"photoname"];
        }
        
        NSString *logo =  [tmpDict objectForKey:@"logo"];
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
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSMutableDictionary *tmpDict = [photosArray objectAtIndex:indexPath.row];
    if ([tmpDict objectForKey:@"image"]!= nil)
    {
        NSString *imageUrl = [tmpDict objectForKey:@"image"];
       
        
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
    
    photosArray = [[NSMutableArray alloc] initWithCapacity:0];
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"photoslist"] objectForKey:@"photo"] isKindOfClass:[NSDictionary class]]) 
    {
        [photosArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"photoslist"] objectForKey:@"photo"]];
    }
    else
    {
        [photosArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"photoslist"] objectForKey:@"photo"]];
    }    

       
    photosScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 5, 300, 280)];
    photosScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:photosScrollView];
    
    photosTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, 310,280)];
    photosTableView.delegate = self;
    photosTableView.dataSource =self;
    photosTableView.showsVerticalScrollIndicator = NO;
    photosTableView.backgroundColor = [UIColor clearColor];
    photosTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:photosTableView];


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
    [photosTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:loader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}


@end
