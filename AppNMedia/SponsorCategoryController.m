//
//  SponsorCategoryController.m
//  AppNMedia
//
//  Created by Srinivas on 13/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "SponsorCategoryController.h"
#import "SPonsor.h"
#import "SponsersViewController.h"
#import "Util.h"

@interface SponsorCategoryController ()

@end

@implementation SponsorCategoryController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.title = @"Sponsors";
 
//    UINavigationBar *navBar = self.navigationController.navigationBar;;
//    navBar.tintColor = [UIColor colorWithRed:0.3 green:0.1 blue:0.8 alpha:1];
    
    
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setSeparatorColor:[UIColor clearColor]];
    sponsorDict  = [SPonsor collectSponsors];
    array =  [sponsorDict allKeys];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
  
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (array != nil) {
        return [array count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier = @"reuseidentifier";
    
   CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
       
    }
  
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    
   NSMutableArray *sponsorArray = [sponsorDict objectForKey:[array objectAtIndex:indexPath.row]];
    
    NSLog(@"SPONSORS ARRAY  %@",sponsorArray);
    
   SponsersViewController *controller =  [[SponsersViewController alloc]initWithNibName:@"SponsersViewController" bundle:nil];
    controller.categoryName = [array objectAtIndex:indexPath.row];
    controller.sponsorsArray = sponsorArray;
    [self.navigationController pushViewController:controller animated:YES];
    
}







@end
