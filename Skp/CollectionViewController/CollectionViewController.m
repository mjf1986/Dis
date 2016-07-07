//
//  CollectionViewController.m
//  HJCarouselDemo
//
//  Created by haijiao on 15/8/20.
//  Copyright (c) 2015年 olinone. All rights reserved.
//

#import "CollectionViewController.h"
#import "HJCarouselViewLayout.h"
#import "HJCarouselViewCell.h"
#import "CommonHeader.h"


@interface CollectionViewController ()
@property (strong, nonatomic) NSMutableArray *arrCollectedMode;

@property (assign, nonatomic) float fMinIntervar;
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.view bringSubviewToFront:self.collectionView];
    self.view.backgroundColor =  APPFRAME_COLOR;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HJCarouselViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
}

- (NSIndexPath *)curIndexPath {
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
    NSIndexPath *curIndexPath = nil;
    NSInteger curzIndex = 0;
    for (NSIndexPath *path in indexPaths.objectEnumerator) {
        UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:path];
        if (!curIndexPath) {
            curIndexPath = path;
            curzIndex = attributes.zIndex;
            continue;
        }
        if (attributes.zIndex > curzIndex) {
            curIndexPath = path;
            curzIndex = attributes.zIndex;
        }
    }
    return curIndexPath;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *curIndexPath = [self curIndexPath];
    if (indexPath.row == curIndexPath.row) {
        return YES;
    }
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"click %ld", indexPath.row);
    

}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 6;//[_arrCollectedMode count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HJCarouselViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", indexPath.row % 3]];
    
    NSMutableArray *dictModeArr = _arrCollectedMode;
    
    NSDictionary *dictMode      = [dictModeArr objectAtIndex:indexPath.row];
    NSDictionary *dictModeInfo  = [dictMode objectForKey:@"mode"];
    NSString *strIsCollected    = [dictMode objectForKey:@"isCollected"];
    NSString* strRunTimes       = [dictMode objectForKey:@"RunTimes"];
    NSString *strModeName       = [dictModeInfo objectForKey:@"name"];
    NSString *strEffect         = [dictModeInfo objectForKey:@"effect"];
    NSString *strProcess        = [dictModeInfo objectForKey:@"process"];
    NSString *strIcon           = [dictModeInfo objectForKey:@"icon"];
    NSString *strRecipe         = [dictModeInfo objectForKey:@"recipe"];
    NSString *strModeID         = [dictModeInfo objectForKey:@"modeid"];

    
    [[cell.contentView viewWithTag:13] removeFromSuperview];
    CGRect rc = CGRectMake(0 ,0,280,288);
    UIView *viewBtnBottom = [[UIView alloc]initWithFrame:CGRectMake(0,0,rc.size.width, rc.size.height)];
    viewBtnBottom.tag = 13;
    viewBtnBottom.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1];
    [cell.contentView addSubview:viewBtnBottom];
    
