//
//  ConfirmViewController.h
//  MACC
//
//  Created by 水野 真史 on 11/06/30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ConfirmViewController : UIViewController {
    
    UIImageView *bgimg;
    UIImage *saveImage;
    UIActivityIndicatorView *indicator;
    
}

@property (nonatomic,retain) UIImage *saveImage;
@property (nonatomic,retain) UIImageView *bgimg;

@end
