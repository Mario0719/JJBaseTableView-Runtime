//
//  JJBaseCollectionView+Network.h
//  MyRAC
//
//  Created by Mario on 2019/8/5.
//  Copyright © 2019 MS. All rights reserved.
//

#import "JJBaseCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JJBaseCollectionView (Network)

@property (nonatomic, strong) UIView *networkView;

// 加载 网络中断占位View
- (void)makeDefaultNetworkStatusView;

@end

NS_ASSUME_NONNULL_END
