//
//  ContactUsViewController.m
//  AppNMedia
//
//  Created by Saikumar Bondugula on 08/06/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "ContactUsViewController.h"
#import "AppNMediaAppDelegate.h"
#import "WebViewController.h"
#import "Util.h"

@interface ContactInfo : NSObject{
    
//    address1 = "Plot No.121, EPIP,";
//    address2 = "Whitefield Industrial Area,";
//    city = Bangalore;
//    contactemail = "enquiry@bangaloreit.biz";
//    contactname = "Mr.Aritro / Mr.Venkat";
//    contactphone = "7259207115 / 9844202080";
//    url = "http://www.bangaloreit.biz/IT_2012/index.php";
//    zipcode = 560052;
//     location = "Plot No.121, EPIP,,  Whitefield Industrial Area,, Bangalore, Karnataka 560052";
    
    NSString *_name1;
    NSString *_phone1;
    NSString *_name2;
    NSString *_phone2;
    
    NSString *_mail;
    NSString *_weblink;
    NSString *_address;
    
}

@property(nonatomic,retain) NSString *name1;
@property(nonatomic,retain) NSString *phone1;
@property(nonatomic,retain) NSString *name2;
@property(nonatomic,retain) NSString *phone2;
@property(nonatomic,retain) NSString *mail;
@property(nonatomic,retain) NSString *weblink;
@property(nonatomic,retain) NSString *address;


@end


@implementation ContactInfo

@synthesize name1=_name1;
@synthesize phone1=_phone1;
@synthesize name2=_name2;
@synthesize phone2=_phone2;
@synthesize mail=_mail;
@synthesize weblink=_weblink;
@synthesize address=_address;

-(id)init{
    self = [super init];
    if (self) {
        [self initVars];
    }
    return self;
}

-(void)initVars{
    
    AppNMediaAppDelegate *appDelegate = (AppNMediaAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *tmpDict = [appDelegate.eventsArray objectAtIndex:0];
    NSString *token = [tmpDict objectForKey:@"contactname"];
   NSArray *tokens = [token componentsSeparatedByString:@"/"];
    
        
    self.mail = [tmpDict objectForKey:@"contactemail"];
    self.name1 = [tokens objectAtIndex:0];
    self.name2 = [tokens objectAtIndex:1];
    
    token = [tmpDict objectForKey:@"contactphone"];
    tokens = [token componentsSeparatedByString:@"/"];
    
    self.phone1 = [tokens objectAtIndex:0];
    self.phone2 = [tokens objectAtIndex:1];
    self.weblink = [tmpDict objectForKey:@"url"];
    self.address = [tmpDict objectForKey:@"location"];
    
}

@end

@implementation ContactUsViewController

static ContactInfo *info;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)makeaMap
{
    if ([appDelegate.eventsArray count]>0)
    {
        NSMutableDictionary *tmpDict = [appDelegate.eventsArray objectAtIndex:appDelegate.selectedEvent];
        
        NSString *tmpStr = @"";     
        if ([tmpDict objectForKey:@"location"]!=nil)
        {
            tmpStr = [tmpDict objectForKey:@"location"];
        }
        
        openMap = [[mapViews alloc] init];
        
        openMap.urlString = tmpStr;
        
        [self presentModalViewController:openMap animated:YES];
    }
}

-(void)initView{
     
    float y = 10;
    
    UIFont *labelFont = [UIFont fontWithName:[Util detailTextFontName] size:15];
    UIColor *labelCOlor = [Util titleColor];
    UIFont *detailFont = [UIFont fontWithName:[Util subTitleFontName] size:14];
    
    UILabel *startLabel = [[UILabel alloc]initWithFrame:CGRectMake(20  , y, 91, 21)];
    startLabel.font = [UIFont fontWithName:[Util detailTextFontName] size:15];
    startLabel.textColor = labelCOlor;
    startLabel.textAlignment = UITextAlignmentRight;
    startLabel.text=@"Name       :";
    startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
     
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(120  , y, 179, 21)];
    startLabel.font = detailFont;
    startLabel.textColor = [Util detailTextColor];
    startLabel.textAlignment = UITextAlignmentLeft;
    startLabel.text= info.name1;
    startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    y += 10+21;
    
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(20  , y, 91, 21)];
    startLabel.font = [UIFont fontWithName:[Util detailTextFontName] size:15];
    startLabel.textColor = labelCOlor;
    startLabel.textAlignment = UITextAlignmentRight;
    startLabel.text=@"Phone No :";
    startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
