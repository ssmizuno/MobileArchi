//
//  ConfirmViewController.m
//  MACC
//
//  Created by 水野 真史 on 11/06/30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConfirmViewController.h"


@implementation ConfirmViewController

@synthesize saveImage, bgimg;

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


 //----------ビューが読み込まれたときに呼ばれる----------//
 - (void)viewDidLoad
 {
 [super viewDidLoad];
     
     //----------背景画像の設定----------//
     self.bgimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cameraBgImage.png"]];
     self.bgimg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
     [self.view addSubview:bgimg];     
                   
     //----------ボタン設定（戻る）----------//
     UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     //ボタンサイズ
     [backBtn setFrame:CGRectMake(10, 413, 62, 44)];
     //ボタン文字
     [backBtn setImage:[UIImage imageNamed:@"returnbt.png"] forState:UIControlStateNormal];
     //ボタンaction
     [backBtn addTarget:self action:@selector(backToMain:) forControlEvents:UIControlEventTouchUpInside];
     //ボタン配置
     [self.view addSubview:backBtn];
     
     //----------ボタン設定（戻る）----------//
     UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     //ボタンサイズ
     [saveBtn setFrame:CGRectMake(250, 413, 62, 44)];
     //ボタン文字
     [saveBtn setImage:[UIImage imageNamed:@"savebt.png"] forState:UIControlStateNormal];
     //ボタンaction
     [saveBtn addTarget:self action:@selector(savePic:) forControlEvents:UIControlEventTouchUpInside];
     //ボタン配置
     [self.view addSubview:saveBtn];     
     
     UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 410)];
     imageView.image = saveImage;
     [self.view addSubview:imageView];
     [imageView release];
     
}

//----------戻るボタンのaction----------//
- (void)backToMain:(id)sender {
    [self dismissModalViewControllerAnimated:NO];
}

//----------保存ボタンのaction----------//
-(void)savePic:(id)sender
{
	indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
	indicator.center = self.view.center;
	[self.view addSubview:indicator];
	[indicator startAnimating];
	
	// savePhotoを画像ライブラリに保存する
	UIImageWriteToSavedPhotosAlbum(saveImage, 
								   self,
								   @selector(calledWhenSavingImageIsFinished:didFinishSavingWithError:contextInfo:), 
								   nil);
}

- (void) calledWhenSavingImageIsFinished:(UIImage *)_image 
				didFinishSavingWithError:(NSError *)_error
							 contextInfo:(void *)_contextInfo
{
	[indicator stopAnimating];
	[indicator removeFromSuperview];
	
	[self dismissModalViewControllerAnimated:NO];
}

//----------ビューがアンロードされたときに呼ばれる----------//
- (void)viewDidUnload
{
    [super viewDidUnload];
}

//----------ローテーションの対応----------//
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



//----------メモリ不足時に呼ばれる----------//
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


//----------解放処理----------//
- (void)dealloc
{
    [bgimg release];
    [indicator release];
    [saveImage release];
    [super dealloc];
}

@end
