//
//  MiesViewController.m
//  MACC
//
//  Created by 水野 真史 on 11/07/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MiesViewController.h"


@implementation MiesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    //背景色
    self.view.backgroundColor = [UIColor whiteColor];
    //
    self.title = @"ミース・ファン・デル・ローエ";
    return self;
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)viewDidLoad {     
    [super viewDidLoad];
    
    //背景画像
    UIImage *backimg = [UIImage imageNamed:@"background.png"];
    UIImageView *backimgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backimgView.image = backimg;
    backimgView.alpha = 0.3;
    backimgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backimgView];
    [backimgView release];
    
    
    //portrait画像
    UIImage *photo = [UIImage imageNamed:@"mies.png"];
    UIImageView *photoview = [[UIImageView alloc] initWithFrame:CGRectMake(80, 5, 160, 180)];
    photoview.image = photo;
    [self.view addSubview:photoview];
    [photoview release];
    
    //クレジット
    UILabel *credit = [[UILabel alloc] initWithFrame:CGRectMake(80, 190, 180, 10)];
    credit.text = @"(C)the Illinois Institute of Technology and Synectics";
    credit.numberOfLines = 0;
    credit.font = [UIFont fontWithName:@"Helvetica" size:10];
    credit.textColor = [UIColor blackColor];
    credit.textAlignment = UITextAlignmentLeft;
    credit.backgroundColor = [UIColor clearColor];
    [self.view addSubview:credit];
    [credit release];
    
    //経歴
    UITextView *history = [[UITextView alloc]initWithFrame:CGRectMake(10, 210, 300, 200)];
    NSString *textPath = [[NSBundle mainBundle] pathForResource:@"mies" ofType:@"txt"];
    NSString *text = [NSString stringWithContentsOfFile:textPath encoding:NSUTF8StringEncoding error:nil];
    history.text = text;
    history.font = [UIFont fontWithName:@"Helvetica" size:14];
    history.editable = NO;
    history.backgroundColor = [UIColor clearColor];
    [self.view addSubview:history];
    [history release];
    
}


- (void)viewDidUnload {
    
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
