//
//  hillCameraViewController.h
//  MACC
//
//  Created by 水野 真史 on 11/07/07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//----------インターフェイス宣言----------//
@interface hillCameraViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate, UIActionSheetDelegate> {
    
    //----------インスタンス変数の宣言----------//
    UIImageView *bgimg;
    UIImagePickerController *imagePicker;
    UIImageView *overImageView;
    NSMutableArray *imageNameSmall;
    NSMutableArray *imageNameBig;
    NSInteger imageIndex;
    
    UIActivityIndicatorView *indicator;
    
    BOOL isCameraReady;
    
    UIImage *saveImage;
    
}

//----------プロパティの宣言----------//
@property (nonatomic,retain) UIImageView *bgimg;
@property (nonatomic,retain) UIImagePickerController *imagePicker;
@property (nonatomic,retain) UIImageView *overImageView;
@property (nonatomic,retain) NSMutableArray *imageNameSmall;
@property (nonatomic,retain) NSMutableArray *imageNameBig;;
@property (nonatomic,retain) UIActivityIndicatorView *indicator;
@property (nonatomic,retain) UIImage *saveImage;

- (void)showConfirm;

@end