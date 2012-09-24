//
//  MyImageView.m
//  PhotoPager1
//
//  Created by Logic2 on 19/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyImageView.h"

@interface MyImageView() {
@private
    
}
-(void)loadImageWithUrlString:(NSString*)urlString;
@end

@implementation MyImageView
@synthesize imageView = _imageView;

- (id)initWithFrame:(CGRect)frame:(NSString*)urlString
{
    self = [super initWithFrame:frame];
    if (self) {
       
        imageView = [[UIImageView alloc] initWithFrame:frame];
        [imageView setBackgroundColor:[UIColor grayColor]];
        [imageView setClipsToBounds:YES];
        UIImage *image = [UIImage imageNamed:@"image1.jpg"];
        [imageView setImage:image];
        
        spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        
        CGRect frame = spinner.frame;
        
        frame.origin.x = imageView.frame.size.width /2 - spinner.frame.size.width/2;
        frame.origin.y = imageView.frame.size.height /2 - spinner.frame.size.height/2;
        
        spinner.frame = frame;
        
        [spinner startAnimating];
        [spinner setHidesWhenStopped:YES];
        
        [self addSubview:imageView];
        
        [self addSubview:spinner];
        [self loadImageWithUrlString:urlString];
        
    }
    return self;
}


-(void)loadImageWithUrlString:(NSString*)urlString{
    
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:160];
    
   
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection == nil) {
        NSLog(@"Connection error");
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@" Connection data recived %d ",self.tag);

    if (imagedata == nil) {
        imagedata = [[NSMutableData alloc]init];
    }
    
    [imagedata appendData:data];
    
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse *hhtpresponse= (NSHTTPURLResponse*)response;
     NSLog(@" Gotta response %d - %d ", self.tag,[hhtpresponse statusCode ]);
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
     NSLog(@" Connection did finish loading %d ",self.tag);
   
     [spinner removeFromSuperview];
    
    if(imagedata != nil){
        UIImage *image = [UIImage imageWithData:imagedata];  
        [imageView setImage:image];
    }
   
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
     NSLog(@" Connection error ");
    [spinner removeFromSuperview];
 

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
//    [imageView release];
//    [spinner release];
//    [super dealloc];
}

@end
