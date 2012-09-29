//
//  SpeakersViewDetailsController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 25/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "SpeakersViewDetailsController.h"
#import "AppNMediaAppDelegate.h"
#import "SpeakersViewController.h"
#import "WebViewController.h"
#import "UIImage+scale.h"
#import "Util.h"
#import "WebViewController.h"
#import "SpeakerInfo.h"

//@interface SpeakerInfo : NSObject{
//    
//    NSString *_description;
//    NSString *_firstName;
//    NSString *_lastName;
//    NSString *_type;
//    NSString *_weblink;
//}
//
//@property(nonatomic,retain) NSString *description;
//@property(nonatomic,retain) NSString *firstName;
//@property(nonatomic,retain) NSString *lastName;
//@property(nonatomic,retain) NSString *type;
//@property(nonatomic,retain) NSString *weblink;
//
//@end
//
//
//@implementation SpeakerInfo
//
//@synthesize firstName = _firstName;
//@synthesize lastName = _lastName;
//@synthesize type = _type;
//@synthesize description = _description;
//@synthesize weblink = _weblink;
//
//-(id)initWithDict:(NSDictionary*)dict{
//   
//    self = [super init];
//    if (self) {
//       
//        self.lastName = [dict objectForKey:@"lastname"];
//        self.firstName = [dict objectForKey:@"firstname"];
//        self.type = [dict objectForKey:@"title"];
//        self.description = [dict objectForKey:@"description"];
//        self.weblink = [dict objectForKey:@"weblink"];
//        
//    }
//    return self;
//}
//
//@end

@implementation SpeakersViewDetailsController



@synthesize svc;
@synthesize speakerInfo;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}


-(IBAction)viewProfileButtonClicked:(id)sender
{
    

    NSLog(@"WEBLINK %@  ",speakerInfo.weblink);
    
    NSString *urlString = speakerInfo.weblink;
    
    if (urlString != nil && ![urlString isEqualToString:@""] && [self validateUrl:urlString]) {
        
        WebViewController *webViewController = [[WebViewController alloc] init];
        
        webViewController.urlString = urlString;
        
        [self presentModalViewController:webViewController animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No valid information " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    

    
}


- (BOOL) validateUrl: (NSString *) candidate {
   
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    
    return [urlTest evaluateWithObject:candidate];
}


-(void)loadSpeakerImage
{
    NSString *logo = speakerInfo.logo;
    
    
    if (logo == nil || [logo isEqualToString:@""]) {
        
        return;
    }

    NSMutableString *mainlogo = [NSMutableString stringWithString:BASE_URL];
    [mainlogo appendString:logo];
    NSLog(@" URL AT  %@  ",  mainlogo);
      
    ImageDownloader *downloader = [ImageDownloader shareInstance];
    
    UIImage *image = [downloader getImage:mainlogo];
    if (image != nil) {
         NSLog(@" HIT AT  %@  ",  mainlogo);
        speakerImageView.image = image;
        
    }else{
        
        ImageLoader *loader = [[ImageLoader alloc]initWithUrl:mainlogo withSize: CGSizeZero delegate:self];
       [downloader addOperation:loader];
                               
    }
    

}
           
 -(void)onDownloadCompletion:(UIImage*)image : (ImageLoader*)imageLoader{
          
     [self performSelectorOnMainThread:@selector(updateCell) withObject:imageLoader waitUntilDone:NO];
  }


-(void)onErrorLoadingImage:(ImageLoader*)imageLoader{
    
}
                           
                            
 -(void)updateCell:(ImageLoader*)loader{
     
     ImageDownloader *downloader = [ImageDownloader shareInstance];
     UIImage *image = [downloader getImage:loader.url];
     speakerImageView.image = image;
     
  }
                            
                           
-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)assignStyles
{
    UIFont *subtitleFont = [UIFont fontWithName:[Util subTitleFontName] size:15];
    UIColor *textColor = [Util subTitleColor];
    

    
      
    CGSize size = [speakerInfo.firstName sizeWithFont:subtitleFont constrainedToSize:CGSizeMake(speakerName.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    CGRect frame = speakerName.frame;
    frame.size.height = size.height;
    speakerName.frame = frame;
    speakerName.numberOfLines = size.height/21+1;
    
    speakerName.text = speakerInfo.name;
    speakerName.font = subtitleFont;
    speakerName.textColor = textColor;
    
    size = [speakerInfo.type sizeWithFont:subtitleFont constrainedToSize:CGSizeMake(speakerDesignation.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    frame = speakerDesignation.frame;
    frame.origin.y = speakerName.frame.origin.y + speakerName.frame.size.height;
    frame.size.height = size.height;
    speakerDesignation.frame = frame;
    speakerDesignation.numberOfLines = size.height/21+1;

    
    speakerDesignation.text = speakerInfo.type;
    speakerDesignation.textColor = textColor;
    speakerDesignation.font=[UIFont fontWithName:[Util detailTextFontName] size:14];

    if (speakerInfo.description != nil && ![speakerInfo.
                                     description isEqualToString:@""]) {
       
        CGSize size  = [speakerInfo.description sizeWithFont:subtitleFont constrainedToSize:CGSizeMake(240, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        
        CGRect frame =  descriptionLabel.frame;
        frame.size.height = size.height +10;
        descriptionLabel.frame = frame;
        descriptionLabel.numberOfLines = size.height/2+1;
        descriptionLabel.text = speakerInfo.description;
        descriptionLabel.font = subtitleFont;
        descriptionLabel.textColor = textColor;

    }
    

    frame = profileButton.frame;
    
    frame.origin.y = descriptionLabel.frame.size.height + descriptionLabel.frame.origin.y +20;
    profileButton.frame = frame;
    
    CGFloat height = frame.origin.y+frame.size.height+20;
    [speakerScrollView setContentSize:CGSizeMake(310, height)];
    
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
    
    
    self.title = @"Speaker Info";
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    backGroundColor = 1;
   
    
     UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
     self.navigationItem.rightBarButtonItem = homeButton;
    
    
    UIImage *image = [UIImage imageNamed:@"default_img.png"];
    
      CGSize size = image.size;
      CGSize itemSize = CGSizeMake(size.width/2, size.height/2);
      UIImage  *scaleimage  = [image scaleImageToSize:itemSize];
     speakerImageView.image = scaleimage;
    
    [self loadSpeakerImage];
     [self assignStyles];


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
