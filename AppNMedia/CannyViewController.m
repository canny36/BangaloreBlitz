//
//  CannyViewController.m
//  BangaloreItBiz
//
//  Created by Srinivas on 29/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "CannyViewController.h"
#import "CustomTableViewCell.h"
#import "UIImage+scale.h"

@interface CannyViewController ()

@end

@implementation CannyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{


}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
       UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];
    self.navigationItem.rightBarButtonItem = homeButton;
    
}
-(void)openUrl:(NSString*)urlString{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:[NSURL URLWithString:urlString]]) {
        [app openURL:[NSURL URLWithString:urlString]];
    }
}


-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
  
}

-(void)onFavoriteSelection:(UIButton*)sender{
    NSLog(@"  onfavorite selection ");
}

-(void)loadImageAtIndexpath:(NSIndexPath*)indexpath urlString :(NSString*)url cell :(CustomTableViewCell*)cell{
    
    if (imageDownloader == nil) {
        imageDownloader =  [ImageDownloader shareInstance];
    }
    
    CGSize point  = CGSizeMake(100, 80);
    
    //    [NSInvocationOperation ];
    
    UIImage *image =  [imageDownloader getImage:url];
    
    
    if (image != nil) {
        NSLog(@"HIT AT %@ ",url);
//        if (image.size.width > 120) {
////            CGSize size = CGSizeMake(120, 100);
//            image = [image scaleImage:image scaleFactor:(120/image.size.width)];        }
        cell.imageView.image = image;
        
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


-(void)onErrorLoadingImage:(ImageLoader*)imageLoader{
    
    NSLog(@"ERROR DOWNLOADING ");
    [imageDownloader removeOperation:imageLoader];
    [currentDownloads removeObject:imageDownloader];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    for ( ImageLoader *loader in currentDownloads ){
        [loader cancel];
    }
    
    [currentDownloads removeAllObjects];
}

@end
