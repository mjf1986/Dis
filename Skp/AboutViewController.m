//
//  AboutViewController.m
//  Skp
//
//  Created by 剑锋 莫 on 16/3/11.
//  Copyright © 2016年 剑锋 莫. All rights reserved.
//

#import "AboutViewController.h"
#import "CommonHeader.h"
#import "UIScrollView+ScalableCover.h"
#import "UINavigationBar+Transparent.h"
#import "TransparentView.h"

@interface AboutViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation AboutViewController

-( UIView *) setBlurViewwithImage:(NSString*)imgName withFrame:(CGRect)rcFrame
{
    UIView *blurView = [[UIView alloc] initWithFrame:rcFrame];
    blurView.alpha = 1.f;
    blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    UIImage *screenshot = [UIImage imageNamed:imgName];
    blurView.layer.contents = screenshot;
    UIBezierPath *blurExclusionPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.f, 0.f,0.f,0.f)];
    UIImage *blur = [screenshot rn_boxblurImageWithBlur:.9 exclusionPath:blurExclusionPath];
    
    
    CATransition *transition = [CATransition animation];
    
    transition.duration = 0.1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [blurView.layer addAnimation:transition forKey:nil];
    blurView.layer.contents = (id)blur.CGImage;

    return blurView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = YES;
    //[self setTitle:@"我的"];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    CGRect rcHead = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    //方法一：start
    self.tableView.tableHeaderView = [[UITableViewHeaderFooterView alloc] initWithFrame:rcHead];
    UIImage *screenshot = [UIImage imageNamed:@"background3.jpg"];
    UIBezierPath *blurExclusionPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.f, 0.f,0.f,0.f)];
    UIImage *blur = [screenshot rn_boxblurImageWithBlur:.9 exclusionPath:blurExclusionPath];
    [self.tableView addScalableCoverWithImage:blur withHeight:CGRectGetHeight(rcHead)];
    //end
    
    //方法二：start
//    UIView *topView = [self setBlurViewwithImage:@"background3.jpg" withFrame:rcHead];
//    topView.frame = rcHead;
//    TransparentView *transparentView = [TransparentView dropHeaderViewWithFrame:topView.frame contentView:topView stretchView:topView];
//    transparentView.frame = topView.frame;
//    self.tableView.tableHeaderView = transparentView;
    //end
    
    
    UIBarButtonItem *btnRight=[[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStyleDone target:self action:@selector(clickModify:)];
    btnRight.title = @"修改资料";
    self.navigationItem.rightBarButtonItem = btnRight;
    
    UIImageView *headerImg = [UIImageView new];
    headerImg.frame = CGRectMake(SCREEN_WIDTH/2.0 - 50, 0, 100, 100);
    headerImg.image = screenshot;
    headerImg.clipsToBounds = YES;
    headerImg.layer.cornerRadius = 50;
    headerImg.layer.borderColor = [[UIColor whiteColor] CGColor];
    headerImg.layer.borderWidth = 2.0f;
    [self.tableView.tableHeaderView addSubview:headerImg];

}

-(void)clickModify:(id)sender
{
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar js_setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar js_reset];
}


#pragma mark UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return NORMALCELL_HEIGHT *WIDTHRADIO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(section == 0)
    {
        return 5;
    }
    else if(section == 1)
    {
        return 1;
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    CGRect rc = [tableView rectForHeaderInSection:section];
//    UIView *view = [UIView new];
//    view.sd_layout
//    .leftSpaceToView(tableView, 0)
//    .topSpaceToView(tableView, 0)
//    .rightSpaceToView(tableView, 0)
//    .heightIs(rc.size.height);
//    return view;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"清除缓存";
        }
        else  if(indexPath.row == 1)
        {
            cell.textLabel.text = @"使用帮助";
        }
        else  if(indexPath.row == 2)
        {
            cell.textLabel.text = @"关于我们";
        }
        else  if(indexPath.row == 3)
        {
            cell.textLabel.text = @"意见反馈";
        }
        else  if(indexPath.row == 4)
        {
            cell.textLabel.text = @"检查更新";
        }
    }

    else if(indexPath.section == 1)
    {
        cell.textLabel.text = @"退出登录";
    }
    return cell;
}



#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >0) {
        CGFloat alpha = (offsetY -64) / 64 ;
        alpha = MIN(alpha, 0.9);
        [self.navigationController.navigationBar js_setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar js_setBackgroundColor:[UIColor clearColor]];
    }
}


@end
