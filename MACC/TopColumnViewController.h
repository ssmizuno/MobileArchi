//
//  TopColumnViewController.h
//  MACC
//
//  Created by 水野 真史 on 11/06/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface TopColumnViewController : UIViewController<UIActionSheetDelegate, UIScrollViewDelegate, UIAlertViewDelegate> {
    
    AVAudioPlayer *narration;    
    UIToolbar *customToolbar;
    UIScrollView *scrollView;
	UIPageControl *pageControl;
    BOOL isNarration;
    
}

@property(nonatomic,retain) AVAudioPlayer *narration;
@property(nonatomic,retain) UIToolbar *customToolbar;
@property(nonatomic,retain) UIScrollView *scrollView;
@property(nonatomic,retain) UIPageControl *pageControl;
@end
