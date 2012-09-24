//
//  ViewController.m
//  PhotoPager1
//
//  Created by Logic2 on 19/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "MyImageView.h"

@implementation ViewController

const CGFloat kScrollObjWidth	= 310.0;
const CGFloat kScrollObjHeight	= 480.0;
 CGFloat numImages = 5;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor =[UIColor clearColor];
    
    [lButton setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
     [rButton setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
    
//    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScrollObjWidth, kScrollObjWidth)];
    
//    [self.view addSubview:scrollView];
    
    [scrollView setBackgroundColor:[UIColor clearColor]];
    
    [scrollView setClipsToBounds:YES];
    [scrollView setCanCancelContentTouches:NO];
    [scrollView setPagingEnabled:YES];
    [scrollView setDelegate:self];
    [scrollView setBounces:NO];
    
    label.text = [NSString stringWithFormat:@" %d / %d",1,(int)numImages];
    label.textColor = [UIColor redColor];
    
    BOOL fromServer =YES;
    
    
    if(fromServer){
        urlArray = [[NSArray alloc]initWithObjects:@"http://www.applusmedia.com/uploads/logo_1338601448.jpg" , @"http://www.goodart.org/blog/MarieSpartaliStillman-ConventLily-1891-Small.jpg",@"http://www.nehru-centre.org/media/artgallery/artgallery1.JPG",@"http://www.goodart.org/blog/AugusteToulmouche-TheHesitantBethrothed-1866Small.jpg",@"http://www.goodart.org/blog/JessieWilcoxSmith-TheLandofCounterpane-Small.jpg",nil];
        
        numImages = urlArray.count;
        
        
        int tag = 1;
        for (NSString *urlString in urlArray) {
            
            CGRect rect = CGRectMake(0, 10, kScrollObjWidth, kScrollObjHeight);
           
                        
            MyImageView *imageView = [[MyImageView alloc]initWithFrame:rect :urlString];
            imageView.frame = rect;
            
            imageView.tag = tag++;
            [scrollView addSubview:imageView];
            
            
        }
        [self scrollItems];
    }else{
        numImages = 5;
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
           for (int i =1 ; i <=numImages; i++) {
            
               NSString *imageName = [NSString stringWithFormat:@"image%d.jpg",i];
                 
               UIImage *image = [UIImage imageNamed:imageName];
               UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                
               CGRect rect = imageView.frame;
               rect.size.width = kScrollObjWidth;
               rect.size.height = kScrollObjHeight;
                imageView.frame = rect;
                imageView.tag = i;
              
               [scrollView addSubview:imageView];
          }
                [self scrollItemsLocal];
    }
  
}


-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
 
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   }


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
   }


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
  CGPoint offset=[scrollView contentOffset];
    
    NSLog(@" offset x= %f  y = %f ",offset.x , offset.y);
    
   int pos = offset.x/kScrollObjWidth;
    int total = numImages;
    
     label.text = [NSString stringWithFormat:@" %d / %d",pos+1,total];
}

-(void)scrollItems{
    
    UIView *view = nil;
    CGFloat curX = 0;
    
    for ( view in scrollView.subviews) {
        if ([view isKindOfClass:[MyImageView class]]) {
            
            CGRect frame = view.frame;
            frame.origin = CGPointMake(curX, 0  );
                      
            view.frame = frame;
            MyImageView *imageView = (MyImageView*)view;
            imageView.imageView.frame = frame;
            
             curX += kScrollObjWidth;
            
        }
    }
    
  
    
    [scrollView setContentSize:CGSizeMake((numImages * kScrollObjWidth), [scrollView bounds].size.height)];
    
}

- (IBAction)onLeftClick{
    NSLog(@" Left ");
    rButton.enabled = YES;
    
    CGPoint point = [scrollView contentOffset];
    int pos = point.x/kScrollObjWidth;
    NSLog(@"position %d ",pos);
    pos += 1;
    if(pos > 1 ){
        point =  CGPointMake( point.x-kScrollObjWidth , point.y);
        [scrollView setContentOffset:point animated:YES];
        
         
        pos--;
        if (pos == 1 ) {
            lButton.enabled = NO;
            rButton.enabled = YES;
        }
    }
    label.text = [NSString stringWithFormat:@" %d / %d ",pos, urlArray.count ];
}

- (IBAction)onRightClick{
     NSLog(@" RIGHT ");
    lButton.enabled =YES;
    
    CGPoint point = [scrollView contentOffset];
     int pos = point.x/kScrollObjWidth;
    pos = pos+1;
    if(pos < urlArray.count ){
         point =  CGPointMake( point.x+kScrollObjWidth , point.y);
        [scrollView setContentOffset:point animated:YES];
        
       
        
        pos++;
        
        if (pos == numImages) {
            rButton.enabled = NO;
            lButton.enabled =YES;
        }
    }
      label.text = [NSString stringWithFormat:@" %d / %d ",pos,urlArray.count ];
}

-(void)scrollItemsLocal{
    
    UIView *view = nil;
    CGFloat curX = 0;
    
    for ( view in scrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            
            CGRect frame = view.frame;
            frame.origin = CGPointMake(curX, 0  );
            
            view.frame = frame;
           
            
            curX += kScrollObjWidth;
            
        }
    }
    
    
    
    [scrollView setContentSize:CGSizeMake((numImages * kScrollObjWidth), [scrollView bounds].size.height)];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
