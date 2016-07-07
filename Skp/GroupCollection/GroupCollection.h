//
//  GroupCollection.h
//  RTCollectionViewGroup
//
//  Created by Rabbit on 16/3/12.
//  Copyright © 2016年 Rabbit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupCollection : UICollectionViewController
- (NSNumber *)sd_maxWidth;
- (void)setSd_tag:(NSNumber *)sd_tag;

@property(nonatomic,retain)NSMutableArray *arrData;
@end

