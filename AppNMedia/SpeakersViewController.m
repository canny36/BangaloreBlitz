//
//  SpeakersViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "SpeakersViewController.h"
#import "SpeakersViewDetailsController.h"
#import "AppNMediaAppDelegate.h"
#import "SpeakersTableViewCell.h"
#import "AgendaDetailsViewController.h"
#import "ImageLoader.h"
#import "Util.h"

#define kSpeakersTableCellHeight 80.0
@implementation SpeakersViewController
@synthesize offlineSpeakersImagesArr;

- (void)dealloc
{
   
    
}

- (NSString *)dataFilePathForMyfavoritesSpeakersInfo
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"myfavoriteSpeakers.plist"];
}

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

-(void)addOrDeleteFromMyFavorites:(int )selectedIndex checkMark:(BOOL)checkMark fromSearchTable:(BOOL)fromSearchTable
{
    NSString *filePath = [self dataFilePathForMyfavoritesSpeakersInfo];
    
    if (([[NSFileManager defaultManager] fileExistsAtPath:filePath])) 
    {
        myFavIndexesArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    }
    else
    {
        myFavIndexesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    
    if (checkMark ==YES)
    {
        if (fromSearchTable == NO) 
        {
            NSMutableDictionary *tmpDict = [speakersArray objectAtIndex:selectedIndex];
            if ([tmpDict objectForKey:@"speakerid"]!= nil)
            {
                [myFavIndexesArray addObject:[tmpDict objectForKey:@"speakerid"]];
                [myFavoriteSpeakers addObject:[tmpDict objectForKey:@"speakerid"]];
            }

        }
        else
        {
            NSMutableDictionary *tmpDict = [searchArr objectAtIndex:selectedIndex];
            if ([tmpDict objectForKey:@"speakerid"]!= nil)
            {
                [myFavIndexesArray addObject:[tmpDict objectForKey:@"speakerid"]];
                [myFavoriteSpeakers addObject:[tmpDict objectForKey:@"speakerid"]];
            }
 
        }
        
        
        
        
        
    }
    else
    { 
        if ([myFavIndexesArray count]>0)
        {
            if (fromSearchTable == NO)
            {
                NSMutableDictionary *tmpDict = [speakersArray objectAtIndex:selectedIndex];
                
                NSString *speakerIdStr = @"";
                if ([tmpDict objectForKey:@"speakerid"]!= nil)
                {
                    speakerIdStr = [tmpDict objectForKey:@"speakerid"];
                    
                }
                
                for (int i=0; i<[myFavIndexesArray count]; i++)
                {
                    NSString *tmpStr = [myFavIndexesArray objectAtIndex:i];
                    if ([tmpStr isEqualToString:speakerIdStr])
                    {
                        [myFavIndexesArray removeObjectAtIndex:i];
                        [myFavoriteSpeakers removeObjectAtIndex:i];
                    }
                    
                }

            }
            else
            {
                NSMutableDictionary *tmpDict = [searchArr objectAtIndex:selectedIndex];
                
                NSString *speakerIdStr = @"";
                if ([tmpDict objectForKey:@"speakerid"]!= nil)
                {
                    speakerIdStr = [tmpDict objectForKey:@"speakerid"];
                    
                }
                
                for (int i=0; i<[myFavIndexesArray count]; i++)
                {
                    NSString *tmpStr = [myFavIndexesArray objectAtIndex:i];
                    if ([tmpStr isEqualToString:speakerIdStr])
                    {
                        [myFavIndexesArray removeObjectAtIndex:i];
                        [myFavoriteSpeakers removeObjectAtIndex:i];
                    }
                    
                }
            }
                   
        
        }
    }
    
    
    [myFavIndexesArray writeToFile:filePath atomically:YES];
    
    [speakersTableView reloadData];
    [searchTableView reloadData];
   
}

-(void)myFavoritesAddingFromSearchResultsTableDetailsController:(NSMutableDictionary *)selectedDictionary checkMark:(BOOL)checkMark
{
    NSString *filePath = [self dataFilePathForMyfavoritesSpeakersInfo];
    
    if (([[NSFileManager defaultManager] fileExistsAtPath:filePath])) 
    {
        myFavIndexesArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    }
    else
    {
        myFavIndexesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    
    
    if (checkMark ==YES)
    {
        
        if ([selectedDictionary objectForKey:@"speakerid"]!= nil)
        {
            [myFavIndexesArray addObject:[selectedDictionary objectForKey:@"speakerid"]];
            [myFavoriteSpeakers addObject:[selectedDictionary objectForKey:@"speakerid"]];
        }
        
    }
    else
    { 
        if ([myFavIndexesArray count]>0)
        {
            
            NSString *speakerIdStr = @"";
            if ([selectedDictionary objectForKey:@"speakerid"]!= nil)
            {
                speakerIdStr = [selectedDictionary objectForKey:@"speakerid"];
                
            }
            
            for (int i=0; i<[myFavIndexesArray count]; i++)
            {
                NSString *tmpStr = [myFavIndexesArray objectAtIndex:i];
                if ([tmpStr isEqualToString:speakerIdStr])
                {
                    [myFavIndexesArray removeObjectAtIndex:i];
                    [myFavoriteSpeakers removeObjectAtIndex:i];
                }
                
            }
        }
    }
    
    
    [myFavIndexesArray writeToFile:filePath atomically:YES];
    
    [searchTableView reloadData];
    [speakersTableView reloadData];

    
}

-(void)assignStyles
{
    
    titleFontName =@"Helvitica-Bold";
    titleFontSize = @"14";
    subTitleFontName = @"Helvitica";
    subTitleFontSize = @"12";
    
}

#pragma mark Table View datasource and delegate methods 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == speakersTableView) 
    {
        return [speakersArray count];

    }
    else
    {
        return [searchArr count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kSpeakersTableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        SpeakersTableViewCell *cell;
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    cell = (SpeakersTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[SpeakersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        [cell.speakerNameLabel setFont:[UIFont fontWithName:[Util subTitleFontName] size:15]];
        cell.speakerNameLabel.textColor = [Util subTitleColor];
        
        [cell.speakersDetailsLabel setFont:[UIFont fontWithName:[Util detailTextFontName] size:14]];
        
        cell.speakersDetailsLabel.textColor = [Util detailTextColor];
    };
    
    [cell loadDefaultImage];
 
    if (tableView == speakersTableView) 
    {
        cell.fromSearchTable = NO;
        NSMutableDictionary *tmpDict = [speakersArray objectAtIndex:indexPath.row];
        
        NSString *nameStr = [tmpDict objectForKey:@"firstname"];
        nameStr = [nameStr stringByAppendingString:@" "];
        
        if ([tmpDict objectForKey:@"lastname"] != nil)
        {
            nameStr = [nameStr stringByAppendingString:[tmpDict objectForKey:@"lastname"]];
        }
        
        
        //NSLog(@"speaker id = %@",[tmpDict objectForKey:@"speakerid"]);
        
        cell.speakerNameLabel.text =nameStr;
        
        cell.speakersDetailsLabel.text = [tmpDict objectForKey:@"description"];
        
        NSString *logo  = [tmpDict objectForKey:@"speakerphoto"];
        NSLog(@" LOGO %@   ",logo);
        if (logo != nil && ![logo isEqualToString:@""]) {
            
            NSMutableString *mainlogo = [NSMutableString stringWithString:BASE_URL];
            [mainlogo appendString:logo];
            NSLog(@" URL AT %d = %@  ", indexPath.row, mainlogo);
            [self loadImageAtIndexpath:indexPath urlString:mainlogo cell : cell];
        }else{
            NSLog(@" NO LOGO   ");
            
        }
        
        
        
//        if (appDelegate.runAppInOffline == NO)
//        {
//            BOOL network = [appDelegate networkCheckingMethod];
//            
//            if (network == YES)
//            {
//                
//                NSString *baseUrl = BASE_URL;
//                if ([tmpDict objectForKey:@"speakerphoto"] != nil) 
//                {
//                    NSString *imageUrl = [tmpDict objectForKey:@"speakerphoto"];
//                    baseUrl = [baseUrl stringByAppendingString:imageUrl];
//                    
//                }
//                
//                [cell performSelectorInBackground:@selector(assignImage:) withObject:baseUrl];
//            }
//            else
//            {
//                if ([offlineSpeakersImagesArr count] == [speakersArray count])
//                {
//                    NSData *tmpData = [offlineSpeakersImagesArr objectAtIndex:indexPath.row];
//                    cell.speakerImageView.image = [UIImage imageWithData:tmpData];
//                }
//                else
//                {
//                    cell.speakerImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
//                }
//                [cell.activityIndicatorview stopAnimating];
//                
//            }
//
//            
//        }
//        else
//        {
//            if ([offlineSpeakersImagesArr count] == [speakersArray count])
//            {
//                NSData *tmpData = [offlineSpeakersImagesArr objectAtIndex:indexPath.row];
//                cell.speakerImageView.image = [UIImage imageWithData:tmpData];
//            }
//            else
//            {
//                cell.speakerImageView.image = [UIImage imageNamed:@"NoImage.png"]; 
//            }
//            [cell.activityIndicatorview stopAnimating]; 
//        }
//        
       
        
        cell.speakerViewController= self;
        cell.selectButton.tag = indexPath.row;
        if ([myFavoriteSpeakers count]>0)
        {
            for (int i=0; i<[myFavoriteSpeakers count]; i++)
            {
                NSString *tmpIdStr = [myFavoriteSpeakers objectAtIndex:i];
                NSString *speakerIdStr = @"";
                if ([tmpDict objectForKey:@"speakerid"] != nil)
                {
                    speakerIdStr = [tmpDict objectForKey:@"speakerid"];
                }
                
                if ([speakerIdStr isEqualToString:tmpIdStr])
                {
                    [cell.selectButton setImage:[UIImage imageNamed:@"gold_star.png"] forState:UIControlStateNormal];
                    cell.buttonSelected = YES;
                    i = [myFavoriteSpeakers count];
                }
                else
                {
                    [cell.selectButton setImage:[UIImage imageNamed:@"gray_star.png"] forState:UIControlStateNormal];
                    cell.buttonSelected = NO; 
                }

            }
            
                
                        
    }

    }
    else
    {
        cell.speakerViewController= self;
        cell.selectButton.tag = indexPath.row;
        cell.fromSearchTable = YES;
        if ([searchArr count]>0)
        {
            NSMutableDictionary *tmpDict = [searchArr objectAtIndex:indexPath.row]; 
            NSString *nameStr = [tmpDict objectForKey:@"firstname"];
            nameStr = [nameStr stringByAppendingString:@" "];
            
            if ([tmpDict objectForKey:@"lastname"] != nil)
            {
                nameStr = [nameStr stringByAppendingString:[tmpDict objectForKey:@"lastname"]];
            }
            cell.speakerNameLabel.text = nameStr;
            cell.speakerImageView.frame = CGRectZero;
            
            if ([myFavoriteSpeakers count]>0)
            {
                for (int i=0; i<[myFavoriteSpeakers count]; i++)
                {
                    NSString *tmpIdStr = [myFavoriteSpeakers objectAtIndex:i];
                    NSString *speakerIdStr = @"";
                    if ([tmpDict objectForKey:@"speakerid"] != nil)
                    {
                        speakerIdStr = [tmpDict objectForKey:@"speakerid"];
                    }
                    
                    if ([speakerIdStr isEqualToString:tmpIdStr])
                    {
                        [cell.selectButton setImage:[UIImage imageNamed:@"gold_star.png"] forState:UIControlStateNormal];
                        cell.buttonSelected = YES;
                        i = [myFavoriteSpeakers count];
                    }
                    else
                    {
                        [cell.selectButton setImage:[UIImage imageNamed:@"gray_star.png"] forState:UIControlStateNormal];
                        cell.buttonSelected = NO; 
                    }
                    
                }
            }

        }
        
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
    speakersDetailsViewController = [[SpeakersViewDetailsController alloc] init];

    if (tableView == speakersTableView)
    {
        
        speakersDetailsViewController.selectedDict = [speakersArray objectAtIndex:indexPath.row];
        speakersDetailsViewController.selectedRow = indexPath.row;
        speakersDetailsViewController.svc = self;
        speakersDetailsViewController.fromSearchTable = NO;
        
        NSMutableDictionary *tmpDict = [speakersArray objectAtIndex:indexPath.row];
        
        if ([myFavoriteSpeakers count]>0)
        {
            for (int i=0; i<[myFavoriteSpeakers count]; i++)
            {
                NSString *tmpIdStr = [myFavoriteSpeakers objectAtIndex:i];
                NSString *speakerIdStr = @"";
                if ([tmpDict objectForKey:@"speakerid"] != nil)
                {
                    speakerIdStr = [tmpDict objectForKey:@"speakerid"];
                }
                
                if ([speakerIdStr isEqualToString:tmpIdStr])
                {
                    
                    speakersDetailsViewController.addedToMyfavorites= YES;
                    i = [myFavoriteSpeakers count];
                }
                else
                {
                    speakersDetailsViewController.addedToMyfavorites= NO;
   
                }
                
            }
        
      

    }
        
        [self.navigationController pushViewController:speakersDetailsViewController animated:YES];
  
    }
    else
    {
        speakersDetailsViewController.selectedDict = [searchArr objectAtIndex:indexPath.row];
        speakersDetailsViewController.selectedRow = [[selectedIndexesArray objectAtIndex:indexPath.row] intValue];
        speakersDetailsViewController.fromSearchTable = YES;
        speakersDetailsViewController.svc = self;
        
        
        
        NSMutableDictionary *tmpDict = [searchArr objectAtIndex:indexPath.row];
        
        if ([myFavoriteSpeakers count]>0)
        {
            for (int i=0; i<[myFavoriteSpeakers count]; i++)
            {
                NSString *tmpIdStr = [myFavoriteSpeakers objectAtIndex:i];
                NSString *speakerIdStr = @"";
                if ([tmpDict objectForKey:@"speakerid"] != nil)
                {
                    speakerIdStr = [tmpDict objectForKey:@"speakerid"];
                }
                
                if ([speakerIdStr isEqualToString:tmpIdStr])
                {
                    
                    speakersDetailsViewController.addedToMyfavorites= YES;
                    i = [myFavoriteSpeakers count];
                }
                else
                {
                    speakersDetailsViewController.addedToMyfavorites= NO;
                    
                }
                
            }

        
        }
        
        
        [self.navigationController pushViewController:speakersDetailsViewController animated:YES];
        
    }

}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)storeMyfavorites
{
    
}

#pragma mark - View lifecycle
-(void)viewWillDisappear:(BOOL)animated
{
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Speakers";
    
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;
    [self assignStyles];
         
    speakersArray = [[NSMutableArray alloc] initWithCapacity:0];
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"speakerslist"] objectForKey:@"speaker"] isKindOfClass:[NSDictionary class]]) 
    {
        [speakersArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"speakerslist"] objectForKey:@"speaker"]];
    }
    else
    {
        [speakersArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"speakerslist"] objectForKey:@"speaker"]];
    }
    
    NSLog(@" SPEAKERS ARRAY %d ", [speakersArray count]);
    
    myFavIndexesArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSString *filePath = [self dataFilePathForMyfavoritesSpeakersInfo];
    
    if (([[NSFileManager defaultManager] fileExistsAtPath:filePath])) 
    {
        myFavoriteSpeakers = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    }
    else
    {
        myFavoriteSpeakers = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    
    
    offlineSpeakersImagesArr = [[NSMutableArray alloc] initWithCapacity:0];

    NSString *filePath1  = [self dataFilePathForOfflineImages];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath1])
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath1];
        
        if ([tmpDict objectForKey:@"offLinespeakerImagesArr"]!= nil)
        {
            [offlineSpeakersImagesArr addObjectsFromArray:[tmpDict objectForKey:@"offLinespeakerImagesArr"]];
        }
        
    }      
    
    

    speakersTableView = [[UITableView alloc] initWithFrame:CGRectMake(5,60, 310, 250)];
    speakersTableView.dataSource = self;
    speakersTableView.delegate = self;
    speakersTableView.backgroundColor = [UIColor clearColor];
    speakersTableView.showsVerticalScrollIndicator = NO;
    [speakersTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    speakersTableView.separatorColor = [UIColor clearColor] ;
    
    [self.view addSubview:speakersTableView];
    
  
    
    
    for (UIView *view in participantsSearchBar.subviews)
    {
        if ([view isKindOfClass: [UITextField class]]) 
        {
            UITextField *tf = (UITextField *)view;
            tf.delegate = self;
            break;
        }
    }
    
    
    
    searchTableView =[[UITableView alloc] initWithFrame:CGRectMake(10, 500, 300, 200)];
    searchTableView.dataSource= self;
    searchTableView.delegate = self;
    searchTableView.backgroundColor = [UIColor clearColor];
    searchTableView.showsVerticalScrollIndicator = NO;
    [searchTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:searchTableView];
    [participantsSearchBar setShowsCancelButton:YES animated:YES];
    
    selectedIndexesArray = [[NSMutableArray alloc] initWithCapacity:0];

    transparentImageView.frame = CGRectMake(30, 70, 260, 250);

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


-(NSArray *)extractMethod:(NSInteger)value
{
    NSMutableDictionary *mainDic = [agendaArray objectAtIndex:value];
    id data =   [mainDic objectForKey:@"agendalocation"];
   
    array = [[NSMutableArray alloc]init];
    if([data isKindOfClass:[NSArray class]])
        [array addObjectsFromArray:data];
    
    if([data isKindOfClass:[NSDictionary class]])
        [array addObject:data];
    return array;
}

#pragma mark - searchBar
- (void)searchBarCancelButtonClicked:(UISearchBar *) aSearchBar 
{
    speakersTableView.hidden = NO;
    [participantsSearchBar resignFirstResponder];
    participantsSearchBar.text =@"";
      
    CGRect viewFrame1 = CGRectMake(10, 500, 300, 200);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration: 0.7];
    [searchTableView setFrame:viewFrame1];
    [UIView commitAnimations]; 
    
}
- (BOOL)textFieldShouldClear:(UITextField *)textField 
{
    speakersTableView.hidden = NO;
    CGRect viewFrame1 = CGRectMake(10, 500, 300, 200);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration: 0.7];
    [searchTableView setFrame:viewFrame1];
    [UIView commitAnimations]; 
    return YES;
}

