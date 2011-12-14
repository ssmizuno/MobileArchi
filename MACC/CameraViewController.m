//
//  CameraViewController.m
//  MACC
//
//  Created by 水野 真史 on 11/06/30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CameraViewController.h"
#import "ConfirmViewController.h"
#import "ChairViewController.h"

@implementation CameraViewController

@synthesize imagePicker, overImageView, imageNameSmall, imageNameBig, indicator, saveImage, bgimg, imgname;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//----------　----------//
#pragma mark - View lifecycle
//----------　----------//

//----------ビューが読み込まれたときに呼び出される----------//
- (void)loadView
{
    [super loadView];

    NSLog(@"%@", imgname);
    
    //----------背景画像の設定----------//
    self.bgimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cameraBgImage.png"]];
    self.bgimg.frame = CGRectMake(0, 400, self.view.frame.size.width, 80);
    [self.view addSubview:bgimg];
    
    
    //----------ボタン設定（戻る）----------//
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //ボタンサイズ
    [backBtn setFrame:CGRectMake(10, 405, 62, 44)];
    //ボタン文字
    [backBtn setImage:[UIImage imageNamed:@"returnbt.png"] forState:UIControlStateNormal];
    //ボタンaction
    [backBtn addTarget:self action:@selector(backToMain:) forControlEvents:UIControlEventTouchUpInside];
    //ボタン配置
    [self.view addSubview:backBtn];
    
    //----------ボタン設定（撮影）----------//
    UIButton *takeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //ボタンサイズ
    [takeBtn setFrame:CGRectMake(93, 405, 132, 44)];
    //ボタン文字
    [takeBtn setImage:[UIImage imageNamed:@"camerabt.png"] forState:UIControlStateNormal];
    //ボタンaction
    [takeBtn addTarget:self action:@selector(takePic:) forControlEvents:UIControlEventTouchUpInside];
    //ボタン配置
    [self.view addSubview:takeBtn];
    
    
    //----------ボタン設定（change）----------//
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //ボタンサイズ
    [changeBtn setFrame:CGRectMake(250, 405, 62, 44)];
    //ボタン文字
    [changeBtn setImage:[UIImage imageNamed:@"plusbt.png"] forState:UIControlStateNormal];
    //ボタンaction
    [changeBtn addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
    //ボタン配置
    [self.view addSubview:changeBtn];
    
    //----------オーバーレイ画像用の配列----------//
    
    //初期化
    imageIndex = 0;
    //プレビュー用画像配列
    imageNameSmall = [[NSMutableArray alloc] initWithObjects:[imgname stringByAppendingFormat:@"Small01.png"], [imgname stringByAppendingFormat:@"Small02.png"], [imgname stringByAppendingFormat:@"Small03.png"], nil];
    //保存用画像配列
    imageNameBig = [[NSMutableArray alloc] initWithObjects:[imgname stringByAppendingFormat:@"Big01.png"], [imgname stringByAppendingFormat:@"Big02.png"], [imgname stringByAppendingFormat:@"Big03.png"], nil];
    
    
    //----------カメラオーバーレイ画像の設定----------//
    overImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
    overImageView.image = [UIImage imageNamed:[imageNameSmall objectAtIndex:imageIndex]];
    [self.view addSubview:overImageView];
    
    //----------カメラの設定----------//
    //初期化
    imagePicker = [[UIImagePickerController alloc] init];
    //カメラタイプの選択（今回はカメラ起動）
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //カメラコントロールバー飛翔時
    imagePicker.showsCameraControls = NO;
    //オーバーレイの有無
    imagePicker.cameraOverlayView = self.view;
    //撮った写真を編集するかどうか
    imagePicker.allowsEditing = YES;
    //デリゲートの指定
    imagePicker.delegate = self;
    //カメラ使用可能かどうか
    isCameraReady = YES;
    
    //----------撮影プレビューインスタンスの設定----------//
    saveImage = [[UIImage alloc] init];
    saveImage = nil; 
    
}

//----------ビューをすべて描画し終わったら呼ばれる----------//
- (void)viewDidAppear:(BOOL)animated {
    
    //もしプレビューに画像が格納されていれば編集画面へ
    if (saveImage != nil) {
        [overImageView removeFromSuperview];
        [self showConfirm];
        //カメラ使用可能であればカメラ表示
    } else if (isCameraReady == YES) {
        [self presentModalViewController:imagePicker animated:YES];
        [self.view addSubview:overImageView];
    }
}

//----------ビューアンロード時に呼ばれる----------//
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//----------ローテーションの有無----------//
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


//----------戻るボタンのaction----------//
- (void)backToMain:(id)sender {
    //カメラ使用可能フラグオフ
    isCameraReady = NO;
    //モーダルビューの閉じる
    [self dismissModalViewControllerAnimated:NO];
    [self dismissModalViewControllerAnimated:YES];
}

//----------撮影ボタンのaction----------//
- (void)takePic:(id)sender {
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator startAnimating];
    
    [imagePicker takePicture];
    
}

