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
#import "ProgramCell.h"

#define kNewsTableCellHeight 100

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
    ProgramCell *cell = (ProgramCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[ProgramCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        cell.titleLabel.textColor = [UIColor whiteColor];

        
        cell.backgroundColor = [UIColor darkGrayColor];
    }
    

    Program *program = [programs objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = program.title;
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
    Program *program = [programs objectAtIndex:indexPath.row
                        ];
    
    if (program != nil)
    {
        
        NSString *urlString = program.weblink;
        
       WebViewController *webViewController = [[WebViewController alloc] init];
        
        webViewController.urlString = urlString;
        
        [self presentModalViewController:webViewController animated:YES];
        
    }
    
    
}


-(void)loadImageAtIndexpath:(NSIndexPath*)indexpath urlString :(NSString*)url cell :(ProgramCell*)cell{
    
    CGSize point  = CGSizeMake(100, 80);
    
    //    [NSInvocationOperation ];
    
    UIImage *image =  [imageDownloader getImage:url];
    if (image != nil) {
        NSLog(@"HIT AT %@ ",url);
        //        SupportedByTableViewCell *cell = (SupportedByTableViewCell*)[supportedByTableView cellForRowAtIndexPath:indexpath];
      
        cell.pimageView.image = image;

    }else{
        
        NSLog(@"FAIL AT %@ ",url);
        ImageLoader *loader = [[ImageLoader alloc]initWithUrl:url withSize:point delegate:self];
        loader.indexPath = indexpath;
        if (imageDownloader == nil) {
            imageDownloader =  [ImageDownloader shareInstance];
        }
        
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
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:loader.indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}


-(void)onErrorLoadingImage:(ImageLoader*)imageLoader{
    NSLog(@"ERROR DOWNLOADING ");
    
    [currentDownloads removeObject:imageDownloader];
}




@end
