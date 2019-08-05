//
//  JJBaseTableView+Placeholder.m
//  MyRAC
//
//  Created by Mario on 2019/8/2.
//  Copyright © 2019 MS. All rights reserved.
//

#import "JJBaseTableView+Placeholder.h"
#import "NSObject+Swizzling.h"

@interface JJBaseTableView ()

@end

@implementation JJBaseTableView (Placeholder)

+ (void)load{
    [self methodSwizzlingWithOriginalSelector:@selector(reloadData) bySwizzledSelector:@selector(jj_reloadData)];
    [self methodSwizzlingWithOriginalSelector:@selector(reloadSection:withRowAnimation:) bySwizzledSelector:@selector(jj_reloadSection:withRowAnimation:)];
}

// 新建reloadData 方法
- (void)jj_reloadData{
    // TODO:
    [self jj_checkDataSources];
    [self jj_reloadData];
    [self endingRefresh];
    [self endingLoadMore];
}
// 新建reloadSection
- (void)jj_reloadSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation{
    // TODO:
    [self jj_checkDataSources];
    [self jj_reloadSection:section withRowAnimation:animation];
}

// 检查数据源
- (void)jj_checkDataSources{
    BOOL isEmpty = YES;  // 空数据 flag
    
    id<UITableViewDataSource> dataSource = self.dataSource;
    
    NSUInteger sections = 1;  // 默认考虑只有一个分区的 tableView
    
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [dataSource numberOfSectionsInTableView:self] - 1;  // 获取分区总数量
    }
    for (int i = 0; i<= sections; i++) {
        NSUInteger rows = [dataSource tableView:self numberOfRowsInSection:i];
        if (rows > 0) {
            isEmpty = NO;  // 数据不为空
            break;
        }
    }
    
    if (isEmpty) {
        if (!self.placeholderView) {
            [self makeDefaultPlaceholderView];
        }
        self.placeholderView.hidden = NO;
    }else{
        self.placeholderView.hidden = YES;
    }
    
}

// 加载占位图
- (void)makeDefaultPlaceholderView{
    self.placeholderView = [JJCustomView new];
    [self.placeholderView makeEmptyDataSourcePlaceholderView];
    self.placeholderView.hidden = YES;
    [self addSubview:self.placeholderView];
    
    // 如果设置了 点击回调，设置触发回调手势
    if (self.tableViewPlaceholderBlock) {
        __weak typeof(self) weakSelf = self;
        [self.placeholderView.iconView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            weakSelf.tableViewPlaceholderBlock();
        }]];
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.placeholderView.frame = self.bounds;
}

// MARK: - Setter && Getter

// 占位图
- (JJCustomView *)placeholderView{
    return objc_getAssociatedObject(self, @selector(placeholderView));
}
- (void)setPlaceholderView:(JJCustomView *)placeholderView{
    return objc_setAssociatedObject(self, @selector(placeholderView), placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



@end
