//
//  GalleryViewController.m
//  AppNMedia
//
//  Created by Srinivas on 25/09/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "GalleryViewController.h"
#import "VideosViewController.h"
#import "PhotosViewController.h"
#import "WebViewController.h"

@interface GalleryViewController ()

@end

@implementation GalleryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)onButtonClick :(id)sender{
    UIViewController *controller = nil;
    
    if (sender == photosButton) {
        controller = [[PhotosViewController alloc]init];
    }else if(sender == videosButton){
        controller = [[VideosViewController alloc]init];
    }else if(sender == pressButton){
        WebViewController *webViewController = [[WebViewController alloc] init];
          webViewController.urlString = @"http://www.bangaloreit.biz/IT_2012/index.php?media=1";
          [self presentModalViewController:webViewController animated:YES];
        return;
    }
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Gallery";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
