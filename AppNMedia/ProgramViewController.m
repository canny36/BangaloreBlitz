//
//  ProgramViewController.m
//  AppNMedia
//
//  Created by Srinivas on 11/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "ProgramViewController.h"
#import "Program.h"
#import "AppNMediaAppDelegate.h"
#import "WebViewController.h"
#import "CustomTableViewCell.h"
#import "Util.h"

#define kNewsTableCellHeight 80
#define radians( degrees ) ( degrees * M_PI / 180 ) 

@interface ProgramViewController ()

@end

@implementation ProgramViewController

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
    
    self.title = @"Programs";
    
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setSeparatorColor:[UIColor clearColor]];
    [_tableView setSectionFooterHeight:0];
    
    _tableView.showsVerticalScrollIndicator = NO;
    
    programs = [Program collection];
    
    NSLog(@"PROGRAMMS %@ ",programs);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [programs count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kNewsTableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
       NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
     CustomTableViewCell *cell = (CustomTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
            [cell setDefaultImage:nil];
    }
    

    Program *program = [programs objectAtIndex:indexPath.row];
    
    cell.textLabel.text = program.title;
    NSString *logo =  program.logo;
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
    Program *program = [programs objectAtIndex:indexPath.row];
    
    if (program != nil)
    {
        
        NSString *urlString = program.weblink;
        
       WebViewController *webViewController = [[WebViewController alloc] init];
        
        webViewController.urlString = urlString;
        
        [self presentModalViewController:webViewController animated:YES];
        
    }
    
    
}



-(void)updateCell:(ImageLoader*)loader{
    
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:loader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    
}



-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];

}


@end
