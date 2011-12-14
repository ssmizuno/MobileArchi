//
//  MACCViewController.m
//  MACC
//
//  Created by 水野 真史 on 11/06/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MACCViewController.h"
#import "CONST.h"
#import "ChairViewController.h"

//----------　----------//
//定数
//----------　----------//
//画像
static NSString *Chair01 = @"eamesbt.png";
static NSString *Chair02 = @"mpbt.png";
static NSString *Chair03 = @"msbt.png";
static NSString *Chair04 = @"npbbt.png";
static NSString *Chair05 = @"nsgbt.png";
static NSString *Chair06 = @"acbt.png";

static NSString *Ctitle = @"";
static NSString *cCont = @"";
static NSString *imageSearch = @"";
static NSString *wikiSearch = @"";
static NSString *Surl = @"";

BOOL isCamera;


//----------クラスの実装----------//
@implementation MACCViewController

//----------プロパティの実装----------//
@synthesize backgroundScroll;
@synthesize backgroundImage;
@synthesize CB01;
@synthesize CB02;
@synthesize CB03;
@synthesize CB04;
@synthesize CB05;
@synthesize CB06;

//----------Viewの初期化----------//
//タブバーの画像などのセットを行う
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		self.title = @"ChairsCollection";
		self.view.backgroundColor = [UIColor blackColor];
        self.tabBarItem.image = [UIImage imageNamed:@"tabicon01.png"];
    }
    return self;
}

#pragma marl -
#pragma mark - View lifecycle


//----------ビュー読み込み時に呼ばれる----------//
 - (void)viewDidLoad {
     
     //親クラスの処理を呼び出す
     [super viewDidLoad];
     
     //----------背景画像----------//
     // 背景イメージの読み込み
     self.backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main.png"]];
     // 背景イメージの場所とサイズ指定
     self.backgroundImage.frame = CGRectMake(0.0, -44.0, self.view.frame.size.width, self.view.frame.size.height);
     
     //スクロール用Viewの設定
     self.backgroundScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 95.0, self.view.bounds.size.width, self.view.bounds.size.height-100.0)];
     self.backgroundScroll.pagingEnabled = NO;
     self.backgroundScroll.contentSize = CGSizeMake(self.view.frame.size.width, Bt_magin*4);
     self.backgroundScroll.showsHorizontalScrollIndicator = NO;
     self.backgroundScroll.showsVerticalScrollIndicator = YES;
     self.backgroundScroll.scrollsToTop = YES;
     self.backgroundScroll.backgroundColor = [UIColor clearColor];
     
     //背景イメージの表示
     [self.view addSubview:backgroundImage];
     //背景スクロールビューの表示
     [self.view addSubview:backgroundScroll];
     //開放
     [backgroundImage release];
     [backgroundScroll release];
     
     //----------ボタン設定----------//
     //Chair01
     self.CB01 = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
     self.CB01.frame = CGRectMake(0.0, 0.0, Bt_width, Bt_height);
     [self.CB01 setImage:[UIImage imageNamed:Chair01] forState:UIControlStateNormal];
     self.CB01.backgroundColor = [UIColor clearColor];
     self.CB01.reversesTitleShadowWhenHighlighted = YES;
     self.CB01.tag = 1;
     [self.CB01 addTarget:self action:@selector(goChairPage:) forControlEvents:UIControlEventTouchUpInside];
     [self.backgroundScroll addSubview:CB01];
     self.CB01.alpha = 0.0;
     [CB01 release];
        
     //Chair02
     self.CB02 = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
     self.CB02.frame = CGRectMake(0.0, Bt_magin, Bt_width, Bt_height);
     [self.CB02 setImage:[UIImage imageNamed:Chair02] forState:UIControlStateNormal];
     self.CB02.backgroundColor = [UIColor clearColor];
     self.CB02.reversesTitleShadowWhenHighlighted = YES;
     self.CB02.tag = 2;
     [self.CB02 addTarget:self action:@selector(goChairPage:) forControlEvents:UIControlEventTouchUpInside];
     [self.backgroundScroll addSubview:CB02];    
     self.CB02.alpha = 0.0;    
     [CB02 release];
     
     //Chair03
     self.CB03 = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
     self.CB03.frame = CGRectMake(0.0, Bt_magin*2, Bt_width, Bt_height);
     [self.CB03 setImage:[UIImage imageNamed:Chair03] forState:UIControlStateNormal];
     self.CB03.backgroundColor = [UIColor clearColor];
     self.CB03.reversesTitleShadowWhenHighlighted = YES;
     self.CB03.tag = 3;
     [self.CB03 addTarget:self action:@selector(goChairPage:) forControlEvents:UIControlEventTouchUpInside];
     [self.backgroundScroll addSubview:CB03];
     self.CB03.alpha = 0.0;
     [CB03 release];
     
     //Chair04
     self.CB04 = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
     self.CB04.frame = CGRectMake(163.0, 0.0, Bt_width, Bt_height);
     [self.CB04 setImage:[UIImage imageNamed:Chair04] forState:UIControlStateNormal];
     self.CB04.backgroundColor = [UIColor clearColor];
     self.CB04.reversesTitleShadowWhenHighlighted = YES;
     self.CB04.tag = 4;
     [self.CB04 addTarget:self action:@selector(goChairPage:) forControlEvents:UIControlEventTouchUpInside];
     [self.backgroundScroll addSubview:CB04];
     self.CB04.alpha = 0.0;
     [CB04 release];
     
     //Chair05
     self.CB05 = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
     self.CB05.frame = CGRectMake(163.0, Bt_magin, Bt_width, Bt_height);
     [self.CB05 setImage:[UIImage imageNamed:Chair05] forState:UIControlStateNormal];
     self.CB05.backgroundColor = [UIColor clearColor];
     self.CB05.reversesTitleShadowWhenHighlighted = YES;
     self.CB05.tag = 5;
     [self.CB05 addTarget:self action:@selector(goChairPage:) forControlEvents:UIControlEventTouchUpInside];
     [self.backgroundScroll addSubview:CB05];
     self.CB05.alpha = 0.0;    
     [CB05 release];
     
     //Chair06
     self.CB06 = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
     self.CB06.frame = CGRectMake(163.0, Bt_magin*2, Bt_width, Bt_height);
     [self.CB06 setImage:[UIImage imageNamed:Chair06] forState:UIControlStateNormal];
     self.CB06.backgroundColor = [UIColor clearColor];
     self.CB06.reversesTitleShadowWhenHighlighted = YES;
     self.CB06.tag = 6;
     [self.CB06 addTarget:self action:@selector(goChairPage:) forControlEvents:UIControlEventTouchUpInside];
     [self.backgroundScroll addSubview:CB06];
     self.CB06.alpha = 0.0;
     [CB06 release];
     
     //ボタンフェードインの実行
     [self setImageViewButton];
     
     
 }

