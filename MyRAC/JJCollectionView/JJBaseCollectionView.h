//
//  JJBaseCollectionView.h
//  MyRAC
//
//  Created by Mario on 2019/8/5.
//  Copyright © 2019 MS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 下拉刷新回调 */
typedef void(^headerRefresh)(void);
/** 上拉加载回调 */
typedef void(^footerLoadMore)(void);
/** 点击触发事件 */
typedef void(^clickPlaceholderBlock)(void);

@interface JJBaseCollectionView : UICollectionView

/** 是否允许 下拉刷新（默认 NO） */
@property (nonatomic, assign) BOOL enableRefresh;
/** 是否允许 上拉加载更多 （默认 NO） */
@property (nonatomic, assign) BOOL enableLoadMore;

/** 是否加入断网自动提示 （默认 NO） */
@property (nonatomic, assign) BOOL autoNetworkNotice;

/** 刷新回调 */
@property (nonatomic, copy) headerRefresh collectionViewHeaderRefresh;
/** 加载回调 */
@property (nonatomic, copy) footerLoadMore collectionViewFooterLoadMore;

/** 点击空数据 水印图 回调 */
@property (nonatomic, copy) clickPlaceholderBlock collectionViewPlaceholderBlock;  //  e.g 重新加载数据、提示网络异常页面

// MARK: - 公开方法

/** 开始刷新动画 */
- (void)beginRefresh;

/** 停止刷新动画 */
- (void)endingRefresh;

/** 开始加载更多动画 */
- (void)beginLoadMore;

/** 停止加载更多动画 */
- (void)endingLoadMore;

/** 停止加载更多动画，并提示没有更多内容 */
- (void)endingNoMoreData;

/**
 设置placeholder
 
 @param iconName icon
 @param text 文案
 */
- (void)setPlaceholderIcon:(NSString *)iconName text:(NSString *)text;

/** 设置 placeholder icon */
- (void)setPlaceholderIcon:(NSString *)iconName;

/** 设置 placeholder 文案 */
- (void)setPlaceholderText:(NSString *)text;

/** 设置背景颜色 */
- (void)setPlaceholderBackgroundColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