//    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(120  , y, 179, 21)];
//    startLabel.font = detailFont;
//    startLabel.textColor = [Util detailTextColor];
//    startLabel.textAlignment = UITextAlignmentLeft;
//    startLabel.text= info.phone1;
//    startLabel.backgroundColor = [UIColor clearColor];
    UITextView *phone = [[UITextView alloc]initWithFrame:CGRectMake(120  , y, 179, 25)];
    phone.font = detailFont;
    phone.textColor = [Util detailTextColor];
    phone.textAlignment = UITextAlignmentLeft;
    phone.text= info.phone1;
    phone.backgroundColor = [UIColor clearColor];
    [phone setUserInteractionEnabled:YES];
    [phone setScrollEnabled:NO];
    [phone setEditable:NO];
    [phone setDataDetectorTypes:UIDataDetectorTypePhoneNumber];
    
    [scrollView addSubview:phone];
    
    y += 10+21;
    
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(20  , y, 91, 21)];
    startLabel.font = [UIFont fontWithName:[Util detailTextFontName] size:15];
    startLabel.textColor = labelCOlor;
    startLabel.textAlignment = UITextAlignmentRight;
    startLabel.text=@"Name       :";
    startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(120  , y, 179, 21)];
    startLabel.font = detailFont;
    startLabel.textColor = [Util detailTextColor];
    startLabel.textAlignment = UITextAlignmentLeft;
    startLabel.text= info.name2;
    startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    y += 10+21;
    
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(20  , y, 91, 21)];
    startLabel.font = [UIFont fontWithName:[Util detailTextFontName] size:15];
    startLabel.textColor = labelCOlor;
    startLabel.textAlignment = UITextAlignmentRight;
    startLabel.text=@"Phone No :";
    startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
     
    phone = [[UITextView alloc]initWithFrame:CGRectMake(120  , y, 179, 25)];
    phone.font = detailFont;
    phone.textColor = [Util detailTextColor];
    phone.textAlignment = UITextAlignmentLeft;
    phone.text= info.phone2;
    phone.backgroundColor = [UIColor clearColor];
    [phone setUserInteractionEnabled:YES];
    [phone setScrollEnabled:NO];
    [phone setEditable:NO];
    [phone setDataDetectorTypes:UIDataDetectorTypePhoneNumber];
    [scrollView addSubview:phone];
    
    
    y += 10+25;
    
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(20  , y, 91, 21)];
    startLabel.font = [UIFont fontWithName:[Util detailTextFontName] size:15];
    startLabel.textColor = labelCOlor;
    startLabel.textAlignment = UITextAlignmentRight;
    startLabel.text=@"Email ID   :";
    startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    UITextView *email  = [[UITextView alloc]initWithFrame:CGRectMake(120  , y, 190, 25)];
    email.font = detailFont;
    email.textColor = [Util detailTextColor];
    email.textAlignment = UITextAlignmentLeft;
    email.text= info.mail;
    email.backgroundColor = [UIColor clearColor];
    [email setEditable:NO];
    [email setUserInteractionEnabled:YES];
    [email setScrollEnabled:NO];
    
    [scrollView addSubview:email];
    
    y += 10+25;
    
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(20  , y, 91, 21)];
    startLabel.font = [UIFont fontWithName:[Util detailTextFontName] size:15];
    startLabel.textColor = labelCOlor;
    startLabel.textAlignment = UITextAlignmentRight;
    startLabel.text=@"Address   :";
    startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    CGSize size = [info.address sizeWithFont:detailFont constrainedToSize:CGSizeMake(180, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(120 , y, 179, size.height+10)];
    startLabel.font = detailFont;
    startLabel.textColor = [Util detailTextColor];
    startLabel.textAlignment = UITextAlignmentLeft;
    startLabel.numberOfLines = size.height/21+1;
    
    startLabel.text= info.address;
    startLabel.backgroundColor = [UIColor clearColor];
    
    [scrollView addSubview:startLabel];
    
    y += 10+size.height +10;
    
    startLabel = [[UILabel alloc]initWithFrame:CGRectMake(20  , y, 91, 21)];
    startLabel.font = [UIFont fontWithName:[Util detailTextFontName] size:15];
    startLabel.textColor = labelCOlor;
    startLabel.textAlignment = UITextAlignmentRight;
    startLabel.text=@"Web Link :";
    startLabel.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:startLabel];
    
    UIButton *weblinkLabel = [[UIButton alloc]initWithFrame:CGRectMake(120  , y, 179, 42)];
    [weblinkLabel setTitleColor:[Util linkTextColor] forState:UIControlStateNormal];
    weblinkLabel.titleLabel.numberOfLines=2;
     [weblinkLabel setTitleColor:[Util titleColor] forState:UIControlStateSelected];
    weblinkLabel.titleLabel.font = detailFont;
    weblinkLabel.titleLabel.textColor = [Util detailTextColor];
    weblinkLabel.titleLabel.textAlignment = UITextAlignmentLeft;
    
    [weblinkLabel setTitle:info.weblink forState:UIControlStateNormal];
    weblinkLabel.backgroundColor = [UIColor clearColor];
    [weblinkLabel setTitleColor:[Util titleColor] forState:UIControlStateHighlighted];
    
    [weblinkLabel addTarget:self action:@selector(onWebLinkSelection:) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView addSubview:weblinkLabel];
    
    [scrollView setContentSize:CGSizeMake(300, y+10+50)];
    
    
}

