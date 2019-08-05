//
//  JJCustomView.m
//  MyRAC
//
//  Created by Mario on 2019/8/2.
//  Copyright © 2019 MS. All rights reserved.
//

#import "JJCustomView.h"

@interface JJCustomView ()

@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation JJCustomView

- (instancetype)init{
    self = [super init];
    self.backgroundColor = [UIColor clearColor];
    return self;
}


// 立即登录 placeholderView
- (void)makeLoginPlaceholderView{
    // todo
}

// 空数据 placeholderView
- (void)makeEmptyDataSourcePlaceholderView{
    [self removeAllSubviews];
    
    self.textLabel.text = @"没有更多数据";
    self.iconView.image = [UIImage imageNamed:@"Empt_ box"];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self);
        make.centerY.equalTo(self).offset(-50);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.textLabel.mas_top).offset(-20);
        make.centerX.equalTo(self);
    }];
}

// 网络异常 placeholderView
- (void)makeNetwrokErrorPlaceholderView{
    [self removeAllSubviews];
    
    self.textLabel.text = @"网络异常，请检查网络状况";
    self.iconView.image = [UIImage imageNamed:@"Empt_ box"];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self);
        make.centerY.equalTo(self).offset(-50);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.textLabel.mas_top).offset(-20);
        make.centerX.equalTo(self);
    }];
}



// setter

- (void)setIconName:(NSString *)iconName{
    self.iconView.image = [UIImage imageNamed:iconName];
}

- (void)setText:(NSString *)text{
    self.textLabel.text = text;
}




// MARK: - 懒加载

- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.userInteractionEnabled = YES;
        [self addSubview:_iconView];
    }
    return _iconView;
}

- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.textColor = [UIColor colorWithDisplayP3Red:95.0f/255.0f green:98.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        _textLabel.font = [UIFont systemFontOfSize:16];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
    }
    return _textLabel;
}


@end
