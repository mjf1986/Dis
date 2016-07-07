//
//  FirstTableViewController.m
//  Skp
//
//  Created by 剑锋 莫 on 16/3/24.
//  Copyright © 2016年 剑锋 莫. All rights reserved.
//

#import "FirstTableViewController.h"
#import "CommonHeader.h"
#import "MenusCell.h"
#import "JSDropDownMenu.h"
#import "MJRefresh.h"

@interface FirstTableViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,JSDropDownMenuDataSource,JSDropDownMenuDelegate>

@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)NSMutableArray *slideImages;
@property (strong,nonatomic)UIPageControl *pageControl;
@property (strong,nonatomic)NSMutableArray *dataMenu1;
@property (strong,nonatomic)NSMutableArray *dataMenu2;
@property (strong,nonatomic)NSMutableArray *dataMenu3;
@property (assign,nonatomic)NSInteger currentData1Index;
@property (assign,nonatomic)NSInteger currentData2Index;
@property (assign,nonatomic)NSInteger currentData3Index;
@property (strong,nonatomic)JSDropDownMenu *menu;

@end

#define HEIGHT_IMAGE 100
@implementation FirstTableViewController

- (void)languorefresh
{
    __unsafe_unretained UITableView *tableView = self.tableView;
    
    // 下拉刷新
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.mj_header endRefreshing];
        });
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.mj_footer endRefreshing];
        });
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
   // _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor=[UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = APPFRAME_COLOR;
     NSLog(@"%f",self.view.size.height);
    //
    
    
    //[self initScrollView];
    [self initMenu];
    
    [self.tableView registerClass:[MenusCell class] forCellReuseIdentifier:NSStringFromClass([MenusCell class])];
    
    [self performSelector:NSSelectorFromString(@"languorefresh") withObject:nil];

}

-(void)initMenu
{
    _currentData1Index = 0;
    _currentData2Index = 0;
    _currentData3Index = 0;
    _dataMenu1 = [NSMutableArray arrayWithObjects:@"选择行业", @"离我最近", @"评价最高", @"最新发布", @"人气最高", @"价格最低", @"价格最高", nil];
    _dataMenu2 = [NSMutableArray arrayWithObjects:@"选择节日", @"离我最近", @"评价最高", @"最新发布", @"人气最高", @"价格最低", @"价格最高", nil];
    _dataMenu3 = [NSMutableArray arrayWithObjects:@"屏幕比例", @"离我最近", @"评价最高", @"最新发布", @"人气最高", @"价格最低", @"价格最高", nil];
    JSDropDownMenu *menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 20) andHeight:40];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    _menu = menu;
}
-(void)initScrollView
{
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.bounces = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    scrollView.frame = CGRectMake(0, 0, 0, 0.375*[UIScreen mainScreen].bounds.size.width);
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0,0,0, 0.375*[UIScreen mainScreen].bounds.size.width)];
    [self.tableView.tableHeaderView  addSubview:scrollView];
    
    _scrollView = scrollView;
    scrollView.backgroundColor = [UIColor lightGrayColor];
    NSMutableArray * slideImages = [[NSMutableArray alloc] init];
    [slideImages addObject:@"1-4.jpg"];
    [slideImages addObject:@"1-1.jpg"];
    [slideImages addObject:@"1-2.jpg"];
    [slideImages addObject:@"1-3.jpg"];
    [slideImages addObject:@"1-4.jpg"];
    [slideImages addObject:@"1-1.jpg"];
    _slideImages = slideImages;
    
    
    _scrollView.sd_layout
    .topSpaceToView(self.tableView.tableHeaderView, 0)
    .leftSpaceToView(self.tableView.tableHeaderView, 0)
    .rightSpaceToView(self.tableView.tableHeaderView, 0)
    .autoHeightRatio(0.375);
    
    CGFloat fWidth = self.view.frame.size.width;
    
    for (int i = 0;i<[slideImages count] ;i++)
    {
        
        UIImageView *imageView = [UIImageView new];
        [_scrollView addSubview:imageView];
        imageView.tag = 10001 + i;
        
        UIView *imageviewUp = [_scrollView viewWithTag:10001 + i -1];
        if(i==0)
        {
            imageView.sd_layout
            .topSpaceToView(_scrollView, 0)
            .leftSpaceToView(_scrollView , 0)
            .widthRatioToView(self.view, 1)
            .heightRatioToView(_scrollView,1);
        }
        else {
            imageView.sd_layout
            .topSpaceToView(_scrollView, 0)
            .leftSpaceToView(imageviewUp , 0)
            .widthRatioToView(self.view, 1)
            .heightRatioToView(_scrollView,1);
        }
        imageView.image = [UIImage imageNamed:[slideImages objectAtIndex:i]];
        
    }
    [scrollView setContentSize:CGSizeMake(fWidth * ([slideImages count]), HEIGHT_IMAGE)];
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [self.scrollView scrollRectToVisible:CGRectMake(0,0,fWidth,HEIGHT_IMAGE) animated:NO];
    UIPageControl *pageControl = [UIPageControl new];
    [pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    pageControl.numberOfPages = [self.slideImages count]-2;
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged];
    
    [ self.tableView.tableHeaderView addSubview:pageControl];
    
    _pageControl = pageControl;
    _pageControl.sd_layout
    .widthIs(100)
    .heightIs(20)
    .bottomEqualToView(self.tableView.tableHeaderView)
    .centerXEqualToView(self.tableView);
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

