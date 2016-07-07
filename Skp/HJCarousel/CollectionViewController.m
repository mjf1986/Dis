//
//  CommonModeViewController.m
//  HJCarouselDemo
//
//  Created by mjf on 16/7/05.
//  Copyright (c) 2015年 olinone. All rights reserved.
//

#import "CollectionViewController.h"
#import "HJCarouselViewLayout.h"
#import "HJCarouselViewCell.h"
#import <objc/runtime.h>


@interface CollectionViewController ()
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";



- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = NO;
    [self setTitle:@"屏幕列表"];
    
    CGRect rc = [[UIScreen mainScreen] bounds] ;
    UIView* viewBottom = [[UIView alloc]initWithFrame:rc];
    //[self setBgBlurView:viewBottom withImage:@"background0.jpg"];
    
    [self.view addSubview:viewBottom];
    [self.view bringSubviewToFront:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HJCarouselViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];

    //
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

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"click %ld", indexPath.row);
    
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 16;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HJCarouselViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [[cell.contentView viewWithTag:13] removeFromSuperview];
    CGRect rc = CGRectMake(0 ,0,240, 400);
    UIView *viewBtnBottom = [[UIView alloc]initWithFrame:CGRectMake(0,0,rc.size.width, rc.size.height)];
    viewBtnBottom.tag = 13;
    viewBtnBottom.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1];
    [cell.contentView addSubview:viewBtnBottom];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,rc.size.width,rc.size.height - 50)];
    
    imageView.image = [UIImage imageNamed:@"background3.jpg"];

    [viewBtnBottom addSubview:imageView];
    
    
    NSLog(@"%f,%f,%f,%f",cell.frame.origin.x,cell.frame.origin.y,cell.frame.size.width,cell.frame.size.height);
    
    cell.layer.cornerRadius = 5;
    cell.contentView.layer.cornerRadius = 5.0f;
    cell.contentView.layer.borderWidth = 1.0f;
    cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.contentView.layer.masksToBounds = YES;
    
    cell.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(1, 1);
    cell.layer.shadowRadius = 4.0f;
    cell.layer.shadowOpacity = 0.5f;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    
    return cell;
}


- (NSNumber *)paramValue:(id)object

{
    return objc_getAssociatedObject(object, _cmd);
}


- (void)setparamValue:(NSNumber *)value object:(id)object

{
    objc_setAssociatedObject(object, @selector(paramValue:), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
