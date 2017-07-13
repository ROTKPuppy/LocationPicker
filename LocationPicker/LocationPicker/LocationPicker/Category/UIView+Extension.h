//
//  UIView+Extension.h
//  Project
//
//  Created by 郑键 on 17/1/11.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (assign, nonatomic) CGFloat   ex_x;
@property (assign, nonatomic) CGFloat   ex_y;
@property (assign, nonatomic) CGFloat   ex_width;
@property (assign, nonatomic) CGFloat   ex_height;
@property (assign, nonatomic) CGSize    ex_size;
@property (assign, nonatomic) CGPoint   ex_origin;
@property (assign, nonatomic) CGFloat   ex_centerX;
@property (assign, nonatomic) CGFloat   ex_centerY;

/**
 *  添加单击事件
 *
 *  @param target 对象
 *  @param selector 事件
 */
- (void)ex_addTapAction:(id)target selector:(SEL)selector;

/**
 *  添加长按事件
 *
 *  @param target 对象
 *  @param selector 事件
 */
- (void)ex_addLongPressAction:(id)target selector:(SEL)selector;

/**
 *  获取View所在控制器
 *
 *  @return view所在控制器
 */
- (UIViewController *)ex_viewController;

/**
 *  设置圆角
 *
 *  @param cornerRadius 圆角角度
 */
- (void)ex_setCornerRadius:(CGFloat)cornerRadius;

/**
 *  添加高斯模糊
 *
 *  @param style 高斯模糊种类
 */
- (void)ex_setBlurEffect:(UIBlurEffectStyle)style;

/**
 *  添加阴影
 *
 *  @param color 阴影颜色
 */
- (void)ex_addShadowWithColor:(UIColor *)color;

@end
