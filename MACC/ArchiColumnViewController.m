//
//  ArchiColumnViewController.m
//  MACC
//
//  Created by 水野 真史 on 11/06/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArchiColumnViewController.h"
#import "MiesViewController.h"
//----------　----------//
//変数用意
//----------------------------------------------------------------------//
static NSString *Surl = @"http://www.ss-maple.co.jp/ma_resources/sound/archicolumn.mp3";
//----------------------------------------------------------------------//

//クラスの実装
@implementation ArchiColumnViewController

//プロパティの実装
@synthesize narration;
@synthesize customToolbar;
@synthesize scrollView;
@synthesize pageControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //----------　----------//
    //titleの設定
    //----------　----------//
    self.title = @"近代建築の名作を歩く";
    
    //----------　----------//
    //背景フレームの作成
    //----------　----------//
    UIImage *Image = [UIImage imageNamed:@"background.png"];
    UIImageView *ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Image.size.width, Image.size.height)];
    ImageView.image = Image;
    [self.view addSubview:ImageView];
    [ImageView release];
    //----------　----------//
    //タイトルの作成
    //----------　----------//
    UILabel *columnTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 310, 44)];
    columnTitle.text = @"ファンズワース邸";
    columnTitle.numberOfLines = 0;
    columnTitle.textAlignment = UITextAlignmentCenter;
    columnTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
    columnTitle.textColor = [UIColor whiteColor];
    columnTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:columnTitle];
    [columnTitle release];
    
    //----------　----------//
    //説明文
    //----------　----------//
    UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 205, 300, 180)];
    NSString *textPath = [[NSBundle mainBundle] pathForResource:@"archiColumn" ofType:@"txt"];
    NSString *text = [NSString stringWithContentsOfFile:textPath encoding:NSUTF8StringEncoding error:nil];
    textview.text = text;
    textview.font = [UIFont systemFontOfSize:16.0];
    textview.editable = NO;
    textview.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6];
    [self.view addSubview:textview];
    [textview release];
    
    //----------　----------//
    //ページコントロール付きのスクロールビュー
    //----------　----------//
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, 160)];
    scrollView.backgroundColor = [UIColor  colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3, scrollView.frame.size.height);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;
    
    scrollView.bounces = YES;
    
    //画像を読み込んでスクロールビューに追加
    for (int i = 0; i < 3; i++) {
        
        UIImage *scrollImage;
        if(i < 2){
            scrollImage = [UIImage imageNamed:[NSString stringWithFormat:@"archic0%02d.png", i+1]];
        }else {
            scrollImage = [UIImage imageNamed:[NSString stringWithFormat:@"archic0%02d.png", i+1]];
            
        }
        
        UIImageView *scrollImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*320, 0, 320, 160)];
        scrollImageView.image = scrollImage;
        [scrollView addSubview:scrollImageView];
        [scrollImageView release];
        
    }
    
    //ページコントロールの追加
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(60, 174, 200, 50)];
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(pageChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:scrollView];
    [self.view addSubview:pageControl];
    
     //----------　----------//
     //カスタムツールバーの設定
     //----------　----------//
     self.customToolbar = [UIToolbar new];
     
     //-- ツールバーのスタイル --//
     //self.customToolbar.barStyle = UIBarStyleDefault;
     self.customToolbar.barStyle = UIBarStyleBlack;
     
     //-- ツールバーのサイズ --//
     [self.customToolbar sizeToFit];	
     CGFloat toolbarHeight = [self.customToolbar frame].size.height;
     CGRect mainViewBounds = self.view.bounds;
     
    [self.customToolbar setFrame:CGRectMake(CGRectGetMinX(mainViewBounds),
                                            CGRectGetMinY(mainViewBounds) + CGRectGetHeight(mainViewBounds) - (toolbarHeight * 2.0) + 2.0,
                                            CGRectGetWidth(mainViewBounds),
                                            toolbarHeight)];     
     //-- ツールバースタイルの設定 ----------------------//
     //UIBarButtonItemStyle itemStyle = UIBarButtonItemStylePlain;
     UIBarButtonItemStyle itemStyle = UIBarButtonItemStyleBordered;
     //UIBarButtonItemStyle itemStyle =  UIBarButtonItemStyleDone;
     
     //-- OK、Doneボタンの設定 ------------------------//
     UIBarButtonItem *defaultItem = [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemAction
     target:self action:@selector(dialogOtherAction)];
     
     //-- ツールバースタイルの適用 --//
     defaultItem.style = itemStyle;
     
     //-- 可変領域の設定 ------------------------------//
     UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
     target:nil
     action:nil];
     
     //-- 各アイテムのスタイルの設定----------------//
     //----------narration再生ボタン----------//
     UIBarButtonItem *playbutton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"soundicon.png"]
     style:UIBarButtonItemStyleBordered
     target:self
     action:@selector(alertOKCancelAction)];
     //-- ツールバースタイルの適用 --//
     playbutton.style = itemStyle;
     
     //----------narration停止ボタン----------//
     UIBarButtonItem *stopbutton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause
     target:self
     action:@selector(soundstop:)];
     //-- ツールバースタイルの適用 --//
     stopbutton.style = itemStyle;
     
    //----------建築家情報----------//
    UIBarButtonItem *archibutton = [[UIBarButtonItem alloc] initWithTitle:@"Architect" style:UIBarButtonItemStylePlain target:self action:@selector(architectShow:)];
    //-- ツールバースタイルの適用 --//
    archibutton.style = itemStyle;
     
     
     //-- 設定したアイテムをバーに登録 -------------------//
     // アイテムは配列に入れてバーに設定します
     //---------------------------------------------//
     NSArray *barItems = [NSArray arrayWithObjects: playbutton, stopbutton, flexibleSpace, archibutton, defaultItem, nil];
     [self.customToolbar setItems:barItems animated:YES];
     
     //-- オブジェクトを解放します --------------------------//
     [defaultItem release];
     [flexibleSpace release];
     [playbutton release];
     [stopbutton release];
     [archibutton release];
     
     [self.view addSubview:customToolbar];
     
    
}