//----------changeボタンのaction----------//
- (void)changeImage:(id)sender {
    imageIndex = (++imageIndex)%[imageNameSmall count];
    overImageView.image = [UIImage imageNamed:[imageNameSmall objectAtIndex:imageIndex]];
}

//----------イメージを表示する----------//
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //ライブラリの写真
    UIImage *re_tmp = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGSize size = re_tmp.size;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    //縦向き（底が上にある）
    if (orientation == UIDeviceOrientationPortraitUpsideDown) {
        transform = CGAffineTransformTranslate(transform, size.width, size.height);
        transform = CGAffineTransformRotate(transform, M_PI);
    }
    //横向き（右が上にある場合）
    else if (orientation == UIDeviceOrientationLandscapeRight) {
        size = CGSizeMake(size.height, size.width);
        transform = CGAffineTransformTranslate(transform, 0.0, size.height);
        transform = CGAffineTransformRotate(transform, -M_PI / 2.0);
    }
    //横向き（左が上にある場合）
    else if (orientation == UIDeviceOrientationLandscapeLeft) {
        size = CGSizeMake(size.height, size.width);
        transform = CGAffineTransformTranslate(transform, 0.0, size.height);
        transform = CGAffineTransformRotate(transform, M_PI / 2.0);
    }
    
    //カメラ写真を回転する
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context, transform);
    [re_tmp drawInRect:rect];
    
    UIImage *tmp2 = [[UIImage alloc] initWithCGImage:[UIGraphicsGetImageFromCurrentImageContext() CGImage]];
    UIGraphicsEndImageContext();
    
    //合成する
    size = tmp2.size;
    rect = CGRectMake(0, 0, size.width, size.height);
    
    UIImage *overImg = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[imageNameBig objectAtIndex:imageIndex] ofType:nil]];
    UIGraphicsBeginImageContext(size);
    [tmp2 drawInRect:rect];
    [tmp2 release];
    [overImg drawInRect:rect];
    [overImg release];
    [saveImage release];
    saveImage = [[UIImage alloc] initWithCGImage:[UIGraphicsGetImageFromCurrentImageContext() CGImage]];
    UIGraphicsEndImageContext();
    
    //インジケーターをストップ
    [indicator stopAnimating];
    //インジケーターを消去
    [indicator removeFromSuperview];
    //モーダルビューを表示
    [self dismissModalViewControllerAnimated:NO];
    
}

//----------カメラキャンセル時に呼ばれる----------//
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
}

//----------保存確認画面----------//
-(void)showConfirm {
    ConfirmViewController *confirmViewController = [[ConfirmViewController alloc] initWithNibName:nil bundle:nil];
    confirmViewController.saveImage = saveImage;
    [self presentModalViewController:confirmViewController animated:NO];
    [saveImage release];
    saveImage = [[UIImage alloc] init];
    saveImage = nil;
    
}

//----------メモリ不足時に呼ばれる----------//
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


//----------解放処理----------//
- (void)dealloc {
    [bgimg release];
    [saveImage release];
    [indicator release];
    [overImageView release];
    [imagePicker release];
    
    [super dealloc];
}

@end
