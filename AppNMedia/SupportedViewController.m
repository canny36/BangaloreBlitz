//
//  SupportedViewController.m
//  AppNMedia
//
//  Created by Srinivas on 11/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "SupportedViewController.h"
#import "AppNMediaAppDelegate.h"
#import "SupportedByTableViewCell.h"
#import "Util.h"
#import "SupportedBy.h"

#define ksupportedByTableCellHeight 80.0

@interface SupportedViewController ()

@end

@implementation SupportedViewController

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
    if (supportedByArray != nil && [supportedByArray count]>0)
    {
        return [supportedByArray count];
        
    }
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ksupportedByTableCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SupportedByTableViewCell *cell;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (SupportedByTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[SupportedByTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.titleLabel.textColor = [Util subTitleColor];
        cell.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    NSMutableDictionary *tmpDict = [supportedByArray objectAtIndex:indexPath.row];
      
    
    if ([tmpDict objectForKey:@"title"]!= nil)
    {
        cell.titleLabel.text = [tmpDict objectForKey:@"title"];
    }
   
    NSString *logo =  [tmpDict objectForKey:@"logo"];
    
    
    if (logo != nil && ![logo isEqualToString:@""]) {
       
       NSMutableString *mainlogo = [NSMutableString stringWithString:BASE_URL];
        [mainlogo appendString:logo];
          NSLog(@" URL AT %d = %@  ", indexPath.row, mainlogo);
        [self loadImageAtIndexpath:indexPath urlString:mainlogo cell :(SupportedByTableViewCell*)cell];
    }else{
        
    }
    
    return cell;
    
}


-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    self.title = @"SUPPORTED BY";
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    
    supportedByArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"supportedbylist"] objectForKey:@"supportedby"]  isKindOfClass:[NSDictionary class]])
    {
        [supportedByArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"supportedbylist"] objectForKey:@"supportedby"] ];
    }
    else
    {
        [supportedByArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"supportedbylist"] objectForKey:@"supportedby"]];
    }

    
   NSMutableArray *array = [SupportedBy collection];
    NSLog(@" SUPPOERTD ARRAY %@ ",array);
    
    NSLog(@"the supporters array = %@",supportedByArray);
    supportedByTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 20, 310, 270)];
    supportedByTableView.dataSource = self;
    supportedByTableView.delegate = self;
    supportedByTableView.backgroundColor = [UIColor clearColor];
    supportedByTableView.showsVerticalScrollIndicator = NO;
    [supportedByTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    supportedByTableView.separatorColor = [UIColor clearColor];
        [self.view addSubview:supportedByTableView];
    
    
    imageDownloader = [ImageDownloader shareInstance];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



-(void)loadImageAtIndexpath:(NSIndexPath*)indexpath urlString :(NSString*)url cell :(SupportedByTableViewCell*)cell{
    
    CGSize point  = CGSizeMake(100, 80);
    
//    [NSInvocationOperation ];
    
   UIImage *image =  [imageDownloader getImage:url];
    if (image != nil) {
        NSLog(@"HIT AT %@ ",url);
//        SupportedByTableViewCell *cell = (SupportedByTableViewCell*)[supportedByTableView cellForRowAtIndexPath:indexpath];
        
        cell.supporterImageView.image = image;
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
    
//    SupportedByTableViewCell *cell = (SupportedByTableViewCell*)[supportedByTableView cellForRowAtIndexPath:imageLoader.indexPath];
//    cell.supporterImageView.image = image;
//    [supportedByTableView reloadData];
//    [appDelegate cacheImage:image withKey:imageLoader.url];
    
//    [supportedByTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:imageLoader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    [self performSelectorOnMainThread:@selector(updateCell:) withObject:imageLoader waitUntilDone:YES];
    
}

-(void)updateCell:(ImageLoader*)loader{
    [supportedByTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:loader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)onErrorLoadingImage:(ImageLoader*)imageLoader{
    NSLog(@"ERROR DOWNLOADING ");

    [currentDownloads removeObject:imageDownloader];
}

@end
