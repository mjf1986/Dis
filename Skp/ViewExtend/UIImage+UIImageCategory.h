//
//  UIImage+UIImageCategory.h
//  易叮电水壶
//
//  Created by 莫 剑锋 on 15/7/22.
//  Copyright (c) 2015年 diaosiorg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageCategory)
- (UIImage*)transformWidth:(CGFloat)width
                    height:(CGFloat)height;
@end

@interface UIImage (Blur)
-(UIImage *)rn_boxblurImageWithBlur:(CGFloat)blur exclusionPath:(UIBezierPath *)exclusionPath;
@end

@interface UIImage (custom)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end