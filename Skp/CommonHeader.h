//
//  CommonHeader.h
//  Skp
//
//  Created by 剑锋 莫 on 16/3/11.
//  Copyright © 2016年 剑锋 莫. All rights reserved.
//

#ifndef CommonHeader_h
#define CommonHeader_h
#import "UIColor+FlatColors.h"
#import "UIView+KGViewExtend.h"
#import "UIImage+UIImageCategory.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

#define APPFRAME_COLOR                          [UIColor flatPeterRiverColor]
#define BARBK_COLOR                             [UIColor flatPeterRiverDeepColor]
#define CANCEL_BUTTON_COLOR                     [UIColor flatBelizeHoleColor]
#define HINT_COLOR                              [UIColor flatSilverColor]
#define LINE_COLOR                              [UIColor flatPeterRiverColor]
#define BK_COLOR                                [UIColor flatPomegranateColor]
#define BLACK_COLOR                             [UIColor blackColor]
#define WHITE_COLOR                             [UIColor whiteColor]
#define TINT_COLOR                              [UIColor flatCloudsColor]
#define SETTINGHINT_COLOR                       [UIColor flatMidnightBlueColor]
#define SETTINGTINT_COLOR                       [UIColor flatAsbestosColor]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0] 
#define MARGIN                                  15

#define NORMALCELL_HEIGHT                       42
#define WIDTHRADIO                              ([UIScreen mainScreen].bounds.size.width/320.0)
#define SCREEN_WIDTH ([UIScreen  mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#endif /* CommonHeader_h */
