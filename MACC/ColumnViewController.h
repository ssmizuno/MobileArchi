//
//  ColumnViewController.h
//  MACC
//
//  Created by 水野 真史 on 11/06/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ColumnViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
        
    UIButton *topColumm;
    UITableView *myTableView;
    NSMutableArray *items_;
    
}

@property(nonatomic,retain) UIButton *topColumm;
@property(nonatomic,retain) UITableView *myTableView;
@property(nonatomic,retain) NSMutableArray *items_;

@end
