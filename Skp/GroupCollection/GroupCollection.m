//
//  ViewController.m
//  RTCollectionViewGroup
//
//  Created by Rabbit on 16/3/12.
//  Copyright © 2016年 Rabbit. All rights reserved.
//

#import "GroupCollection.h"
#import "GroupCollectionCell.h"
#import "CommonHeader.h"
#import <objc/runtime.h>
#import "JSDropDownMenu.h"
@interface GroupCollection()<JSDropDownMenuDataSource,JSDropDownMenuDelegate>
@property (strong,nonatomic)NSMutableArray *dataMenu1;
@property (strong,nonatomic)NSMutableArray *dataMenu2;
@property (strong,nonatomic)NSMutableArray *dataMenu3;
@property (assign,nonatomic)NSInteger currentData1Index;
@property (assign,nonatomic)NSInteger currentData2Index;
@property (assign,nonatomic)NSInteger currentData3Index;
@property (strong,nonatomic)JSDropDownMenu *menu;
@end
static NSString *headerID = @"headerID";
static NSString *footerID = @"footerID";
#define SCREEN_WIDTH ([UIScreen  mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface GroupCollection ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
//内容数组
@property (nonatomic, strong) NSMutableArray *dataArray;
//标题数组
@property (nonatomic, strong) NSMutableArray *sectionArray;

@property (nonatomic, strong) NSMutableArray *stateArray;

@end

@implementation GroupCollection


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = NO;
    NSLog(@"%f",self.view.size.height);
    
//    //创建CollectionView布局类的对象，UICollectionViewFlowLayout有水平和垂直两种布局方式，如果你需要做复杂的而已可以继承UICollectionViewFlowLayout创建你自己的布局类
//    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
//    //指定布局方式为垂直
//    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
//    flow.minimumLineSpacing = 10;//最小行间距(当垂直布局时是行间距，当水平布局时可以理解为列间距)
//    flow.minimumInteritemSpacing = 10;//两个单元格之间的最小间距
//    
//    //创建CollectionView并指定布局对象
//    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, /*SCREEN_WIDTH*/self.view.bounds.size.width, /*SCREEN_HEIGHT*/self.view.bounds.size.height) collectionViewLayout:flow];
    self.collectionView.backgroundColor = WHITE_COLOR;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //[self.view addSubview:_collectionView];
    
    //注册用xib定制的cell，各参数的含义同UITableViewCell的注册
    [self.collectionView registerNib:[UINib nibWithNibName:@"GroupCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"GroupCellID"];
    
    //注册用xib定制的分组脚

    [self.collectionView registerNib:[UINib nibWithNibName:@"GroupSection" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GroupSectionID"];
    
    NSArray *one = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    
    _dataArray = [NSMutableArray arrayWithObjects:_arrData, nil];
    
    _stateArray = [NSMutableArray array];
    
    [self.collectionView registerClass:[JSDropDownMenu class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:headerID];
    [self.collectionView registerClass:[JSDropDownMenu class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter  withReuseIdentifier:footerID];
    
}

-(void)initMenu
{
    _currentData1Index = 0;
    _currentData2Index = 0;
    _currentData3Index = 0;
    _dataMenu1 = [NSMutableArray arrayWithObjects:@"选择行业", @"离我最近", @"评价最高", @"最新发布", @"人气最高", @"价格最低", @"价格最高", nil];
    _dataMenu2 = [NSMutableArray arrayWithObjects:@"选择节日", @"离我最近", @"评价最高", @"最新发布", @"人气最高", @"价格最低", @"价格最高", nil];
    _dataMenu3 = [NSMutableArray arrayWithObjects:@"屏幕比例", @"离我最近", @"评价最高", @"最新发布", @"人气最高", @"价格最低", @"价格最高", nil];
//    JSDropDownMenu *menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 20) andHeight:40];
    _menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    _menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    _menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    _menu.dataSource = self;
    _menu.delegate = self;
    
}

#pragma mark UICollectionViewDataSource
//协议的方法,用于返回section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;//_dataArray.count;
}

//协议中的方法，用于返回分区中的单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(1){//if ([_stateArray[section] isEqualToString:@"1"]) {
        //如果是打开状态
        NSArray *arr = [_dataArray objectAtIndex:section];
        return arr.count;
    }
    else{
        return 0;
    }
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //UICollectionViewCell里的属性非常少，实际做项目的时候几乎必须以其为基类定制自己的Cell
//    GroupCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GroupCellID" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor greenColor];
//    return cell;
    
    GroupCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GroupCellID" forIndexPath:indexPath];
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

//- (void*)getImageData:(UIImage*)image
//{
//    void* imageData;
//    if (imageData == NULL)
//        imageData = malloc(4 * image.size.width * image.size.height);
//    
//    CGColorSpaceRef cref = CGColorSpaceCreateDeviceRGB();
//    CGContextRef gc = CGBitmapContextCreate(imageData,
//                                            image.size.width,image.size.height,
//                                            8,image.size.width*4,
//                                            cref,kCGImageAlphaPremultipliedFirst);
//    CGColorSpaceRelease(cref);
//    UIGraphicsPushContext(gc);
//    
//    [image drawAtPoint:CGPointMake(0.0f, 0.0f)];
//    
//    UIGraphicsPopContext();
//    CGContextRelease(gc);
//    
//    return imageData;
//}

//协议中的方法，用于返回单元格的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //return CGSizeMake(SCREEN_WIDTH / 4 - 10, SCREEN_WIDTH / 4);
    return CGSizeMake(SCREEN_WIDTH / 2 - 15, (SCREEN_WIDTH / 2 - 15)*1.3);
}

//协议中的方法，用于返回整个CollectionView上、左、下、右距四边的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上、左、下、右的边距
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//这个方法是返回 Header的大小 size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 40);
}
//这个方法是返回 Footer的大小 size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind==UICollectionElementKindSectionFooter) {
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
    }
    
    if (indexPath.section >-1) {
        if(!_menu)
        {
            JSDropDownMenu *menu ;
           
            menu = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
            _menu = [menu  initWithOrigin:CGPointMake(0, 20) andHeight:40];
            [self initMenu];
        }
        
        return _menu;
    }
    return nil;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber * num = [self sd_tag];
    NSLog(@"click %ld", indexPath.row);
    
}

- (NSNumber *)sd_tag
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSd_tag:(NSNumber *)sd_tag
{
    objc_setAssociatedObject(self, @selector(sd_tag), sd_tag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
