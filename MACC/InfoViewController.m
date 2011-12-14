//
//  InfoViewController.m
//  MACC
//
//  Created by 水野 真史 on 11/07/01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InfoViewController.h"


@implementation InfoViewController

//----------Viewの初期化----------//
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		self.title = @"information";
		self.view.backgroundColor = [UIColor blackColor];
        self.tabBarItem.image = [UIImage imageNamed:@"tabicon03.png"];
    }
    return self;
}


#pragma mark - View lifecycle

 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
     [super viewDidLoad];
     
     //----------背景イメージの表示----------//
     UIImage *image = [UIImage imageNamed:@"info.png"];
     UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, -10, self.view.frame.size.width, self.view.frame.size.height)];
     bgImg.image = image;
     [self.view addSubview:bgImg];
     [bgImg release];
     
     //----------バージョン情報の表示----------//
     UILabel *version = [[UILabel alloc] initWithFrame:CGRectMake(110, 210, 100, 15)];
     version.text = @"version1.2";
     version.numberOfLines = 0;
     version.textAlignment = UITextAlignmentCenter;
     version.textColor = [UIColor whiteColor];
     version.backgroundColor = [UIColor clearColor];
     version.font = [UIFont fontWithName:@"Helvetica" size:18.0];
     [self.view addSubview:version];
     [version release];
     
 }
 

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



@end