#pragma mark "菜单" 响应
-(void)clickMenu:(NSInteger)index
{
    
}

- (void)turnPage
{
    CGFloat fWidth = self.view.frame.size.width;
    NSInteger page = _pageControl.currentPage;
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = self.scrollView.contentOffset.x /pagewidth;
    if (currentPage==([_slideImages count])){
        [_scrollView setContentOffset:CGPointMake(0, 0)];
        [self.scrollView scrollRectToVisible:CGRectMake(fWidth,0,fWidth,HEIGHT_IMAGE) animated:YES];
        return;
    }
    [self.scrollView scrollRectToVisible:CGRectMake(fWidth*(page+1),0,fWidth,HEIGHT_IMAGE) animated:YES]; //
}

- (void)runTimePage
{
    NSInteger page = _pageControl.currentPage;
    page++;
    page = page > 3 ? 0 : page ;
    _pageControl.currentPage = page;
    [self turnPage];
}

#pragma mark DownMenuDataSource
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 3;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{

    return NO;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    return 1.0f;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column==0) {
        
        return _currentData1Index;
        
    }
    else if (column==1) {
        
        return _currentData2Index;
    }
    
    else if (column==2){
        
        return _currentData3Index;
    }
    return 0;

}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    if (column==0) {
        
        return _dataMenu1.count;
        
    } else if (column==1){
        
        return _dataMenu2.count;
        
    } else if (column==2){
        
        return _dataMenu3.count;
    }
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 0: return _dataMenu1[_currentData1Index];
            break;
        case 1: return _dataMenu2[_currentData2Index];
            break;
        case 2: return _dataMenu3[_currentData3Index];
            break;
        default:
            return nil;
            break;
    }

}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column==0) {
        
         return _dataMenu1[indexPath.row];
        
    } else if (indexPath.column==1) {
        
        return _dataMenu2[indexPath.row];
        
    } else {
        
        return _dataMenu3[indexPath.row];
    }
}
#pragma mark DownMenuelegate
- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        
       _currentData2Index = indexPath.row;
        
    } else if(indexPath.column == 1){
        
        _currentData2Index = indexPath.row;
        
    } else{
        
        _currentData3Index = indexPath.row;
    }
}

#pragma mark UIScrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int page  = self.scrollView.contentOffset.x /pagewidth;
    page--;
    _pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat fWidth = self.view.frame.size.width;
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = self.scrollView.contentOffset.x /pagewidth;
    
    if (currentPage==0)
    {
        [self.scrollView scrollRectToVisible:CGRectMake(fWidth * ([_slideImages count]-1),0,fWidth,HEIGHT_IMAGE) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==([_slideImages count]-1))
    {
        [self.scrollView scrollRectToVisible:CGRectMake(fWidth,0,fWidth,HEIGHT_IMAGE) animated:NO]; // 最后+1,循环第1页
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView willDecelerate:(BOOL)decelerate{
    
}



#pragma mark UITableViewDataSource
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return _menu;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:[UIScreen mainScreen].bounds.size.width  tableView: tableView];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Class  currentClass = [MenusCell class];
    MenusCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    if(indexPath.row == 0)
    {
        [dict setObject: @"Strip/Aluminum Bar Application" forKey:@"title"];
        [dict setObject: @"background3.jpg" forKey:@"imge"];
        [dict setObject: @"Comercial lighting Application" forKey:@"title2"];
        [dict setObject: @"background3.jpg" forKey:@"imge2"];
    }
    else if(indexPath.row == 1)
    {
        [dict setObject: @"Strip/Aluminum Bar Application" forKey:@"title"];
        [dict setObject: @"background3.jpg" forKey:@"imge"];
        [dict setObject: @"Comercial lighting Application" forKey:@"title2"];
        [dict setObject: @"background3.jpg" forKey:@"imge2"];
    }
    __block __weak FirstTableViewController *wself = self;
    __block __weak NSIndexPath *wselfIndexpath = indexPath;
    //[cell setUpMenu:^(NSMutableDictionary *dict,NSInteger index)
    
    
    [cell setUpMenu:dict block:^(NSMutableDictionary *dict,NSInteger index){
        NSLog(@"%ld",(long)wselfIndexpath.row);
        NSLog(@"%ld",(long)index);
        [wself clickMenu:index];
    }];
    
    return cell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
