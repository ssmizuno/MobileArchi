//
//  EventViewController.m
//  MACC
//
//  Created by 水野 真史 on 11/11/18.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EventViewController.h"
#import "MapViewController.h"
#import "OpenWebAlert.h"

@implementation EventViewController

@synthesize mainView, imagesArray;

//-------------------------------------------------------
//初期化
//-------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        //背景パターンの生成
		self.title = @"Architect Event";
        UIColor *tile = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg_pattern.jpg"]];
        self.view.backgroundColor = tile;
        self.tabBarItem.image = [UIImage imageNamed:@"tabicon04.png"];
        
        
    }
    return self;
}

#pragma mark - View lifecycle


//-------------------------------------------------------
//Viewがロードされたときに呼ばれる
//-------------------------------------------------------
- (void)loadView {
    [super loadView];
    //背景ScrollView
    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-88)];
    bgScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2+100);
    bgScrollView.backgroundColor = [UIColor clearColor];
    bgScrollView.delegate = self;
    bgScrollView.bounces = YES;
    [self.view addSubview:bgScrollView]; 
    [bgScrollView release];
    
    //画像の配列
    imageIndex = 0;
    imagesArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"event_images01.jpg"], [UIImage imageNamed:@"event_images02.jpg"], [UIImage imageNamed:@"event_images03.jpg"], nil];
    
    //コンテンツ（仮）
    self.mainView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 55, self.view.frame.size.width, 406.0)];
    self.mainView.image = [imagesArray objectAtIndex:0];
    self.mainView.backgroundColor = [UIColor grayColor];
    [bgScrollView addSubview:self.mainView];
    [self.mainView release];
    [NSTimer scheduledTimerWithTimeInterval:5.0
                                     target:self
                                   selector:@selector(onTimer:)
                                   userInfo:nil
                                    repeats:YES];
    
    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 55)];
    headView.image = [UIImage imageNamed:@"event_head.png"];
    [bgScrollView addSubview:headView];
    [headView release];
    
    //タイトルの作成
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(5, 460, 310, 44)];
    title.text = @"日時：2011年12月17日（土）・18日（日）";
    title.numberOfLines = 0;
    title.textAlignment = UITextAlignmentCenter;
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
    title.textColor = [UIColor blackColor];
    title.backgroundColor = [UIColor clearColor];
    title.shadowColor = [UIColor whiteColor];
    title.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [bgScrollView addSubview:title];
    [title release];
    
    //説明文
    UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(5, 510, 310, 9999)];
    NSString *textPath = [[NSBundle mainBundle] pathForResource:@"event_text" ofType:@"txt"];
    NSString *text = [NSString stringWithContentsOfFile:textPath encoding:NSUTF8StringEncoding error:nil];
    textview.text = text;
    textview.font = [UIFont systemFontOfSize:14.0];
    textview.editable = NO;
    textview.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:textview];
    [textview release];
    
    //button
    UIButton *footView = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    footView.frame = CGRectMake(0, bgScrollView.contentSize.height-60, self.view.frame.size.width, 55);
    [footView setImage:[UIImage imageNamed:@"event_foot.png"] forState:UIControlStateNormal];
    footView.backgroundColor = [UIColor clearColor];
    footView.reversesTitleShadowWhenHighlighted = YES;
    [footView addTarget:self action:@selector(webJump:) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:footView];
    [footView release];
    
    //button    
    UIButton *mapButton_h = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    mapButton_h.frame = CGRectMake(self.view.frame.size.width-100, 560, 91, 33);
    [mapButton_h setImage:[UIImage imageNamed:@"mapButton.png"] forState:UIControlStateNormal];
    mapButton_h.backgroundColor = [UIColor clearColor];
    mapButton_h.reversesTitleShadowWhenHighlighted = YES;
    [mapButton_h addTarget:self action:@selector(mapaction:) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:mapButton_h];
    [mapButton_h release];
      
    //button    
    UIButton *mapButton_f = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    mapButton_f.frame = CGRectMake(self.view.frame.size.width-100, bgScrollView.contentSize.height-110, 91, 33);
    [mapButton_f setImage:[UIImage imageNamed:@"mapButton.png"] forState:UIControlStateNormal];
    mapButton_f.backgroundColor = [UIColor clearColor];
    mapButton_f.reversesTitleShadowWhenHighlighted = YES;
    [mapButton_f addTarget:self action:@selector(mapaction:) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:mapButton_f];
    [mapButton_f release];
    
    //button    
    UIButton *telButton_f = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    telButton_f.frame = CGRectMake(self.view.frame.size.width-205, bgScrollView.contentSize.height-110, 91, 33);
    [telButton_f setImage:[UIImage imageNamed:@"telButton.png"] forState:UIControlStateNormal];
    telButton_f.backgroundColor = [UIColor clearColor];
    telButton_f.reversesTitleShadowWhenHighlighted = YES;
    [telButton_f addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:telButton_f];
    [telButton_f release];
    
    //button    
    UIButton *mailButton_f = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    mailButton_f.frame = CGRectMake(self.view.frame.size.width-310, bgScrollView.contentSize.height-110, 91, 33);
    [mailButton_f setImage:[UIImage imageNamed:@"mailButton.png"] forState:UIControlStateNormal];
    mailButton_f.backgroundColor = [UIColor clearColor];
    mailButton_f.reversesTitleShadowWhenHighlighted = YES;
    [mailButton_f addTarget:self action:@selector(mailAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:mailButton_f];
    [mailButton_f release];
    
    //注意書き
    UILabel *aside = [[UILabel alloc] initWithFrame:CGRectMake(5, bgScrollView.contentSize.height-150, 310, 44)];
    aside.text = @"ご見学をご希望の方は\nメールまたは、電話にてお問い合わせください。";
    aside.numberOfLines = 0;
    aside.textAlignment = UITextAlignmentLeft;
    aside.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12.0];
    aside.textColor = [UIColor redColor];
    aside.backgroundColor = [UIColor clearColor];
    aside.shadowColor = [UIColor whiteColor];
    aside.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [bgScrollView addSubview:aside];
    [aside release];
    
    //注意書き
    UILabel *mapaside = [[UILabel alloc] initWithFrame:CGRectMake(5, bgScrollView.contentSize.height-88, 310, 44)];
    mapaside.text = @"地図は最寄り駅までのご案内となります。";
    mapaside.numberOfLines = 0;
    mapaside.textAlignment = UITextAlignmentRight;
    mapaside.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:10.0];
    mapaside.textColor = [UIColor blackColor];
    mapaside.backgroundColor = [UIColor clearColor];
    mapaside.shadowColor = [UIColor whiteColor];
    mapaside.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [bgScrollView addSubview:mapaside];
    [mapaside release];
}