#pragma mark -
#pragma mark action

//----------　----------//
//ページ遷移ボタンアクション
//----------　----------//
-(void)goChairPage:(id)sender{
    ChairViewController *nextView = [[[ChairViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    nextView.hidesBottomBarWhenPushed = YES;
    switch ([sender tag]) {
        case 1: {
            Ctitle = @"Lounge Chair and Ottoman";
            cCont = @"eames";
            imageSearch = @"http://www.google.co.jp/m/search?site=images&source=mog&hl=en&gl=jp&client=safari&q=charles%20and%20ray%20eames&sa=N";
            wikiSearch = @"http://ja.m.wikipedia.org/wiki/%E3%83%81%E3%83%A3%E3%83%BC%E3%83%AB%E3%82%BA%E3%83%BB%E3%82%A4%E3%83%BC%E3%83%A0%E3%82%BA";
            Surl = @"http://www.ss-maple.co.jp/ma_resources/sound/eames.mp3";
            isCamera = YES;
        }
            break;
        case 2: {
            Ctitle = @"Molded Playwood Chairs";
            cCont = @"mp";
            imageSearch = @"http://www.google.co.jp/m/search?site=images&gl=jp&client=safari&source=mog&hl=ja&q=Eames+Molded+Plywood+Chairs&spell=1&ei=OBtmTsm4D8eTkQX8lY3bAw&ved=0CBIQvwUoAA";
            wikiSearch = @"http://ja.m.wikipedia.org/wiki/%E3%83%81%E3%83%A3%E3%83%BC%E3%83%AB%E3%82%BA%E3%83%BB%E3%82%A4%E3%83%BC%E3%83%A0%E3%82%BA";
            Surl = @"http://www.ss-maple.co.jp/ma_resources/sound/mp.mp3";
            isCamera = NO;
        }
            break;
        case 3: {
            Ctitle = @"Marshmallow Sofa";
            cCont = @"ms";
            imageSearch = @"http://www.google.co.jp/m/search?site=images&gl=jp&source=mog&hl=ja&q=lc1";
            wikiSearch = @"http://ja.wikipedia.org/wiki/%E3%82%B3%E3%83%AB%E3%83%93%E3%83%A5%E3%82%B8%E3%82%A7";
            Surl = @"http://www.ss-maple.co.jp/ma_resources/sound/ms.mp3";
            isCamera = NO;           	
        }
            break;
        case 4: {
            Ctitle = @"Nelson Platform Bench";
            cCont = @"npb";
            imageSearch = @"http://www.google.co.jp/m/search?site=images&gl=jp&source=mog&client=safari&hl=ja&q=Nelson+Platform+Bench";
            wikiSearch = @"http://ja.m.wikipedia.org/wiki/%E3%82%B8%E3%83%A7%E3%83%BC%E3%82%B8%E3%83%BB%E3%83%8D%E3%83%AB%E3%82%BD%E3%83%B3";
            Surl = @"http://www.ss-maple.co.jp/ma_resources/sound/npb.mp3";
            isCamera = NO;
        }
            break;
        case 5: {
            Ctitle = @"Nelson Swag Leg Group";
            cCont = @"nsg";
            imageSearch = @"http://www.google.co.jp/m/search?site=images&gl=jp&source=mog&client=safari&hl=ja&q=Nelson+Swag+Leg+Group";
            wikiSearch = @"http://ja.m.wikipedia.org/wiki/%E3%82%B8%E3%83%A7%E3%83%BC%E3%82%B8%E3%83%BB%E3%83%8D%E3%83%AB%E3%82%BD%E3%83%B3";
            Surl = @"http://www.ss-maple.co.jp/ma_resources/sound/nsg.mp3";
            isCamera = NO;
        }
            break;
        case 6: {
            Ctitle = @"Aeron Chairs";
            cCont = @"ac";
            imageSearch = @"http://www.google.co.jp/m/search?site=images&gl=jp&source=mog&client=safari&hl=ja&q=Aeron+Chairs";
            wikiSearch = @"http://ja.m.wikipedia.org/wiki/%E3%82%A2%E3%83%BC%E3%83%AD%E3%83%B3%E3%83%81%E3%82%A7%E3%82%A2";
            Surl = @"http://www.ss-maple.co.jp/ma_resources/sound/ac.mp3";
            isCamera = NO;
        }
            break;
    }
    [nextView initDataChairs:Ctitle name:cCont imageSearch:imageSearch wikiSearch:wikiSearch sUrl:Surl isCameraUse:isCamera];
    [self.navigationController pushViewController:nextView animated:YES];		
}

//空action
- (void)emptyAction:(id)sender {
    
}

//----------ボタンアニメーション----------//
- (void)setImageViewButton{
	
	// アニメーションの設定
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];	// 変化にリズムを付ける（イーズイン・イーズアウト）
	[UIView setAnimationDuration:2.0];	
    [self.CB01 setAlpha:1.0];
    [self.CB02 setAlpha:1.0];
	[self.CB03 setAlpha:1.0];
    [self.CB04 setAlpha:1.0];
    [self.CB05 setAlpha:1.0];
    [self.CB06 setAlpha:1.0];
    
    // アニメーションの実行
	[UIView commitAnimations];
}

//----------メモリ不足時に呼ばれる----------//
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
 

//----------ビュー読み込み終了時に呼ばれる----------//
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.backgroundScroll = nil;
    self.backgroundImage = nil;
    self.CB01 = nil;
    self.CB02 = nil;
    self.CB03 = nil;
    self.CB04 = nil;
    self.CB05 = nil;
    self.CB06 = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    
    [backgroundScroll release];
    [backgroundImage release];
    
    [CB01 release];
    [CB02 release];
    [CB03 release];
    [CB04 release];
    [CB05 release];
    [CB06 release];
    [super dealloc];
}

@end