//    UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", indexPath.row+1]];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,rc.size.width,200)];
//    imageView.image = img;
    
    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
        NSString *strImageComp = [NSString stringWithFormat:@"/mode_data/images/%@/%@",strModeID,[dictModeInfo objectForKey:@"icon"]];
    NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:strImageComp];
    imageView.image = [UIImage imageWithContentsOfFile:savedImagePath];
    
    int type = [[dictMode objectForKey:@"type"]intValue];
    if(type == 5)
    {
        imageView.image = [UIImage imageNamed:@"diy.png"];
    }
    
    [viewBtnBottom addSubview:imageView];
    
    
    [[cell.contentView viewWithTag:11] removeFromSuperview];
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0,0,rc.size.width, 32)];
    labelTitle.tag = 11;
    labelTitle.text = strModeName;
    labelTitle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    labelTitle.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:labelTitle];
    
    [[cell.contentView viewWithTag:12] removeFromSuperview];
    
    UILabel *labelDetail = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, rc.size.width - 20, 32)];
    labelDetail.tag = 12;
    labelDetail.textColor = [UIColor whiteColor];
    labelDetail.font = [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:13];
   // labelDetail.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
    labelDetail.textAlignment = NSTextAlignmentLeft;
    labelDetail.numberOfLines = 0;
    labelDetail.lineBreakMode = NSLineBreakByWordWrapping;
    labelDetail.text = strRecipe;//@"\t陈皮1g\n\t醋2g\n\t花生油10g\n\t盐一杯\n\t燕窝500g\t陈皮1g\n\t醋2g\n\t花生油10g\n\t盐一杯\n\t燕窝500g";
    CGSize size = [labelDetail sizeThatFits:CGSizeMake(labelDetail.frame.size.width, MAXFLOAT)];
    size = CGSizeMake(rc.size.width,40);
    labelDetail.frame =CGRectMake(10, 0, rc.size.width -20, size.height + 1);
    UIView *viewlablebottom = [[UIView alloc]initWithFrame:CGRectMake(0, 200, rc.size.width, size.height + 1)];
    viewlablebottom.tag =15;
    viewlablebottom.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
    [cell.contentView addSubview:viewlablebottom];
    [viewlablebottom addSubview:labelDetail];
    
    //end add
    NSString* cellStr1 = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    [[cell.contentView viewWithTag:10] removeFromSuperview];
    UIButton* purchaseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    purchaseButton.frame = CGRectMake(15 , 200+size.height +8, 32, 32);
    purchaseButton.alpha = 0;
    //[purchaseButton setTitle:NSLocalizedString(@"Cooking", @"") forState:UIControlStateNormal];
    [purchaseButton setBackgroundImage:[UIImage imageNamed:@"modeburn"] forState:UIControlStateNormal];
    purchaseButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:13];
    //purchaseButton.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    [purchaseButton setTintColor:[UIColor whiteColor]];
    [cell.contentView addSubview:purchaseButton];
    purchaseButton.tag = 10;
    [purchaseButton setTitle:cellStr1 forState:UIControlStateDisabled];
    [purchaseButton addTarget:self action:@selector(clickBurn:) forControlEvents:UIControlEventTouchUpInside];
    
    [[cell.contentView viewWithTag:20] removeFromSuperview];
    UIView *viewBottom = [[UIView alloc]init];
    viewBottom.frame = CGRectMake(0, 200+size.height, rc.size.width, 48);
    viewBottom.alpha = 0;
    viewBottom.tag = 20;
    [cell.contentView addSubview:viewBottom];
    
    float interval = (rc.size.width - 30 - (32*4.0))/3.0;
    [[cell.contentView viewWithTag:40] removeFromSuperview];
    UIButton* yuyueButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    yuyueButton.tag = 40;
    yuyueButton.frame = CGRectMake(15 + 32 + interval, viewBottom.frame.origin.y+8, 32, 32);
    yuyueButton.alpha = 1;
    //[detailButton setTitle:@"查看" forState:UIControlStateNormal];
    [yuyueButton setBackgroundImage:[UIImage imageNamed:@"yuyuetu.png"] forState:UIControlStateNormal];
    yuyueButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:13];
    yuyueButton.backgroundColor = [UIColor clearColor];
    [yuyueButton setTintColor:[UIColor whiteColor]];
    [cell.contentView addSubview:yuyueButton];
    [yuyueButton addTarget:self action:@selector(clickYuyue:) forControlEvents:UIControlEventTouchUpInside];
    [yuyueButton setTitle:cellStr1 forState:UIControlStateDisabled];
    
    
    [[cell.contentView viewWithTag:50] removeFromSuperview];
    UIButton* detailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    detailButton.tag = 50;
    detailButton.frame =
    CGRectMake(15 + (32 + interval)*3, viewBottom.frame.origin.y + 8, 32, 32);
    detailButton.alpha = 1;
    [detailButton setBackgroundImage:[UIImage imageNamed:@"eye.png"] forState:UIControlStateNormal];
    detailButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:13];
    detailButton.backgroundColor = [UIColor clearColor];
    [detailButton setTintColor:[UIColor whiteColor]];
    [cell.contentView addSubview:detailButton];
    [detailButton addTarget:self action:@selector(clickLook:) forControlEvents:UIControlEventTouchUpInside];
    [detailButton setTitle:cellStr1 forState:UIControlStateDisabled];
    
    //
    NSString *strCollect = NSLocalizedString(@"Collection", @"");//@"收藏";
    [[cell.contentView viewWithTag:14] removeFromSuperview];
    UIButton* collectButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //collectButton.frame =  CGRectMake(CGRectGetMidX(rc)-32/2.0, viewBottom.frame.origin.y+8, 32, 32);
    collectButton.frame =  CGRectMake(15 + (32 + interval)*2 , viewBottom.frame.origin.y+8, 32, 32);
    collectButton.alpha = 1;
    collectButton.tag = 14;
    //[collectButton setTitle:strCollect forState:UIControlStateNormal];
    NSString *strCollectPng = @"collectnot.png";
    if([strIsCollected isEqualToString:@"YES"])
    {
        strCollectPng = @"collect.png";
    }
    [collectButton setBackgroundImage:[UIImage imageNamed:strCollectPng] forState:UIControlStateNormal];
    [collectButton setTitle:cellStr1 forState:UIControlStateDisabled];
    
    collectButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:13];
    collectButton.backgroundColor = [UIColor clearColor];
    [collectButton setTintColor:[UIColor whiteColor]];
    
    [cell.contentView addSubview:collectButton];
    

    purchaseButton.alpha = 1;
    viewBottom.alpha = 1;
    [cell.contentView viewWithTag:7].transform = CGAffineTransformMakeRotation(3.14);
    [cell.contentView viewWithTag:7].alpha = 0;
    purchaseButton.frame = CGRectMake(15 , 200+size.height +8, 32, 32);
    viewBottom.frame = CGRectMake( rc.size.width-32-15, 200+size.height+8, 32, 32);
    NSLog(@"%f,%f,%f,%f",cell.frame.origin.x,cell.frame.origin.y,cell.frame.size.width,cell.frame.size.height);
    cell.clipsToBounds = YES;
    cell.layer.cornerRadius = 5;
    return cell;
}


@end