//-------------------------------------------------------
//地図画面起動アクション
//-------------------------------------------------------
- (void)mapaction:(id)sender {
    MapViewController *mapViewController = [[MapViewController alloc] initWithNibName:nil bundle:nil];
    mapViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:mapViewController animated:YES];    
}


//----------タイマーメソッド----------//
- (void)onTimer:(NSTimer *)timer {
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:3.0];
    mainView.alpha = 0.3;
    imageIndex = (++imageIndex)%[imagesArray count];
    NSLog(@"画像No.%d", imageIndex);
    mainView.image = [imagesArray objectAtIndex:imageIndex];
    mainView.alpha = 1.0;
    /*
    switch (imageIndex) {
        case 0: {
            imageIndex = 1;
        } break;
        case 1: {
            imageIndex = 0;            
        } break;
    }
     */
    
    [UIView commitAnimations];
    
}


- (void)webJump:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Webサイト"
                                                    message:@"Safariを起動します"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil];
    alert.tag = 1;
	[alert show];
	[alert release];
}

- (void)callAction:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"電話で問い合わせ"
                                                    message:@"発信します"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil];
    alert.tag = 2;
	[alert show];
	[alert release];
}

- (void)mailAction:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"メールで問い合わせ"
                                                    message:@"メーラーが起動します"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil];
    alert.tag = 3;
	[alert show];
	[alert release];
}

//-------------------------------------------------------
//アラートの挙動
//-------------------------------------------------------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (alertView.tag) {
        //safariアクセス
        case 1: {
            switch (buttonIndex) {
                case 0: {
                    //Cancel
                    break;
                }
                case 1: {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.project1000.co.jp/"]];
                    break;
                }
            }
        }
        //TEL
        case 2: {
            switch (buttonIndex) {
                case 0: {
                    //Cancel
                    break;
                }
                case 1: {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:03-6439-5540"]];
                    break;
                }
            }
        }
        //safariアクセス
        case 3: {
            switch (buttonIndex) {
                case 0: {
                    //Cancel
                    break;
                }
                case 1: {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:info@tekuto.com"]];
                    break;
                }
            }
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.mainView = nil;
    self.imagesArray = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [mainView release];
    [imagesArray release];
    [super dealloc];
}


@end
