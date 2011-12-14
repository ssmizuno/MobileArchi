//
//  MapViewController.h
//  MACC
//
//  Created by 水野 真史 on 11/11/21.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate, UIAlertViewDelegate> {
    UIToolbar *tb;
    //位置情報取得用
    CLLocationManager *locationManager;
    CLLocationCoordinate2D *currentLocation;
    CGFloat cLat;
    CGFloat clng;
    //地図
    MKMapView *mapView;
    
}
//プロパティの宣言
@property (nonatomic,retain) CLLocationManager *locationManager;
@property (nonatomic, readonly) CLLocationCoordinate2D *currentLocation;
@property (nonatomic,retain) MKMapView *mapView;
@property (nonatomic, retain) UIToolbar *tb;

- (void)onPause;

@end
