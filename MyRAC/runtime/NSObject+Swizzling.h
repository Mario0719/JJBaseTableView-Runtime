//
//  NSObject+Swizzling.h
//  MyRAC
//
//  Created by Mario on 2019/8/2.
//  Copyright © 2019 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzling)


/**
 利用runtime 进行方法交换

 @param originalSelector 原方法（系统方法）
 @param swizzledSelector 混合方法 （自定义方法）
 */
+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector
                         bySwizzledSelector:(SEL)swizzledSelector;

@end

NS_ASSUME_NONNULL_END
