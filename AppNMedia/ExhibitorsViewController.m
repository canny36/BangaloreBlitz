//
//  ExhibitorsViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 24/05/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "ExhibitorsViewController.h"
#import "AppNMediaAppDelegate.h"
#import "ExhibitorsTableCell.h"
#import "WebViewController.h"
#import "Util.h"

#define kExhibitorsTableCellHeight 100

@implementation ExhibitorsViewController
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


-(void)makeaMap :(int )selectedAddress
{
    NSMutableDictionary *tmpDict = [exhibitorsArray objectAtIndex:selectedAddress];
    NSString *tmpStr = @"";
    
    if ([tmpDict objectForKey:@"location_address"] != nil)
    {
        tmpStr=  [tmpStr stringByAppendingString:[tmpDict objectForKey:@"location_address"]];
        
    }
   
    
    openMap = [[mapViews alloc] init];
    openMap.urlString = tmpStr;
    
    [self presentModalViewController:openMap animated:YES];
}



-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)dealloc
{
    exhibitorsArray = nil;


}



#pragma mark Table View datasource and delegate methods 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [exhibitorsArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int height = 10;
    NSDictionary *tmpDict =   [exhibitorsArray objectAtIndex:indexPath.row];
    NSString *name = [tmpDict objectForKey:@"name"];
    CGSize size =  [name sizeWithFont:[UIFont fontWithName:[Util subTitleFontName] size:LARGE_FONT_SIZE] constrainedToSize : CGSizeMake(150, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    height += size.height;
    NSString *address = [self adress:tmpDict];

    size =  [address sizeWithFont:[UIFont fontWithName:[Util detailTextFontName] size:MEDIUM_FONT_SIZE] constrainedToSize:CGSizeMake(150, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
   
    height += size.height;

    if (height < kExhibitorsTableCellHeight) {
        return height + 20;
    }
    
    return kExhibitorsTableCellHeight;
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
   
    NSMutableDictionary *tmpDict = [exhibitorsArray objectAtIndex:indexPath.row];
    
   NSString *text = [tmpDict objectForKey:@"name"];

    cell.textLabel.text = [tmpDict objectForKey:@"name"];
       CGSize size =  [text sizeWithFont:[cell.textLabel font] constrainedToSize:CGSizeMake(cell.textLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    cell.textLabel.numberOfLines =  size.height/21;
    
    NSString *address = [self adress:tmpDict];
      
    cell.detailTextLabel.text = address;
    size =  [text sizeWithFont:[cell.detailTextLabel font] constrainedToSize:CGSizeMake(cell.detailTextLabel.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    cell.detailTextLabel.numberOfLines = size.height/16+1;
    
    NSString *logo = [tmpDict objectForKey:@"logo"];
    
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

-(NSString*)adress:(NSDictionary*)dict{
    NSMutableString *address = [[NSMutableString alloc]init];
    
    NSLog(@" ADRESS %@ ",dict);
//    <address1/>
//    <address2/>
//    <city/>
//    <state/>
//    <zipcode/>
//    <phone/>
    
    NSString *a = [dict objectForKey:@"address1"];
    
    if(a != nil && a.length > 0){
        [address appendString:a];
        [address appendString:@" , "];
    }
    a = [dict objectForKey:@"address2"];
    if(a != nil && a.length > 0){
        [address appendString:a];
        [address appendString:@" , "];
    }
    a = [dict objectForKey:@"city"];
    if(a != nil && a.length > 0){
        [address appendString:a];
        [address appendString:@" , "];
    }
    a = [dict objectForKey:@"state"];
    if(a != nil && a.length > 0){
        [address appendString:a];
        [address appendString:@" , "];
    }
    a = [dict objectForKey:@"zipcode"];
    if(a != nil && a.length > 0){
        [address appendString:a];
    
    }
    
    a = [dict objectForKey:@"phone"];
    if(a != nil && a.length > 0){
        [address appendString:@"\n"];
        [address appendString:a];
    }
    NSLog(@" ADRESS %@ ",address);
    return address;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSMutableDictionary *tmpDict = [exhibitorsArray objectAtIndex:indexPath.row];
    if ([tmpDict objectForKey:@"website"] != nil)
    {
        NSString *urlString = [tmpDict objectForKey:@"website"];
      UIApplication *app =  [UIApplication sharedApplication];
        if([app canOpenURL:[NSURL URLWithString:urlString]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
      }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];

    
    self.title = @"Exhibitors";
    
    exhibitorsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"exhibitorslist"] objectForKey:@"exhibitor"] isKindOfClass:[NSDictionary class]]) 
    {
        [exhibitorsArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"exhibitorslist"] objectForKey:@"exhibitor"]];
    }
    else
    {
        [exhibitorsArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"exhibitorslist"] objectForKey:@"exhibitor"]];
    }    
    
    exhibitorsTableView =[[UITableView alloc] initWithFrame:CGRectMake(5, 5, 310,290)];
    exhibitorsTableView.dataSource= self;
    exhibitorsTableView.delegate = self;
    exhibitorsTableView.backgroundColor = [UIColor clearColor];
    exhibitorsTableView.showsVerticalScrollIndicator= NO;
    exhibitorsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    exhibitorsTableView.separatorColor = [UIColor clearColor];
    
    [self.view addSubview:exhibitorsTableView];
    
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
    
    [exhibitorsTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:loader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
 }


@end
