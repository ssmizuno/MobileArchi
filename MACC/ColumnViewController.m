//
//  ColumnViewController.m
//  MACC
//
//  Created by 水野 真史 on 11/06/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ColumnViewController.h"
#import "TopColumnViewController.h"
#import "MuseumColumnVIewController.h"
#import "ArchiColumnViewController.h"


@implementation ColumnViewController

@synthesize topColumm;
@synthesize myTableView;
@synthesize items_;

//----------Viewの初期化----------//
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		self.title = @"AirchColumn";
		self.view.backgroundColor = [UIColor blackColor];
        self.tabBarItem.image = [UIImage imageNamed:@"tabicon02.png"];
        
    }
    return self;
}


#pragma mark - View lifecycle

//ビューが読み込まれたときに呼び出される
 - (void)viewDidLoad {
     [super viewDidLoad];
          
     //テーブルビューの設定
     myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 189, self.view.frame.size.width, self.view.frame.size.height-189) style:UITableViewStylePlain];
     myTableView.delegate = self;
     myTableView.dataSource = self;	
     [self.view addSubview:myTableView];
     
     
     //-- 機能一覧配列格納 --//
     NSMutableArray *array = [[NSMutableArray alloc] init];
     
     //-- ViewController00を配列に追加 --//
     TopColumnViewController *VC00 = [[TopColumnViewController alloc] initWithNibName:nil bundle:nil];
     [array addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                       @"世界の建築家トップニュース", @"title",
                       VC00, @"viewController",
                       nil]];
     [VC00 release];
     
     //-- ViewController01を配列に追加 --//
     ArchiColumnViewController *VC01 = [[ArchiColumnViewController alloc] initWithNibName:nil bundle:nil];
     [array addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                       @"近代建築の名作を歩く", @"title",
                       VC01, @"viewController",
                       nil]];
     [VC01 release];
     
     //-- ViewController02を配列に追加 --//
     MuseumColumnVIewController *VC02 = [[MuseumColumnVIewController alloc] initWithNibName:nil bundle:nil];
     [array addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                       @"世界のミュージアム巡り", @"title",
                       VC02, @"viewController",
                       nil]];
     [VC02 release];
     
     //-- 配列をfunctionsに割り当て --//
     self.items_ = array;
     [array release];
     
     //----------PickUpColumnボタン----------//
     self.topColumm = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
     self.topColumm.frame = CGRectMake(0.0, 0.0, 320, 189);
     [self.topColumm setImage:[UIImage imageNamed:@"topColumn.png"] forState:UIControlStateNormal];
     self.topColumm.backgroundColor = [UIColor clearColor];
     self.topColumm.reversesTitleShadowWhenHighlighted = YES;
     [self.topColumm addTarget:self action:@selector(gotopcolumnPage:) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:topColumm];
     
 }

//----------ページ遷移----------//
//topcolumn
-(void)gotopcolumnPage:(id)sender{	
	TopColumnViewController *next01 = [[[TopColumnViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    next01.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:next01 animated:YES];
}

//-- テーブル設定 その1 ------------------------------//
// テーブルのセクション数を設定します。ここでは1セクション。
//-------------------------------------------------//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//-- テーブル設定 その2 ------------------------------//
// テーブルの行数を設定します。ここでは配列に入っている値の数分。
//-------------------------------------------------//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items_ count];
}

//-- テーブル設定 その3 ------------------------------//
// テーブルの見た目を設定します。
// セルの文字に加え、イメージアイコンやアクセサリーも設定しています。
//-------------------------------------------------//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"] autorelease];
    }
    
    //-- セルの設定 --//
	// セルのラベルの設定
	cell.textLabel.text = [[self.items_ objectAtIndex:indexPath.row] objectForKey:@"title"];
	// セルに付けるアイコン画像の設定
	//cell.imageView.image = [UIImage imageNamed:@"saru.png"];
	// セルのアクセサリーの設定
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegateメソッドに一部の処理を任せます

//-- テーブル設定 その4 ------------------------------//
// テーブル列の高さを設定します。
//-------------------------------------------------//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 50;
}

//-- テーブル処理 その1 ------------------------------//
// 行の選択開始時の処理を設定します。
//-------------------------------------------------//

//-- テーブル処理 その1 ------------------------------//
// 行の選択開始時の処理を設定します。
//-------------------------------------------------//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {	
	UIViewController *targetViewController = [[self.items_ objectAtIndex: indexPath.row] objectForKey:@"viewController"];
    targetViewController.hidesBottomBarWhenPushed = YES;
	[[self navigationController] pushViewController:targetViewController animated:YES];
}

//アクティブ時に呼ばれる
- (void)viewWillAppear:(BOOL)animated {
	NSIndexPath* selection = [myTableView indexPathForSelectedRow];
	if(selection){
		[myTableView deselectRowAtIndexPath:selection animated:YES];
	}
	[myTableView reloadData];
}

//非アクティブ時に呼ばれる
- (void)viewDidAppear:(BOOL)animated {
	[self.myTableView flashScrollIndicators];
}

//ビュー読み込み終了時に呼ばれる
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    //インスタンス変数を空にしておく
    self.topColumm = nil;
}

//メモリ不足時に呼ばれる
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//解放処理
- (void)dealloc {
    
    [items_ release];
    
    [topColumm release];
    [super dealloc];
}

@end
