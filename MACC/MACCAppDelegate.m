//
//  MACCAppDelegate.m
//  MACC
//
//  Created by 水野 真史 on 11/06/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//zq

//インポート
#import "MACCAppDelegate.h"
#import "MACCViewController.h"
#import "ColumnViewController.h"
#import "InfoViewController.h"
#import "EventViewController.h"

//----------　----------//
//navigationbarの背景追加するためのカテゴリ
//----------　----------//
@implementation UINavigationBar (CustomImage)
- (void)drawRect:(CGRect)rect {
	UIImage *image = [UIImage imageNamed: @"NavigationBar.png"];
	[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
}
@end


//クラスの実装
@implementation MACCAppDelegate
@synthesize activity;
@synthesize splashImageView;


//プロパティの実装
@synthesize window, naviController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    self.window.backgroundColor = [UIColor blackColor];
    
    //----------起動画面表示延長----------//
    UIImage *splashImage = [UIImage imageNamed: @"Default.png"];
    splashImageView = [[UIImageView alloc] initWithImage:splashImage];
    [window addSubview:splashImageView];
    [NSTimer scheduledTimerWithTimeInterval:5.0
                                     target:self
                                   selector:@selector(onTimer:)
                                   userInfo:nil
                                    repeats:NO];
	
	//----------NavigationControllerの設定----------//
    InfoViewController *ctrl01 = [[InfoViewController alloc] initWithNibName:nil bundle:nil];
    ColumnViewController *ctrl02 = [[ColumnViewController alloc] initWithNibName:nil bundle:nil];
    MACCViewController *ctrl03 = [[MACCViewController alloc] initWithNibName:nil bundle:nil];
    EventViewController *ctrl04 = [[EventViewController alloc] initWithNibName:nil bundle:nil];
    
    UIColor *barColor = [UIColor colorWithRed:0.651 green:0.565 blue:0.451 alpha:1.0];
    
    


    // navigation controller
    //navi01
    UINavigationController *navi01 = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
    [navi01 pushViewController:ctrl01 animated:NO];
    [ctrl01 release];    
    //バーのスタイルを指定
	[navi01.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    navi01.navigationBar.tintColor = barColor;  
	
    //navi02
    UINavigationController *navi02 = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
    [navi02 pushViewController:ctrl02 animated:NO];
    [ctrl02 release];
    
    //バーのスタイルを指定
    [navi02.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    navi02.navigationBar.tintColor = barColor;    
    
    //navi03
    UINavigationController *navi03 = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
    [navi03 pushViewController:ctrl03 animated:NO];
    [ctrl03 release];    
    //バーのスタイルを指定
	[navi03.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    navi03.navigationBar.tintColor = barColor;
    
    //navi04
    UINavigationController *navi04 = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
    [navi04 pushViewController:ctrl04 animated:NO];
    [ctrl04 release];    
    //バーのスタイルを指定
	[navi04.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    navi04.navigationBar.tintColor = barColor;
    
    
    // tabbar controller
    UITabBarController *tab = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
    [tab setViewControllers:[NSArray arrayWithObjects:navi01, navi02, navi03, navi04, nil]];
    [window addSubview:tab.view];
    [navi01 release];
    [navi02 release];
    [navi03 release];
    [navi01 release];
    
    // アニメーションの設定
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];	//変化にリズムを付ける（イーズイン・イーズアウト）
	[UIView setAnimationDuration:3.0];
    activity =
    [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(140, 210, 40, 40)];
    activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activity.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    //activity.center = self.view.center;
    [self.window addSubview:activity];
    [activity startAnimating];    
    activity.alpha = 0.0;
    
    [UIView commitAnimations];
    
    
    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[naviController release];
    [window release];
    [activity release];
    [super dealloc];
}

//----------起動画面を非表示にするタイマーメソッド----------//
- (void)onTimer:(NSTimer *)timer {
    [splashImageView removeFromSuperview];
    [splashImageView release];
}

@end
