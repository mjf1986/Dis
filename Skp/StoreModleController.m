//
//  StoreModleController.m
//  Dis
//
//  Created by 剑锋 莫 on 16/7/8.
//  Copyright © 2016年 剑锋 莫. All rights reserved.
//

#import "StoreModleController.h"
#import "MJCollectionViewController.h"
#import "CommonHeader.h"
#import "JSDropDownMenu.h"
@interface StoreModleController()<JSDropDownMenuDataSource,JSDropDownMenuDelegate>
@property (strong,nonatomic)JSDropDownMenu *menu;
@property (strong,nonatomic)NSMutableArray *dataMenu1;
@property (strong,nonatomic)NSMutableArray *dataMenu2;
@property (strong,nonatomic)NSMutableArray *dataMenu3;
@property (assign,nonatomic)NSInteger currentData1Index;
@property (assign,nonatomic)NSInteger currentData2Index;
@property (assign,nonatomic)NSInteger currentData3Index;
@end
@implementation StoreModleController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self initMenu];
    [self initForViews];
}
-(void)initForViews
{
    MJCollectionViewController *collection = [MJCollectionViewController new];
    [self addChildViewController:collection];
    [self.view addSubview:collection.view];
    collection.view.sd_layout
    .topSpaceToView(_menu, 0)
    .leftSpaceToView(self.view , 0)
    .widthRatioToView(self.view, 1)
    .bottomSpaceToView(self.view , 0);
    //.heightRatioToView(self.view,1);
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
    [self.view addSubview:menu];
    _menu = menu;
    _menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    _menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    _menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    _menu.dataSource = self;
    _menu.delegate = self;
    _menu.sd_layout
    .topSpaceToView(self.view , 0)
    .leftSpaceToView(self.view , 0)
    .widthRatioToView(self.view, 1)
    .heightIs(40);

    
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

@end
