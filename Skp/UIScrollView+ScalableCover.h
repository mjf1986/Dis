//
//
//
//  url:http://www.xiongcaichang.com
//  Created by bear on 16/3/31.
//  Copyright © 2016年 bear. All rights reserved.
//
#import <UIKit/UIKit.h>


static CGFloat tableHeaderHeight = 400;



@interface ScalableCover : UIImageView

@property (nonatomic, strong) UIScrollView *scrollView;

@end




@interface UIScrollView (ScalableCover)

@property (nonatomic, weak) ScalableCover *scalableCover;

- (void)addScalableCoverWithImage:(UIImage *)image withHeight:(CGFloat)fHeight;
- (void)removeScalableCover;

@end

