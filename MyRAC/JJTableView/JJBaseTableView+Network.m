//
//  JJBaseTableView+Network.m
//  MyRAC
//
//  Created by Mario on 2019/8/2.
//  Copyright © 2019 MS. All rights reserved.
//

#import "JJBaseTableView+Network.h"

@implementation JJBaseTableView (Network)

- (void)makeDefaultNetworkStatusView{    
    self.networkView = [UIView new];
    self.networkView.frame = CGRectMake(0, -40, kScreenWidth, 40);
    self.networkView.backgroundColor = [UIColor colorWithRed:252.0f/255.0f green:236.0f/255.0f blue:237.0f/255.0f alpha:1.0f];
    self.networkView.hidden = YES;
    [self addSubview:self.networkView];
    
    
    UILabel *label = [UILabel new];
    label.text = @"当前网络不可用，请检查你的网络设置";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:136.0f/255.0f green:136.0f/255.0f blue:136.0f/255.0f alpha:1.0f];
    label.font = [UIFont systemFontOfSize:12];
    [self.networkView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.networkView);
    }];
    __weak typeof(self) weakSelf = self;
    [self.networkView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        NSLog(@"跳转至网络设置页面");
    }]];
    
}


// 占位图
- (UIView *)networkView{
    return objc_getAssociatedObject(self, @selector(networkView));
}

- (void)setNetworkView:(UIView *)networkView{
    return objc_setAssociatedObject(self, @selector(networkView), networkView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
