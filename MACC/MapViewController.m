//
//  MapViewController.m
//  MACC
//
//  Created by 水野 真史 on 11/11/21.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "CustomAnnotation.h"

static CGFloat tLat = 35.607577;
static CGFloat tLng = 139.669094;

@implementation MapViewController

@synthesize tb, mapView, locationManager, currentLocation;

//-------------------------------------------------------
//初期化処理
//-------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //背景パターン作成
        UIColor *tile = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg_pattern.jpg"]];
        self.view.backgroundColor = tile;
    }
    return self;
}

#pragma mark - View lifecycle

//-------------------------------------------------------
//位置情報が更新されたときによばれる
//-------------------------------------------------------
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    //緯度・経度を出力    
    NSLog(@"didupdateLocation latitude=%f, longitude=%f", 
          [newLocation coordinate].latitude, 
          [newLocation coordinate].longitude);
    
    //現在地の位置情報をインスタンスに設定
    cLat = [newLocation coordinate].latitude;
    clng = [newLocation coordinate].longitude;
    
    //地図の表示設定
    MKCoordinateRegion region = MKCoordinateRegionMake([newLocation coordinate], MKCoordinateSpanMake(1.5, 1.5));
    [mapView setCenterCoordinate:[newLocation coordinate]];
    [mapView setRegion:region];
}

//-------------------------------------------------------
//viewをロードしたときによばれる
//-------------------------------------------------------
- (void)loadView {
    [super loadView];
    //ツールバーの生成
    self.tb = [[[UIToolbar alloc] init] autorelease];
    self.tb.barStyle = UIBarStyleBlackTranslucent;
    self.tb.frame = CGRectMake(0, 0, 320, 44);
    
    //-- OK、Doneボタンの設定 ------------------------//
    UIBarButtonItem *defaultItem = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                    target:self action:@selector(done:)];
    //ボタンアイテムを配列に入れる
    NSArray *barItems = [NSArray arrayWithObjects:defaultItem, nil];
    self.tb.items = barItems;    
    [self.view addSubview:self.tb];
    
    //MapViewの生成
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:mapView];
    
    //mapViewをデリゲートに設定
    [mapView setDelegate:self];

}

- (void)viewWillAppear:(BOOL)animated {
    //位置情報取得系設定
    locationManager = [[CLLocationManager alloc] init];
    
    //位置情報サービスが利用できるかどうかチェック
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager.delegate = self;
        //測定開始
        [locationManager startUpdatingLocation];
    } else {
        NSLog(@"Location service not available.");
    }
    
    //現在地に青い点を付ける
    mapView.showsUserLocation = YES;
    
    //位置情報取得一時停止
    [self onPause];
}

//ビューが読み込み完了した際に呼ばれる。（アノテーションドロップ）
- (void)viewDidAppear:(BOOL)animated {
    //アノテーションの追加
    [mapView addAnnotation:[[[CustomAnnotation alloc] initWithLocationCoordinate:CLLocationCoordinate2DMake(tLat, tLng) title:@"開催地" subtitle:@""] autorelease]];
}

//-------------------------------------------------------
//アノテーションの設定
//-------------------------------------------------------
- (MKAnnotationView*)mapView:(MKMapView*)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    //もしアノテーションが現在地と同じであればnilを返す
	if (annotation == self.mapView.userLocation) {
		return nil;
	}
    
    //アノテーションのインスタンスを作成
	MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"test"];
    //ピンのColor
	[annotationView setPinColor:MKPinAnnotationColorPurple];
    //コールアウトの有無
	[annotationView setCanShowCallout:YES];
    //落ちるアニメーションの設定
	[annotationView setAnimatesDrop:YES];
	
    //コールアウトのボタン作成
    UIButton* button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [annotationView setRightCalloutAccessoryView:button];
    [button addTarget:self action:@selector(MapRoot:) forControlEvents:UIControlEventTouchUpInside];
    
	annotationView.annotation = annotation;
    
	return annotationView;
}
//-------------------------------------------------------
//modalビューを閉じる
//-------------------------------------------------------
- (void)done:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

//-------------------------------------------------------
//アラート（標準地図アプリにて経路表示）
//-------------------------------------------------------
- (void)MapRoot:(id)sender
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"経路表示"
                                                    message:@"現在地からの経路を表示します。"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}

//-------------------------------------------------------
//アラートの挙動
//-------------------------------------------------------
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
		case 0: {
            //Cancel
			break;
		}
		case 1: {
                NSString* url;                
                url = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f",tLat, tLng, cLat, clng];
                NSLog(@"url:%@", url);
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            }
			break;
		}
}

//-------------------------------------------------------
//位置情報測定停止メソッド
//-------------------------------------------------------
- (void)onPause {
    if (nil == locationManager && [CLLocationManager locationServicesEnabled]) {
        //測定停止
        [locationManager stopUpdatingLocation];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.tb = nil;
    self.mapView = nil;    
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
    [tb release];
    [mapView release];
    
    [super dealloc];
}

@end
