//
//  EventViewController.h
//  MACC
//
//  Created by 水野 真史 on 11/11/18.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventViewController : UIViewController <UIScrollViewDelegate> {
    UIImageView *mainView;
    NSMutableArray *imagesArray;
    NSInteger imageIndex;
}

@property (nonatomic, retain) UIImageView *mainView;
@property (nonatomic, retain) NSMutableArray *imagesArray;

@end