////////////// searchBar
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [searchBar resignFirstResponder];
    searchString = searchBar.text;
    [self mainSearchMethod];
}
-(void)mainSearchMethod
{
    if (searchArr != nil)
    {
        [searchArr removeAllObjects];
    }
    else
    {
        searchArr = [[NSMutableArray alloc] initWithCapacity:0]; 
 
    }
    [selectedIndexesArray removeAllObjects];
    
    
    if ([searchString length]>3)
    {
        for (int i=0; i<[speakersArray count]; i++)
        {
            
            NSMutableDictionary *tmpDict = [speakersArray objectAtIndex:i];
            if ([tmpDict objectForKey:@"city"] != nil) 
            {
                if ([[tmpDict objectForKey:@"city"] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound)   
                {
                    
                    [searchArr addObject:tmpDict];
                    [selectedIndexesArray addObject:[NSString stringWithFormat:@"%d",i]];
                    continue;
                    
                }
            }
            
            
            if ([tmpDict objectForKey:@"firstname"] != nil) 
            {
                if ([[tmpDict objectForKey:@"firstname"] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound)   
                {
                    
                    [searchArr addObject:tmpDict];
                    [selectedIndexesArray addObject:[NSString stringWithFormat:@"%d",i]];
                    continue;
                    
                }
            }
            
            
            if ([tmpDict objectForKey:@"lastname"] != nil) 
            {
                if ([[tmpDict objectForKey:@"lastname"] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound)   
                {
                    
                    [searchArr addObject:tmpDict];
                    [selectedIndexesArray addObject:[NSString stringWithFormat:@"%d",i]];
                    continue;
                    
                }
            }
            
            
            
            if ([tmpDict objectForKey:@"description"] != nil) 
            {
                if ([[tmpDict objectForKey:@"description"] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound)   
                {
                    
                    [searchArr addObject:tmpDict];
                    [selectedIndexesArray addObject:[NSString stringWithFormat:@"%d",i]];
                    continue;
                    
                }
            }
            
            
        }
    }
    else
    {
        
        for (int i=0; i<[speakersArray count]; i++)
        {
            
            NSMutableDictionary *tmpDict = [speakersArray objectAtIndex:i];
            if ([tmpDict objectForKey:@"firstname"] != nil) 
            {
                if ([[tmpDict objectForKey:@"firstname"] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound)   
                {
                    
                    [searchArr addObject:tmpDict];
                    [selectedIndexesArray addObject:[NSString stringWithFormat:@"%d",i]];
                    continue;
                    
                }
            }
            
            
            if ([tmpDict objectForKey:@"lastname"] != nil) 
            {
                if ([[tmpDict objectForKey:@"lastname"] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound)   
                {
                    
                    [searchArr addObject:tmpDict];
                    [selectedIndexesArray addObject:[NSString stringWithFormat:@"%d",i]];
                    continue;
                    
                }
            }

            
            
        }
        
    }
    
    
    
    
    

    [self createSearchTable];
 
}
-(void)createSearchTable
{
    if ([searchArr count]>0)
    {
        speakersTableView.hidden = YES;
        [searchTableView reloadData];
        int height  = kSpeakersTableCellHeight * [searchArr count];
        if (height > 220)
        {
            height = 220;
        }
        CGRect viewFrame1 = CGRectMake(10, 60, 300, height);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration: 0.7];
        [searchTableView setFrame:viewFrame1];
        [UIView commitAnimations]; 
    }
    else
    {
        [searchTableView reloadData];

        CGRect viewFrame1 = CGRectMake(10, 500, 300, 200);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration: 0.7];
        [searchTableView setFrame:viewFrame1];
        [UIView commitAnimations]; 
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No results found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        speakersTableView.hidden = NO;
    }
    
    
}



-(void)loadImageAtIndexpath:(NSIndexPath*)indexpath urlString :(NSString*)url cell :(SpeakersTableViewCell*)cell{
    
    CGSize point  = CGSizeMake(100, 80);
    
    if (imageDownloader == nil) {
        imageDownloader =  [ImageDownloader shareInstance];
    }
    //    [NSInvocationOperation ];
    
    UIImage *image =  [imageDownloader getImage:url];
    if (image != nil) {
        NSLog(@"HIT AT %@ ",url);
        //        SupportedByTableViewCell *cell = (SupportedByTableViewCell*)[supportedByTableView cellForRowAtIndexPath:indexpath];
        
        cell.speakerImageView.image = image;
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
    
    [self performSelectorOnMainThread:@selector(updateCell:) withObject:imageLoader waitUntilDone:YES];
    
}

-(void)updateCell:(ImageLoader*)loader{
    [speakersTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:loader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)onErrorLoadingImage:(ImageLoader*)imageLoader{
   
    NSLog(@"ERROR DOWNLOADING ");
    [imageDownloader removeOperation:imageLoader];
    [currentDownloads removeObject:imageDownloader];
}


-(void)viewDidDisappear:(BOOL)animated{

    for (ImageLoader *loader in currentDownloads) {
        [loader cancel];
    }
    
    [currentDownloads removeAllObjects];
}

@end
