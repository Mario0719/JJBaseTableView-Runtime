//
//  JJBaseCollectionView+Placeholder.m
//  MyRAC
//
//  Created by Mario on 2019/8/5.
//  Copyright © 2019 MS. All rights reserved.
//

#import "JJBaseCollectionView+Placeholder.h"
#import "NSObject+Swizzling.h"

@implementation JJBaseCollectionView (Placeholder)

+ (void)load{
    [self methodSwizzlingWithOriginalSelector:@selector(reloadData) bySwizzledSelector:@selector(jj_reloadData)];
    [self methodSwizzlingWithOriginalSelector:@selector(reloadSection:withRowAnimation:) bySwizzledSelector:@selector(jj_reloadSection:withRowAnimation:)];
    [self methodSwizzlingWithOriginalSelector:@selector(reloadSections:withRowAnimation:) bySwizzledSelector:@selector(jj_reloadSections:withRowAnimation:)];
}
// 新建reloadData 方法
- (void)jj_reloadData{
    // TODO:
    [self jj_checkDataSources];
    [self jj_reloadData];
}
// 新建reloadSection
- (void)jj_reloadSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation{
    // TODO:
    [self jj_checkDataSources];
    [self jj_reloadSection:section withRowAnimation:animation];
    
    
}
// 新建reloadSection
- (void)jj_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    // TODO:
    [self jj_checkDataSources];
    [self jj_reloadSections:sections withRowAnimation:animation];
}

// 检查数据源
- (void)jj_checkDataSources{
    BOOL isEmpty = YES;  // 空数据 flag
    
    id<UICollectionViewDataSource> dataSource = self.dataSource;
    
    NSUInteger sections = 1;  //  默认一个分区
    
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]){
        sections = [dataSource numberOfSectionsInCollectionView:self] - 1;  // 获取当前collectionView 数组
    }
    for (int i = 0; i <= sections; i++) {
        NSUInteger rows = [dataSource collectionView:self numberOfItemsInSection:i];
        if (rows > 0) {
            isEmpty = NO;
            break;
        }
    }
    
    if (isEmpty) {
        // 空数据处理：加载占位图
        if (!self.placeholderView) {
            [self makeDefaultPlaceholderView];
        }
        self.placeholderView.hidden = NO;
        [self addSubview:self.placeholderView];
    }else{
        // 非空数据处理：隐藏占位图
        self.placeholderView.hidden = YES;
    }

}


// 加载占位图
- (void)makeDefaultPlaceholderView{
    self.placeholderView = [JJCustomView new];
    self.placeholderView.hidden = YES;
    [self addSubview:self.placeholderView];
    // 如果设置了 点击回调，设置触发回调手势
    if (self.collectionViewPlaceholderBlock) {
        __weak typeof(self) weakSelf = self;
        [self.placeholderView.iconView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            weakSelf.collectionViewPlaceholderBlock();
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
