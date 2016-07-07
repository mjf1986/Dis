//
//  ViewController.m
//  RTCollectionViewGroup
//
//  Created by Rabbit on 16/3/12.
//  Copyright © 2016年 Rabbit. All rights reserved.
//

#import "GroupCollectionTree.h"
#import "GroupCollectionCell.h"
#import "CommonHeader.h"
#import <objc/runtime.h>

#define SCREEN_WIDTH ([UIScreen  mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface GroupCollectionTree ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
//内容数组
@property (nonatomic, strong) NSMutableArray *dataArray;
//标题数组
@property (nonatomic, strong) NSMutableArray *sectionArray;

@property (nonatomic, strong) NSMutableArray *stateArray;

@end

@implementation GroupCollectionTree


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
    self.collectionView.backgroundColor = BLACK_COLOR;
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
    
}

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
    cell.backgroundColor = UIColorFromRGB(0x262626);
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"11.jpg"]];
    [cell.contentView addSubview:imgView];
    UILabel *labelTitle = [UILabel new];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.font = [UIFont fontWithName:@"Helvetica" size:13];
    labelTitle.textColor = TINT_COLOR;
    labelTitle.text = @"industrial light";
    [cell.contentView addSubview:labelTitle];
    imgView.sd_layout
    .leftSpaceToView(cell.contentView,0)
    .rightSpaceToView(cell.contentView,0)
    .bottomSpaceToView(cell.contentView,0)
    .topSpaceToView(cell.contentView,0);

    labelTitle.sd_layout
    .leftEqualToView(cell.contentView)
    .rightEqualToView(cell.contentView)
    .bottomEqualToView(cell.contentView)
    .heightIs(MARGIN*2);
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
    return CGSizeMake(SCREEN_WIDTH / 3 - 10, SCREEN_WIDTH / 3- 10);
}

//协议中的方法，用于返回整个CollectionView上、左、下、右距四边的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上、左、下、右的边距
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(10, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(10, 10);
}

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

@end