-(void)onWebLinkSelection:(UIButton*)sender{
    NSString *url = info.weblink;
   UIApplication *app =  [UIApplication sharedApplication] ;
    if ([app canOpenURL:[NSURL URLWithString:url]]) {
       [app openURL:[NSURL URLWithString:url]];
    }
    
}

-(IBAction)buttonClicked:(UIButton *)sender
{
    if (sender.tag == 0)
    {
        [self callMailCraetionMethod];  
    }
    else if(sender.tag == 1)
    {
        NSMutableDictionary *tmpDict = [appDelegate.eventsArray objectAtIndex:appDelegate.selectedEvent];
        NSString *strPhoneNumber = [tmpDict objectForKey:@"contactphone"] ;
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]])
        {
           // NSLog(@"%@",strPhoneNumber);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", strPhoneNumber ]]];
        } 
        else 
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You can't call from this device" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
  
    }
}


-(void)callMailCraetionMethod
{
    MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
    mail.mailComposeDelegate = self;
    if ([MFMailComposeViewController canSendMail]) 
    {
        //Present the mail view controller
        NSMutableDictionary *tmpDict = [appDelegate.eventsArray objectAtIndex:appDelegate.selectedEvent];
        
        if ([tmpDict objectForKey:@"contactemail"]  != nil)
        {
            NSArray *toRecipients = [NSArray arrayWithObject:[tmpDict objectForKey:@"contactemail"]]; 
            [mail setToRecipients:toRecipients];
        }
        [self presentModalViewController:mail animated:YES];
        
    }
    //release the mail
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissModalViewControllerAnimated:YES];
    if (result == MFMailComposeResultFailed)
    {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@”Message Failed!” message:@”Your email has failed to send” delegate:self cancelButtonTitle:@”Dismiss” otherButtonTitles:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message Failed" message:@"Your email has failed to send" delegate:self cancelButtonTitle:@"Ok"  otherButtonTitles:nil];
        [alert show];
    }
}

