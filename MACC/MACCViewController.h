//
//  MACCViewController.h
//  MACC
//
//  Created by 水野 真史 on 11/06/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//----------クラスの宣言----------//
@interface MACCViewController : UIViewController<UIScrollViewDelegate> {
    
    //----------インスタンス変数の宣言----------//
    //背景関係
    UIScrollView *backgroundScroll;
    UIImageView *backgroundImage;
    
    //ボタン関係
    UIButton *CB01;
    UIButton *CB02;
    UIButton *CB03;
    UIButton *CB04;
    UIButton *CB05;
    UIButton *CB06;
    
}

//プロパティの宣言
@property(nonatomic,retain) UIScrollView *backgroundScroll;
@property(nonatomic,retain) UIImageView *backgroundImage;

@property(nonatomic,retain) UIButton *CB01;
@property(nonatomic,retain) UIButton *CB02;
@property(nonatomic,retain) UIButton *CB03;
@property(nonatomic,retain) UIButton *CB04;
@property(nonatomic,retain) UIButton *CB05;
@property(nonatomic,retain) UIButton *CB06;

//メソッドの宣言
- (void)setImageViewButton;

@end
