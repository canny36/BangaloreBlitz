//
//  AgendaDetailsViewController.h
//  AppNMedia
//
//  Created by Saikumar Bondugula on 10/05/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mapViews.h"
#import "AgendaItem.h"
#import "SubAgendaItem.h"


@class AppNMediaAppDelegate;
@class AgendaSpeakerDetailsViewController;
@interface AgendaDetailsViewController : UIViewController <UITextViewDelegate>
{
    AppNMediaAppDelegate    *appDelegate;
    NSMutableArray      *speakersDetailsArray;
    IBOutlet UIScrollView *scrollView;

    mapViews *openMap;
    AgendaItem *_agendaItem;
    SubAgendaItem *_subAgendaItem;
    
}

-(void)onSpeakerClick;
@property(nonatomic , retain) AgendaItem *agendaItem;
@property(nonatomic , retain) SubAgendaItem *subAgendaItem;

@end