-(void)homeButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)assignStyles
{
    titleFontName = [Util subTitleFontName];
    titleFontSize = @"15";
    subTitleFontName = [Util detailTextFontName];
    subTitleFontSize = @"15";
       
    [emailidLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    emailidLabel.textColor = [UIColor whiteColor];
    
    [emailidDataTextView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    emailidDataTextView.textColor = [UIColor whiteColor];
    
    [phoneNoLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    phoneNoLabel.textColor = [UIColor whiteColor];
    
    [phoneNoDataLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    phoneNoDataLabel.textColor = [UIColor whiteColor];
    
    [addressLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    addressLabel.textColor = [UIColor whiteColor];
    
    [urlLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
     urlLabel.textColor = [UIColor blueColor];
    
    [clientNameLabel setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    clientNameLabel.textColor = [UIColor  whiteColor];
    
    [addressTextView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    addressTextView.textColor = [UIColor whiteColor];
    
    [urlTxtView setFont:[UIFont fontWithName:titleFontName size:[titleFontSize intValue]]];
    urlTxtView.textColor = [UIColor whiteColor];
    
    NSMutableDictionary *tmpDict = [appDelegate.eventsArray objectAtIndex:appDelegate.selectedEvent];
        
    if ([tmpDict objectForKey:@"contactemail"]  != nil)
    {
        emailidDataTextView.text = [tmpDict objectForKey:@"contactemail"];
    }
    if ([tmpDict objectForKey:@"contactphone"] ) 
    {
        [phoneButton setTitle:[tmpDict objectForKey:@"contactphone"] forState:UIControlStateNormal];
        phoneNoDataLabel.text = [tmpDict objectForKey:@"contactphone"] ;
    }
    if ([tmpDict objectForKey:@"url"] ) 
    {
        urlTxtView.text = [tmpDict objectForKey:@"url"] ;
    }
    
    if ([tmpDict objectForKey:@"location"] ) 
    {
        addressTextView.text = [tmpDict objectForKey:@"location"] ;
    }
    
   // NSLog(@"%@",[appDelegate.eventsArray objectAtIndex:0]);
    if ([[[appDelegate.mainResponseDictionary objectForKey:@"root"] objectForKey:@"client"] objectForKey:@"clientname"]) 
    {
        clientNameLabel.text = [[[appDelegate.mainResponseDictionary objectForKey:@"root"] objectForKey:@"client"] objectForKey:@"clientname"] ;
    }


    urlTxtView.textColor = [UIColor whiteColor];
    
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    [textView resignFirstResponder];
    if (textView.tag == 0)
    {
        [self callMailCraetionMethod];  
    }
    else
    {
         NSMutableDictionary *tmpDict = [appDelegate.eventsArray objectAtIndex:appDelegate.selectedEvent];
        if ([tmpDict objectForKey:@"url"] ) 
        {
//            NSString *urlString = [tmpDict objectForKey:@"url"];
//            if (webViewController != nil)
//            {
//                webViewController = [[WebViewController alloc] init];
//
//            }
//            
//            
//            webViewController.urlString = urlString;
//            
//            [self presentModalViewController:webViewController animated:YES];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[tmpDict objectForKey:@"url"]]];

        }
    }
    return NO;
}


- (void)dealloc
{
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppNMediaAppDelegate *) [[UIApplication sharedApplication] delegate];

    self.title = @"Contact Us";
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain  target:self action:@selector(homeButtonClicked)];     
    self.navigationItem.rightBarButtonItem = homeButton;

    contactUsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    if ([[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"contactus"]  isKindOfClass:[NSDictionary class]]) 
    {
        [contactUsArray addObject:[[appDelegate.mainResponseDict objectForKey:@"event"] objectForKey:@"contactus"] ];
    }
    else
    {
        [contactUsArray addObjectsFromArray:[[appDelegate.mainResponseDict objectForKey:@"event"]  objectForKey:@"contactus"]];
    }

    UITapGestureRecognizer *txtTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeaMap)];
    [addressTextView addGestureRecognizer:txtTapGesture];
    addressTextView.userInteractionEnabled = YES;
//    transparentImageView.frame = CGRectMake(30, 70, 260, 250);
    
    scrollView.frame = CGRectMake(10, 0, 300, 285);
    [scrollView setContentSize:CGSizeMake(300, 600)];
    scrollView.showsVerticalScrollIndicator = NO;
    info = [[ContactInfo alloc]init];
    [self initView];
    
 }

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
