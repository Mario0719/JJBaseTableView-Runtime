//
//  JJBaseTableView+Network.h
//  MyRAC
//
//  Created by Mario on 2019/8/2.
//  Copyright © 2019 MS. All rights reserved.
//

#import "JJBaseTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JJBaseTableView (Network)

@property (nonatomic, strong) UIView *networkView;

// 加载 网络中断占位View
- (void)makeDefaultNetworkStatusView;

@end

NS_ASSUME_NONNULL_END
