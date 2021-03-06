//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MJCollectionViewController.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/6.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJCollectionViewController.h"
#import "MJRefresh.h"
//#import "JSDropDownMenu.h"
#import "GroupCollectionCell.h"
#import "CommonHeader.h"
#import "MJCollectionViewController.h"
#import "XLPlainFlowLayout.h"

@interface MJCollectionViewController()


@end



static NSString *headerID = @"headerID";
static NSString *const MJCollectionViewCellIdentifier = @"MJCollectionViewCellIdentifier";
static const CGFloat MJDuration = 2.0;
/**
 * 随机色
 */
#define MJRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

@interface MJCollectionViewController()
/** 存放假数据 */
@property (strong, nonatomic) NSMutableArray *colors;
@end

@implementation MJCollectionViewController
#pragma mark - 示例
#pragma mark UICollectionView 上下拉刷新
- (void)languorefresh
{
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 下拉刷新
    self.collectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 增加5条假数据
        for (int i = 0; i < 5; i++) {
            [weakSelf.colors insertObject:MJRandomColor atIndex:0];
        }
        
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
            
            // 结束刷新
            [weakSelf.collectionView.mj_header endRefreshing];
        });
    }];
    [self.collectionView.mj_header beginRefreshing];

    // 上拉刷新
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 增加5条假数据
        for (int i = 0; i<5; i++) {
            [weakSelf.colors addObject:MJRandomColor];
        }
        
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
            
            // 结束刷新
            [weakSelf.collectionView.mj_footer endRefreshing];
        });
    }];
    // 默认先隐藏footer
    //self.collectionView.mj_footer.hidden = YES;
}

#pragma mark - 数据相关
- (NSMutableArray *)colors
{
    if (!_colors) {
        self.colors = [NSMutableArray array];
    }
    return _colors;
}

#pragma mark - 其他

/**
 *  初始化
 */
- (id)init
{
    // UICollectionViewFlowLayout的初始化（与刷新控件无关）
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.itemSize = CGSizeMake(SCREEN_WIDTH / 2 - 15, (SCREEN_WIDTH / 2 - 15)*1.3);
//    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    layout.minimumInteritemSpacing = 10;
//    layout.minimumLineSpacing = 10;
//    return [self initWithCollectionViewLayout:layout];
    
    XLPlainFlowLayout *layout = [XLPlainFlowLayout new];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH / 2 - 15, (SCREEN_WIDTH / 2 - 15)*1.3);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.naviHeight = 40.0;
    
    return [self initWithCollectionViewLayout:layout];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.collectionView registerClass:[JSDropDownMenu class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:headerID];
        //
     [self performSelector:NSSelectorFromString(@"languorefresh") withObject:nil];
    //[self performSelector:NSSelectorFromString(self.method) withObject:nil];
    self.title = @"mjf";
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:MJCollectionViewCellIdentifier];
}



#pragma mark UICollectionViewDataSource
/**
 *  一组有多少个
 *
 *  @param collectionView <#collectionView description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

/**
 *  一组有多少个
 *
 *  @param collectionView <#collectionView description#>
 *  @param section        <#section description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%ld",self.colors.count);
    return self.colors.count;
}

/**
 *  cell里面的数据
 *
 *  @param collectionView collectionView description
 *  @param indexPath      indexPath description
 *
 *  @return return value description
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MJCollectionViewCellIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = self.colors[indexPath.row];
//    return cell;
    
    GroupCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MJCollectionViewCellIdentifier  forIndexPath:indexPath];
    cell.backgroundColor = WHITE_COLOR;//UIColorFromRGB(0x262626);
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background3.jpg"]];
    [cell.contentView addSubview:imgView];
    UILabel *labelTitle = [UILabel new];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.font = [UIFont fontWithName:@"Helvetica" size:13];
    labelTitle.textColor = BLACK_COLOR;
    labelTitle.text = @"industrial light";
    [cell.contentView addSubview:labelTitle];
    imgView.sd_layout
    .leftSpaceToView(cell.contentView,0)
    .rightSpaceToView(cell.contentView,0)
    .topSpaceToView(cell.contentView,0)
    .heightEqualToWidth();
    
    labelTitle.sd_layout
    .leftEqualToView(cell.contentView)
    .rightEqualToView(cell.contentView)
    .bottomEqualToView(cell.contentView)
    .heightIs(MARGIN*2);
    
    //cell.layer.cornerRadius = 5;
    //cell.contentView.layer.cornerRadius = 5.0f;
    cell.contentView.layer.borderWidth = 1.0f;
    cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.contentView.layer.masksToBounds = YES;
    
    cell.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    cell.layer.shadowRadius = 2.0f;
    cell.layer.shadowOpacity = 0.5f;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    
    return cell;

}

/**
 *  头和尾巴的数据加载
 *
 *  @param collectionView collectionView description
 *  @param kind           kind description
 *  @param indexPath      indexPath description
 *
 *  @return return value description
 */
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    
//    if (kind==UICollectionElementKindSectionFooter) {
//
//    }
//    
//    if (indexPath.section >-1) {
//        if(!_menu)
//        {
//            JSDropDownMenu *menu ;
//            
//            menu = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
//            _menu = [menu  initWithOrigin:CGPointMake(0, 20) andHeight:40];
//            [self initMenu];
//        }
//        
//        return _menu;
//
//    }
//    return nil;
//}

/**
 *  这个是头的距离（如果想隐藏就改成（0，0））
 *
 *  @param collectionView       <#collectionView description#>
 *  @param collectionViewLayout <#collectionViewLayout description#>
 *  @param section              <#section description#>
 *
 *  @return return value description
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeZero;
}

/**
 *  这个是尾巴的距离（如果想隐藏就改成（0，0））
 *
 *  @param collectionView       <#collectionView description#>
 *  @param collectionViewLayout <#collectionViewLayout description#>
 *  @param section              <#section description#>
 *
 *  @return return value description
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    //    if (section==3) {
    //        return CGSizeZero;
    //    }
    return CGSizeZero;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"click %ld", indexPath.row);
    
}




@end
