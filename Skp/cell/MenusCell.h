//
//  MenusCell.h
//  teststorybord
//
//  Created by 剑锋 莫 on 16/1/18.
//  Copyright © 2016年 剑锋 莫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenusCell : UITableViewCell
typedef void(^clickMenuBlock) (NSMutableDictionary *dict,NSInteger index);
@property (nonatomic,strong)clickMenuBlock block;

-(void)setUpMenu:(clickMenuBlock)block;
-(void)setUpMenu:(NSDictionary *)dict block:(clickMenuBlock)block;
@end
