//
//  NearbyViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "NearbyViewController.h"
#import "AppNMediaAppDelegate.h"
#import "NearByTypestableCell.h"
#import "NearByDetailViewController.h"
#import "Util.h"

@implementation NearbyViewController
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
       
    }
    return self;
}

-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)assignStyles
{
    titleFontName =@"Helvetica-Bold";
    titleFontSize = @"14";
    
    subTitleFontName =@"Helvetica";
    subTitleFontSize = @"12";
}

#pragma mark Table View datasource and delegate methods 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return  [nearByTypesArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
       CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {

        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
 
        cell.textLabel.text = [nearByTypesArray objectAtIndex:indexPath.row];

    return cell;
        
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    selectedType = [nearByTypesArray objectAtIndex:indexPath.row];

    NearByDetailViewController *nearByDetailViewController = [[NearByDetailViewController alloc] init];
    nearByDetailViewController.selectedArray =[self mainNearByTableCreation];
    nearByDetailViewController.selectedType = selectedType;
    [self.navigationController pushViewController:nearByDetailViewController animated:YES];
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
    self.title = @"Near By";
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];


    
    
    nearbyArray = [[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"nearbylist"] objectForKey:@"nearby"];
    
    nearbyArray = [[NSMutableArray alloc] initWithCapacity:0];
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"nearbylist"] objectForKey:@"nearby"] isKindOfClass:[NSDictionary class]]) 
    {
        [nearbyArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"nearbylist"] objectForKey:@"nearby"]];
    }
    else
    {
        [nearbyArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"nearbylist"] objectForKey:@"nearby"]];
    }   
    
    
       
    nearByTypesArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i<[nearbyArray count]; i++)
    {
        BOOL alreadyExisists = NO;
        
        NSMutableDictionary *tmpDict = [nearbyArray objectAtIndex:i];
        if ([tmpDict objectForKey:@"type"] != nil)
        {

            NSString *typeStr = [tmpDict objectForKey:@"type"];
            for (int j =0 ; j<[nearByTypesArray count]; j++)
            {
                NSString *tmpStr = [nearByTypesArray objectAtIndex:j];
                if([tmpStr caseInsensitiveCompare:typeStr]== NSOrderedSame )
                {
                    alreadyExisists = YES;
                }

            }
            if (alreadyExisists == NO)
            {
                [nearByTypesArray addObject:typeStr];
            }
        }
       
    }
    
  
        nearByTypesTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, 310, 290)];
        nearByTypesTableView.delegate = self;
        nearByTypesTableView.dataSource = self;
        nearByTypesTableView.showsVerticalScrollIndicator = NO;
        nearByTypesTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        nearByTypesTableView.separatorColor = [UIColor clearColor];
        nearByTypesTableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:nearByTypesTableView];

    [nearByTypesArray sortUsingSelector:@selector(caseInsensitiveCompare:)];

    
}

-(NSMutableArray *)mainNearByTableCreation
{
    if (nearBySourceArray != nil)
    {
        [nearBySourceArray removeAllObjects];
    }
    else
    {
        nearBySourceArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    
    for (int i = 0; i<[nearbyArray count]; i++)
    {
      
        NSMutableDictionary *tmpDict = [nearbyArray objectAtIndex:i];
        if ([tmpDict objectForKey:@"type"] != nil)
        {
            NSString *typeStr = [tmpDict objectForKey:@"type"];
            if ([typeStr isEqualToString:selectedType])
            {
                [nearBySourceArray addObject:tmpDict];
            }
            
        }
        
    }

    return nearBySourceArray;
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
