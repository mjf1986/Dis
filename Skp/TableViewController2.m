//
//  TableViewController2.m
//  teststorybord
//
//  Created by 剑锋 莫 on 16/1/31.
//  Copyright © 2016年 剑锋 莫. All rights reserved.
//

#import "TableViewController2.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

@interface TableViewController2()
@property(nonatomic,strong)NSArray *arrayColor;
@end

@implementation TableViewController2

#pragma mark UICollectionView 上下拉刷新

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *arrayColor = @[@"flatTurquoiseColor",
                            @"flatGreenSeaColor",
                            @"flatEmeraldColor",
                            @"flatNephritisColor",
                            @"flatPeterRiverColor",
                            @"flatBelizeHoleColor",
                            @"flatAmethystColor",
                            @"flatWisteriaColor",
                            @"flatWetAsphaltColor",
                            @"flatMidnightBlueColor",
                            @"flatSunFlowerColor",
                            @"flatOrangeColor",
                            @"flatCarrotColor",
                            @"flatPumpkinColor",
                            @"flatAlizarinColor",
                            @"flatPomegranateColor",
                            @"flatCloudsColor",
                            @"flatSilverColor",
                            @"flatConcreteColor",
                            @"flatAsbestosColor"];
    _arrayColor = arrayColor;
    self.edgesForExtendedLayout = NO;
    NSLog(@"%f",self.view.size.height);
    
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrayColor count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView = nil;
        
        UIView *bgColorView = [[UIView alloc] init];
        SEL colorsel = NSSelectorFromString(_arrayColor[indexPath.row]);
        UIColor *color = [UIColor performSelector:colorsel];
        [bgColorView setBackgroundColor:color];
        [cell.contentView addSubview:bgColorView];
        bgColorView.sd_layout
        .rightSpaceToView(cell.contentView,10)
        .topSpaceToView(cell.contentView,1)
        .bottomSpaceToView(cell.contentView,1)
        .widthIs(200);
        
    }
    for(UIView *subView in cell.contentView.subviews)
    {
        if([subView isKindOfClass:[UIImageView class]])
        {
            [subView removeFromSuperview];
        }
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    //    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    //    cell.textLabel.textColor = [UIColor whiteColor];
    //    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    //    cell.textLabel.textColor = [UIColor whiteColor];
    
    
    cell.textLabel.text = _arrayColor[indexPath.row];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;//self.view.bounds.size.height / [_arrayColor count];
}

@end