//----------ページ遷移----------//
//ミース・ファン・デル・ローエ
-(void)architectShow:(id)sender{	
	MiesViewController *next01 = [[[MiesViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    next01.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:next01 animated:YES];
}


#pragma -
#pragma ページコントロールの制御

//----------　----------//
//スクロールビューのページが変わったら呼ばれるメソッド
//----------　----------//
- (void)pageChanged {
	CGRect pageFrame = scrollView.frame;
	pageFrame.origin.x = pageFrame.size.width * pageControl.currentPage;
	
	[scrollView scrollRectToVisible:pageFrame animated:YES];
}

//----------　----------//
//スクロールが終わったら呼ばれるメソッド
//----------　----------//
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = scrollView.frame.size.width;
    pageControl.currentPage = 1 + floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth);
}

#pragma -
#pragma アラートの設定

//-- アラートの設定 その3 -----------------------------//
// OK、キャンセルボタンを設定したアラートです。
//-------------------------------------------------//
- (void)alertOKCancelAction
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"再生確認"
                                                    message:@"音声を再生しますか？\n※ネットワーク環境が必要です"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Play", nil];
	[alert show];
	[alert release];
}


#pragma mark -
#pragma mark アクションシートの設定

//----------　----------//
//アクションシートの設定
//----------　----------//
- (void)dialogOtherAction
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"画像検索（Safariが開きます）", /*@"建築家情報",*/ nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	[actionSheet showInView:self.view];
	[actionSheet release];
}

#pragma mark -
#pragma mark UIActionSheetDelegateメソッドに一部の処理を任せます
//----------　----------//
//アクションシートボタン押下時処理
//----------　----------//
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
		case 0: {
			//google画像検索結果を表示（safari起動）
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.google.co.jp/m/search?oe=UTF-8&client=safari&q=%E3%83%95%E3%82%A1%E3%83%B3%E3%82%BA%E3%83%AF%E3%83%BC%E3%82%B9%E9%82%B8&hl=ja&site=images&ei=rPscTpiqGYmqkAXBgbqJAg&ved=0CBIQ7AkwAA"]];
			break;
		}
    }
}

#pragma mark -
#pragma mark UIAlertViewDelegateメソッドに一部の処理を任せます

//-- アラートボタン押下時処理 --------------------------//
// アラートの各ボタンが押された時の処理です。
//-------------------------------------------------//
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
		case 0: {
            //Cancel
            [narration stop]; 
			break;
		}
		case 1: {
            //再生開始
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            NSURL *furl = [NSURL URLWithString:Surl];
            NSData *data = [NSData dataWithContentsOfURL:furl];
			//NSURL *furl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:Ccont ofType:@"mp3"]];
            narration = [[AVAudioPlayer alloc] initWithData:data error:nil];
            
            if (narration.playing) {
                [narration stop];
            } else {
                [narration play];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                NSLog(@"kfkfkfkfk");
            }
			break;
		}
	}
}
//----------　----------//
//音声停止アクション
//----------　----------//
- (void)soundstop:(id)sender {
    [narration stop];    
}


//非アクティブになったときに呼ばれる
- (void)viewDidDisappear:(BOOL)animated {
    [narration stop];
    narration = nil;
}

#pragma -
#pragma DidUnload
//----------　----------//
//ViewのUnload時に動作
//----------　----------//
- (void)viewDidUnload {
    if (narration.playing) {
        [narration stop];
    }
}

//----------　----------//
//メモリ解放用
//----------　----------//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//----------　----------//
//メモリ解放最終処理
//----------　----------//
- (void)dealloc {
    [narration release];
    
    [super dealloc];
}

@end