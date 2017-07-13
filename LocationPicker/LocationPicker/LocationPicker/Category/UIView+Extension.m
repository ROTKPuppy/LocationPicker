//
//  UIView+Extension.m
//  Project
//
//  Created by 郑键 on 17/1/11.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

/**
 *  添加单击事件
 *
 *  @param target 对象
 *  @param selector 事件
 */
- (void)ex_addTapAction:(id)target selector:(SEL)selector
{
    UITapGestureRecognizer *tapGestureRecognizer        = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    tapGestureRecognizer.numberOfTapsRequired           = 1;
    self.userInteractionEnabled                         = YES;
    [self addGestureRecognizer:tapGestureRecognizer];
}

/**
 *  添加长按事件
 *
 *  @param target 对象
 *  @param selector 事件
 */
- (void)ex_addLongPressAction:(id)target selector:(SEL)selector
{
    UILongPressGestureRecognizer *recognizer            = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:selector];
    self.userInteractionEnabled                         = YES;
    [self addGestureRecognizer:recognizer];
}

/**
 *  获取View所在控制器
 *
 *  @return view所在控制器
 */
- (UIViewController *)ex_viewController
{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder                      = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

/**
 *  设置圆角
 *
 *  @param cornerRadius 圆角角度
 */
- (void)ex_setCornerRadius:(CGFloat)cornerRadius
{
    UIBezierPath *maskPath                              = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                                                byRoundingCorners:UIRectCornerAllCorners
                                                                                      cornerRadii:self.bounds.size];
    CAShapeLayer *maskLayer                             = [[CAShapeLayer alloc]init];
    maskLayer.frame                                     = self.bounds;
    maskLayer.path                                      = maskPath.CGPath;
    self.layer.mask                                     = maskLayer;
}

/**
 *  添加高斯模糊
 *
 *  @param style 高斯模糊种类
 */
- (void)ex_setBlurEffect:(UIBlurEffectStyle)style
{
    UIBlurEffect *blur                      = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *effectview          = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame                        = self.bounds;
    [self insertSubview:effectview atIndex:0];
}

#pragma mark - properties--setter&getter

- (void)setEx_x:(CGFloat)ex_x
{
    CGRect frame                                        = self.frame;
    frame.origin.x                                      = ex_x;
    self.frame                                          = frame;
}

- (CGFloat)ex_x
{
    return self.frame.origin.x;
}

- (void)setEx_y:(CGFloat)ex_y
{
    CGRect frame                                        = self.frame;
    frame.origin.y                                      = ex_y;
    self.frame                                          = frame;
}

- (CGFloat)ex_y
{
    return self.frame.origin.y;
}

- (void)setEx_width:(CGFloat)ex_width
{
    CGRect frame                                        = self.frame;
    frame.size.width                                    = ex_width;
    self.frame                                          = frame;
}

- (CGFloat)ex_width
{
    return self.frame.size.width;
}

- (void)setEx_height:(CGFloat)ex_height
{
    CGRect frame                                        = self.frame;
    frame.size.height                                   = ex_height;
    self.frame                                          = frame;
}

- (CGFloat)ex_height
{
    return self.frame.size.height;
}

- (void)setEx_size:(CGSize)ex_size
{
    CGRect frame                                        = self.frame;
    frame.size                                          = ex_size;
    self.frame                                          = frame;
}

- (CGSize)ex_size
{
    return self.frame.size;
}

- (void)setEx_origin:(CGPoint)ex_origin
{
    CGRect frame                                        = self.frame;
    frame.origin                                        = ex_origin;
    self.frame                                          = frame;
}

- (CGPoint)ex_origin
{
    return self.frame.origin;
}


-(void)setEx_centerX:(CGFloat)ex_centerX
{
    CGPoint center                                      = self.center;
    center.x                                            = ex_centerX;
    self.center                                         = center;
}

-(CGFloat)ex_centerX
{
    return self.center.x;
}

-(void)setEx_centerY:(CGFloat)ex_centerY
{
    CGPoint center                                      = self.center;
    center.y                                            = ex_centerY;
    self.center                                         = center;
}

-(CGFloat)ex_centerY
{
    return self.center.y;
}

@end
