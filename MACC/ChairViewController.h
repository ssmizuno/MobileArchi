#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ChairViewController : UIViewController<UIActionSheetDelegate, UIScrollViewDelegate, UIAlertViewDelegate> {
    
    NSString *cTitle;
    NSString *cCont;
    NSString *imageSearch;
    NSString *wikiSearch;
    NSString *sUrl;
    
    AVAudioPlayer *narration;    
    UIToolbar *customToolbar;
    UIScrollView *scrollView;
	UIPageControl *pageControl;
}

@property(nonatomic,retain) NSString *cTitle;
@property(nonatomic,retain) NSString *cCont;
@property(nonatomic,retain) NSString *imageSearch;
@property(nonatomic,retain) NSString *wikiSearch;
@property(nonatomic,retain) NSString *sUrl;
@property(nonatomic,retain) AVAudioPlayer *narration;
@property(nonatomic,retain) UIToolbar *customToolbar;
@property(nonatomic,retain) UIScrollView *scrollView;
@property(nonatomic,retain) UIPageControl *pageControl;

- (void)initDataChairs:(NSString *)_cTitle name:(NSString *)_name imageSearch:(NSString *)_imageSearch wikiSearch:(NSString *)_wikiSearch sUrl:(NSString *)_sUrl isCameraUse:(BOOL)_isCameraUse;

@end
