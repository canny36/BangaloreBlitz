//
//  AgendaSpeakerDetailsViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 29/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "AgendaSpeakerDetailsViewController.h"
#import "AppNMediaAppDelegate.h"

@implementation AgendaSpeakerDetailsViewController
@synthesize selectedArray;
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
        // Custom initialization
    }
    return self;
}
-(void)addDetailUi
{
  
    int x = 5;
    int y = 5;
    
    for (int i = 0; i<[selectedArray count]; i++)
    {
        NSMutableDictionary *tmpDict = [selectedArray objectAtIndex:i];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x+130, y, 50, 50)];
        imageView.image = [UIImage imageNamed:@"NoImage.png"];
        imageView.tag  = i;
          y= y+50+10;
        
        [detailsScrollView addSubview:imageView];
        [speakerImageViewArray addObject:imageView];
        [tmpDict setObject:[NSString stringWithFormat:@"%d",imageView.tag] forKey:@"tag"];
        
        [self performSelectorInBackground:@selector(addImageToImageView:) withObject:tmpDict];
        
        UITextView *nameTextView = [[UITextView alloc] initWithFrame:CGRectMake(x+5, y, 280, 25)];
        
        NSString *nameStr  = @"By : ";
        if ([tmpDict objectForKey:@"firstname"]!= nil)
        {
            nameStr  = [nameStr stringByAppendingString:[tmpDict objectForKey:@"firstname"]];
        }
        
        if ([tmpDict objectForKey:@"lastname"]!= nil)
        {
            nameStr  = [nameStr stringByAppendingString:[tmpDict objectForKey:@"lastname"]];
        }
        
        nameTextView.text = nameStr;
        nameTextView.editable = NO;
        nameTextView.backgroundColor = [UIColor clearColor];
        nameTextView.font = [UIFont fontWithName:titleFontName size:[titleFontSize intValue]];
        nameTextView.textColor = [UIColor whiteColor];
        
        CGRect frame = nameTextView.frame;
        int height = nameTextView.contentSize.height;
        nameTextView.frame = frame;
        y = y+height+5;
        
        [detailsScrollView addSubview:nameTextView];
        
        
        UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(x+10, y, 150, 30)];
        descriptionLabel.text = @"Description";
        descriptionLabel.font = [UIFont fontWithName:titleFontName size:[titleFontSize intValue]];       
        descriptionLabel.textColor = [UIColor whiteColor];

        descriptionLabel.backgroundColor = [UIColor clearColor];
                                                      
        [self.view addSubview:descriptionLabel];
        
        y = y+30;
        
        [detailsScrollView addSubview:descriptionLabel];
        
        UITextView *descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(x, y, 280, 50)];
        
        if ([tmpDict objectForKey:@"description"]!= nil)
        {
            descriptionTextView.text  = [tmpDict objectForKey:@"description"];
            CGRect frame = descriptionTextView.frame;
            int height = descriptionTextView.contentSize.height;
            descriptionTextView.frame = frame;
            y = y+height+10;
        }
        else
        {
            descriptionTextView.text  = @"No details available";
        }
        descriptionTextView.editable = NO;
        descriptionTextView.backgroundColor = [UIColor clearColor];
        descriptionTextView.font = [UIFont fontWithName:titleFontName size:[titleFontSize intValue]];
        descriptionTextView.textColor = [UIColor whiteColor];

        
        [detailsScrollView addSubview:descriptionTextView];
        
        
    }
    
    [detailsScrollView setContentSize:CGSizeMake(300, y+50)];
    
    
}

-(void)addImageToImageView :(NSMutableDictionary *)tmpDict
{
 
    if ([offlineSpeakersImagesArr count]>0)
    {
    for (int i=0; i<[speakersArray count]; i++)
    {
        NSMutableDictionary *tmpDict1 = [speakersArray objectAtIndex:i];
        
        for (int j = 0; j<[speakerImageViewArray count]; j++)
        {
           
        UIImageView *tmpImageView = [speakerImageViewArray objectAtIndex:j];
       
        if (tmpImageView.tag == [[tmpDict objectForKey:@"tag"] intValue]) 
        {
            if ([tmpDict objectForKey:@"speakerid"] != nil)
            {
                    if ([[tmpDict1 objectForKey:@"speakerid"] intValue] == [[tmpDict objectForKey:@"speakerid"] intValue]) 
                    {
                        tmpImageView.image = [UIImage imageWithData:[offlineSpeakersImagesArr objectAtIndex:i]];
                        j = [speakerImageViewArray count];
                        i = [speakersArray count];
                    }
                
            }
     
         }
            
       }
      }
    }
    else
    {
        for (int i=0; i<[speakersArray count]; i++)
        {
            NSMutableDictionary *tmpDict1 = [speakersArray objectAtIndex:i];
            
            for (int j = 0; j<[speakerImageViewArray count]; j++)
            {
                
                UIImageView *tmpImageView = [speakerImageViewArray objectAtIndex:j];
                
                if (tmpImageView.tag == [[tmpDict objectForKey:@"tag"] intValue]) 
                {
                    if ([tmpDict objectForKey:@"speakerid"] != nil)
                    {
                        if ([[tmpDict1 objectForKey:@"speakerid"] intValue] == [[tmpDict objectForKey:@"speakerid"] intValue]) 
                        { 
                            
                            NSString *baseUrl = BASE_URL;
                                if ([tmpDict objectForKey:@"speakerphoto"] != nil)
                                {
                                    NSString *imageUrl = [tmpDict objectForKey:@"speakerphoto"];
                                    baseUrl = [baseUrl stringByAppendingString:imageUrl];
                                    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:baseUrl]]];
                                    if(img)
                                    {
                                        tmpImageView.image = img;
                                    }
                                    else
                                    {
                                        tmpImageView.image = [UIImage imageNamed:@"NoImage.png"];
                                    }
                                    
                                }
                                else
                                {
                                    tmpImageView.image = [UIImage imageNamed:@"NoImage.png"];
   
                                }

                        }
                    }
                }
            }

       
    }
    }
    
}



- (void)dealloc
{
   
}

-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)assignStyles
{
    
    titleFontName =@"Helvitica-Bold";
    titleFontSize = @"14";
    subTitleFontName = @"Helvitica";
    subTitleFontSize = @"12";

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
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-20, 0, 250, 25)] ;
    label.backgroundColor = [UIColor clearColor];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text =@"Artists Details";
    self.navigationItem.titleView = label;
    [self assignStyles];
    
    
    detailsScrollView.frame = CGRectMake(10, 60, 300, 250);
    
    
    speakersArray = [[NSMutableArray alloc] initWithCapacity:0];
    if ([[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"speakerslist"] objectForKey:@"speaker"] isKindOfClass:[NSDictionary class]]) 
    {
        [speakersArray addObject:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"speakerslist"] objectForKey:@"speaker"]];
    }
    else
    {
        [speakersArray addObjectsFromArray:[[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"speakerslist"] objectForKey:@"speaker"]];
    } 
    
    speakerImageViewArray = [[NSMutableArray alloc] initWithCapacity:0];
    
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
    
    
    [self addDetailUi];
    
    transparentImageView.frame = CGRectMake(30, 70, 260, 250);

    //speakerphoto
    

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
