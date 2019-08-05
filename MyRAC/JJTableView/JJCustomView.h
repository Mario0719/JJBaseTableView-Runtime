//
//  JJCustomView.h
//  MyRAC
//
//  Created by Mario on 2019/8/2.
//  Copyright © 2019 MS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface JJCustomView : UIView

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *textLabel;

/** icon  */
@property (nonatomic, copy) NSString *iconName;
/** 提示文本 */
@property (nonatomic, copy) NSString *text;


/** 设置 立即登录 placeholderView */
- (void)makeLoginPlaceholderView;

/** 设置 空数据 placeholderView */
- (void)makeEmptyDataSourcePlaceholderView;

/** 设置 网络异常 placeholderView */
- (void)makeNetwrokErrorPlaceholderView;

@end

NS_ASSUME_NONNULL_END
