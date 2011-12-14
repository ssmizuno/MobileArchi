//
//  AppDelegate.m
//  MACC
//
//  Created by masashi mizuno on 11/12/08.
//  Copyright (c) 2011年 SSkikaku. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
//-------------------------------------------------------
//アプリケーションの初期化処理
//-------------------------------------------------------
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[MainViewController alloc] initWithNibName:nil bundle:nil];
    //背景パターンの作成
    UIImage *bgTile = [UIImage imageNamed:@"bg_tile.jpg"];
    self.window.backgroundColor = [UIColor colorWithPatternImage:bgTile];
    //NavigationControllerの追加
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    //ナビゲーションバーの色変更
    nav.navigationBar.tintColor = [UIColor colorWithRed:0.651 green:0.565 blue:0.451 alpha:0];
    
    //ナビゲーションバーの背景画像設定
    UIImage *navBgImage = [UIImage imageNamed:@"NavigationBar.png"];
    //iOS5用
    if ([nav.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        [nav.navigationBar setBackgroundImage:navBgImage forBarMetrics:UIBarMetricsDefault];
    }
    //iOS4.3用
    else {
        UIImageView *navBgImageView = [[UIImageView alloc] initWithImage:navBgImage];
        navBgImageView.frame = nav.navigationBar.bounds;
        navBgImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        navBgImageView.layer.zPosition = -FLT_MAX;
        [nav.navigationBar insertSubview:navBgImageView atIndex:0];
    }
    
    //MainViewControllerをrootに設定
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
