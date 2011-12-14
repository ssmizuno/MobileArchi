//
//  OpenWebAlert.m
//  MACC
//
//  Created by 水野 真史 on 11/11/25.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "OpenWebAlert.h"

@implementation OpenWebAlert

@synthesize alertView;

- (void)alertOpen:(NSString *)_title message:(NSString *) _message URL:(NSString *)_url 
{
    title = _title;
    message = _message;
    url = _url;    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:_message
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
		case 0: {
            //Cancel
			break;
		}
		case 1: {
            NSLog(@"%@", url);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
			break;
    }
}

@end
