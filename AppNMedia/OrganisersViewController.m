//
//  OrganisersViewController.m
//  AppNMedia
//
//  Created by apple on 08/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "OrganisersViewController.h"
#import "AppNMediaAppDelegate.h"
#import "Organizer.h"
#import "OrganiserTableViewCell.h"
#import "Util.h"

#define kfunFactsTableCellHeight 80.0
@interface OrganisersViewController ()

@end

@implementation OrganisersViewController

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
    
    if (organisersArray != nil && [organisersArray count]>0)
    {
        return [organisersArray count];

    }
   
        return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kfunFactsTableCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrganiserTableViewCell *cell;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (OrganiserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[OrganiserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.titleLabel.font = [UIFont fontWithName:[Util subTitleFontName] size:15];
        cell.titleLabel.textColor = [Util subTitleColor];
        cell.descriptionLabel.font = [UIFont fontWithName:[Util detailTextFontName] size:15];
        cell.descriptionLabel.textColor = [Util detailTextColor];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    
//    NSMutableDictionary *tmpDict = [organisersArray objectAtIndex:indexPath.row];
    Organizer *organizer  =[organisersArray objectAtIndex:indexPath.row];
    
    cell.descriptionLabel.tag = indexPath.row;
    cell.descriptionLabel.text = organizer.description;
    cell.titleLabel.text = organizer.title;
    
    
    NSString *logo =   organizer.logo;
    
    
    if (logo != nil && ![logo isEqualToString:@""]) {
        
        NSMutableString *mainlogo = [NSMutableString stringWithString:BASE_URL];
        [mainlogo appendString:logo];
        NSLog(@" URL AT %d = %@  ", indexPath.row, mainlogo);
        [self loadImageAtIndexpath:indexPath urlString:mainlogo cell:cell];

    }else{
        
    }
    
    
    
    return cell;

}

-(void)assignStyles
{

    titleFontName =@"Helvetica-Bold";
    titleFontSize = @"14";
    
    subTitleFontName =@"Helvetica";
    subTitleFontSize = @"12";
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [subBgView setFrame:CGRectMake(0, 5, 320, 280)];
    transparentImageView.frame = CGRectMake(30, 70, 260, 250);
    
       
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    self.title = @"Organizers";
    [self assignStyles];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];
    self.navigationItem.rightBarButtonItem = homeButton;
    
//    organisersArray = [[NSMutableArray alloc] initWithCapacity:0];
//    
////    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"organizerslist"] objectForKey:@"organizer"]  isKindOfClass:[NSDictionary class]])
////    {
////        [organisersArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"organizerslist"] objectForKey:@"organizer"] ];
////    }
////    else
////    {
////        [organisersArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"organizerslist"] objectForKey:@"organizer"]];
////    }
    
   organisersArray = [Organizer collection];
    
    
    NSLog(@"the organisers array = %@",organisersArray);
        

    organisersTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 10, 310, 270)];
    organisersTableView.dataSource = self;
    organisersTableView.delegate = self;
    organisersTableView.backgroundColor = [UIColor clearColor];
    organisersTableView.showsVerticalScrollIndicator = NO;
    organisersTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    organisersTableView.separatorColor = [UIColor clearColor];

    [self.view addSubview:organisersTableView];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)loadImageAtIndexpath:(NSIndexPath*)indexpath urlString :(NSString*)url cell :(OrganiserTableViewCell*)cell{
    
    CGSize point  = CGSizeMake(100, 80);
    
    //    [NSInvocationOperation ];
    
    if (imageDownloader == nil) {
        imageDownloader = [ImageDownloader shareInstance];
    }
    
    UIImage *image =  [imageDownloader getImage:url];
    if (image != nil) {
        NSLog(@"HIT AT %@ ",url);
        //        SupportedByTableViewCell *cell = (SupportedByTableViewCell*)[supportedByTableView cellForRowAtIndexPath:indexpath];
        
        cell.organiserImageView.image = image;
        //        [supportedByTableView reloadData];
        
    }else{
        
        NSLog(@"FAIL AT %@ ",url);
        ImageLoader *loader = [[ImageLoader alloc]initWithUrl:url withSize:point delegate:self];
        loader.indexPath = indexpath;
        [imageDownloader addOperation:loader];
        if (currentDownloads == nil) {
            [currentDownloads addObject:loader];
        }
        
        
    }
}

-(void)onDownloadCompletion:(UIImage*)image : (ImageLoader*)imageLoader{
    
    NSLog(@" DOWNLOAD COMPLETED FOR %d ",imageLoader.indexPath.row);
    [currentDownloads removeObject:imageLoader];
    [imageDownloader removeOperation:imageLoader];
    
//    OrganiserTableViewCell *cell = (OrganiserTableViewCell*)[organisersTableView cellForRowAtIndexPath:imageLoader.indexPath];
//    cell.organiserImageView.image = image;
//    //    [supportedByTableView reloadData];
//    //    [appDelegate cacheImage:image withKey:imageLoader.url];
//    
//}


[self performSelectorOnMainThread:@selector(updateCell:) withObject:imageLoader waitUntilDone:YES];

}

-(void)updateCell:(ImageLoader*)loader{
    [organisersTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:loader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)onErrorLoadingImage:(ImageLoader*)imageLoader{
    NSLog(@"ERROR DOWNLOADING ");
    
    [currentDownloads removeObject:imageLoader];
}

-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
