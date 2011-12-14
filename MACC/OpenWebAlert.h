//
//  OpenWebAlert.h
//  MACC
//
//  Created by 水野 真史 on 11/11/25.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenWebAlert : UIView <UIAlertViewDelegate> {
    UIAlertView *alertView;
    NSString *title;
    NSString *message;
    NSString *url;
} 

@property (nonatomic, retain) UIAlertView *alertView;

- (void)alertOpen:(NSString *)_title message:(NSString *) _message URL:(NSString *)_url;

@end
