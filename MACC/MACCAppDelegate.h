//
//  MACCAppDelegate.h
//  MACC
//
//  Created by 水野 真史 on 11/06/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

//クラスの宣言
@interface MACCAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *naviController;
    UIActivityIndicatorView *activity;
    UIImageView *splashImageView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UINavigationController *naviController;
@property (nonatomic,retain) UIActivityIndicatorView *activity;
@property (nonatomic,retain) UIImageView *splashImageView;

@end
