//
//  MyModleViewController.m
//  Dis
//
//  Created by 剑锋 莫 on 16/7/8.
//  Copyright © 2016年 剑锋 莫. All rights reserved.
//

#import "MyModleViewController.h"
#import "HMSegmentedControl.h"
#import "CommonHeader.h"
#import "MJCollectionViewController.h"
@interface MyModleViewController()<UIScrollViewDelegate>
@property (strong,nonatomic)HMSegmentedControl *segmentedControl;
@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)NSArray *slideTableViews;
@end
@implementation MyModleViewController
#define HEIGHT_IMAGE 100
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self initSegmentedControl];
    [self initForViews];
}


-(void)initForViews
{
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.bounces = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    
    MJCollectionViewController *storeCollection = [MJCollectionViewController new];
    MJCollectionViewController *mycollection = [MJCollectionViewController new];
  
    [self addChildViewController:storeCollection];
    [self addChildViewController:mycollection];

    
    _slideTableViews = @[storeCollection.view,mycollection.view];

    _scrollView = scrollView;
    _scrollView.sd_layout
    .topSpaceToView(_segmentedControl, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
    
    
    
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    CGFloat fWidth = [UIScreen mainScreen].bounds.size.width;//self.view.frame.size.width;
    CGFloat fHeight = self.view.frame.size.height;
    
    for (int i = 0;i<[_slideTableViews count] ;i++)
    {
        
        UIView *subView = _slideTableViews[i];
        [_scrollView addSubview:subView];
        subView.tag = 10001 + i;
        
        UIView *imageviewUp = [_scrollView viewWithTag:10001 + i -1];
        if(i==0)
        {
            subView.sd_layout
            .topSpaceToView(_scrollView, 0)
            .leftSpaceToView(_scrollView , 0)
            .widthRatioToView(self.view, 1)
            .heightRatioToView(_scrollView,1);
        }
        else {
            subView.sd_layout
            .topSpaceToView(_scrollView, 0)
            .leftSpaceToView(imageviewUp , 0)
            .widthRatioToView(self.view, 1)
            .heightRatioToView(_scrollView,1);
        }
        
    }
    [scrollView setContentSize:CGSizeMake(fWidth * ([_slideTableViews count]), HEIGHT_IMAGE)];
    [scrollView setContentOffset:CGPointMake(0, 0)];
    //[scrollView scrollRectToVisible:CGRectMake(0,0,fWidth,fHeight) animated:NO];
    
}

-(void)initSegmentedControl
{
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] init];
    _segmentedControl = segmentedControl;
    [segmentedControl setSectionTitles:@[@"已购买",@"已收藏"]];
    [segmentedControl addTarget:self action:@selector(segmentSelect:) forControlEvents:UIControlEventValueChanged];
    [segmentedControl setBackgroundColor:WHITE_COLOR];
    [segmentedControl setTextColor:[UIColor lightGrayColor]];
    [segmentedControl setTextSelectedColor:APPFRAME_COLOR];
    segmentedControl.font =  [UIFont boldSystemFontOfSize:15];
    [segmentedControl setSelectionIndicatorColor:APPFRAME_COLOR];
    [segmentedControl setSelectionIndicatorMode:/*HMSelectionIndicatorResizesToStringWidth*/HMSelectionIndicatorFillsSegment];
    [segmentedControl setTag:3];
    [self.view addSubview:segmentedControl];
     [segmentedControl setSelectedIndex:0];
    segmentedControl.sd_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(20);
}

-(void)segmentSelect:(HMSegmentedControl *)segment
{

    NSInteger selectIndex = segment.selectedIndex;
    CGFloat fWidth = self.view.frame.size.width;
    [self.scrollView scrollRectToVisible:CGRectMake(fWidth*selectIndex,0,fWidth,HEIGHT_IMAGE) animated:YES]; //
}


#pragma mark UIScrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int page  = self.scrollView.contentOffset.x /pagewidth;
    page--;
    // _pageControl.currentPage = page;
    // _sgment.selectedSegmentIndex = page + 1;
    //  [_segmentedControl setSelectedIndex:page + 1 animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat fWidth = self.view.frame.size.width;
    CGFloat fHeight = self.view.frame.size.height;
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = self.scrollView.contentOffset.x /pagewidth;
    
    [_segmentedControl setSelectedIndex:currentPage animated:YES];
    //    if (currentPage==0)
    //    {
    //        [self.scrollView scrollRectToVisible:CGRectMake(fWidth * ([_slideTableViews count]-1),0,fWidth,fHeight) animated:NO]; // 序号0 最后1页
    //    }
    //    else if (currentPage==([_slideTableViews count]-1))
    //    {
    //        [self.scrollView scrollRectToVisible:CGRectMake(fWidth,0,fWidth,fHeight) animated:NO]; // 最后+1,循环第1页
    //    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView willDecelerate:(BOOL)decelerate{
    
}

@end
