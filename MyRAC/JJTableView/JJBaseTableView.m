//
//  JJBaseTableView.m
//  MyRAC
//
//  Created by Mario on 2019/8/2.
//  Copyright © 2019 MS. All rights reserved.
//

#import "JJBaseTableView.h"
#import <MJRefresh/MJRefresh.h>

#import "JJBaseTableView+Placeholder.h"
#import "JJBaseTableView+Network.h"

@interface JJBaseTableView ()

@property (nonatomic, assign) BOOL networkEnable;

@end

@implementation JJBaseTableView

- (instancetype)init{
    self = [super init];
    [self configTableView];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self configTableView];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    [self configTableView];
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self configTableView];
}



// 初始化基础配置
- (void)configTableView{
    if (@available(iOS 11.0, *)) {
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16);
    self.separatorColor = [UIColor cyanColor];
    
    self.tableFooterView = [UIView new];
    
    self.enableRefresh = NO;
    self.enableLoadMore = NO;
    self.autoNetworkNotice = NO;
   
    [self makeDefaultNetworkStatusView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChange:) name:@"kNetworkChange" object:nil];
}
// 监听网络变化
- (void)networkStatusChange:(NSNotification *)obj{
    
    if (!self.autoNetworkNotice) return;
    _networkEnable = [obj.object boolValue];
    
    if (_networkEnable) {
        self.mj_header.ignoredScrollViewContentInsetTop = 0;   // Y偏移 0
        
        self.networkView.hidden = YES;  // 隐藏 网络状态
        
        UIEdgeInsets edgeInset = self.contentInset;
        [UIView animateWithDuration:0.25 animations:^{
            self.contentInset = UIEdgeInsetsMake(0, edgeInset.left, edgeInset.bottom, edgeInset.right);
        }];
    }else{
        self.mj_header.ignoredScrollViewContentInsetTop = 40;  // Y偏移 40
        
        self.networkView.hidden = NO;  // 显示 网络状态
        
        UIEdgeInsets edgeInset = self.contentInset;
        [UIView animateWithDuration:0.25 animations:^{
            self.contentInset = UIEdgeInsetsMake(40, edgeInset.left, edgeInset.bottom, edgeInset.right);
        }];
        
        // 断网 停止刷新、加载
        if (self.mj_header.refreshing) {
            [self.mj_header endRefreshing];
        }
        if (self.mj_footer.refreshing) {
            [self.mj_footer endRefreshing];
        }
    }
}





- (void)setEnableRefresh:(BOOL)enableRefresh{
    if (!enableRefresh) self.mj_header = nil;
    else {
        __weak typeof(self) weakSelf = self;
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (weakSelf.tableViewHeaderRefresh) weakSelf.tableViewHeaderRefresh();
        }];
        self.mj_header.automaticallyChangeAlpha = YES;
    }
}

- (void)setEnableLoadMore:(BOOL)enableLoadMore{
    if (!enableLoadMore) self.mj_footer = nil;
    else{
        __weak typeof(self) weakSelf = self;
        self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            if (weakSelf.tableViewFooterLoadMore) weakSelf.tableViewFooterLoadMore();
        }];
        self.mj_footer.automaticallyChangeAlpha = YES;
    }
}
// MARK: - 公开方法

/** 开始刷新动画 */
- (void)beginRefresh{
    if (self.mj_header) [self.mj_header beginRefreshing];
}

/** 停止刷新动画 */
- (void)endingRefresh{
    if (self.mj_header) [self.mj_header endRefreshing];
}

/** 开始加载更多动画 */
- (void)beginLoadMore{
    if (self.mj_footer) [self.mj_footer beginRefreshing];
}

/** 停止加载更多动画 */
- (void)endingLoadMore{
    if (self.mj_footer) [self.mj_footer endRefreshing];
}

/** 停止加载更多动画，并提示没有更多内容 */
- (void)endingNoMoreData{
    if (self.mj_footer) [self.mj_footer endRefreshingWithNoMoreData];
}

// 设置placeholder 图片 文案
- (void)setPlaceholderIcon:(NSString *)iconName text:(NSString *)text{
    [self.placeholderView setText:text];
    [self.placeholderView setIconName:iconName];
}

// 设置placeholder 图片
- (void)setPlaceholderIcon:(NSString *)iconName{
    [self.placeholderView setIconName:iconName];
}

// 设置placeholder 文案
- (void)setPlaceholderText:(NSString *)text{
    [self.placeholderView setText:text];
}

// 设置placeholder背景颜色
- (void)setPlaceholderBackgroundColor:(UIColor *)color{
    self.placeholderView.backgroundColor = color;
}

@end
