//
//  ZJLocationPickerViewController.h
//  LocationPicker
//
//  Created by 郑键 on 2017/7/11.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedCallBack)(NSString *address);

@interface ZJLocationPickerViewController : UIViewController

/**
 初始化地址选择器

 @param title                           标题文字  可为nil
 @param closeImage                      关闭图片  可为nil
 @param marginLineBackgroundColor       分割线颜色  可为nil
 @param selectedTintColor               选中的填充颜色  可为nil
 @param selectedImage                   选中的图片  可为nil
 @param selectedCallBack                选完回调  必传
 @return                                地址选择器 返回格式 XX XX XX
 */
+ (instancetype)locationPickerViewController:(NSString *)title
                                  closeImage:(UIImage *)closeImage
                   marginLineBackgroundColor:(UIColor *)marginLineBackgroundColor
                           selectedTintColor:(UIColor *)selectedTintColor
                               selectedImage:(UIImage *)selectedImage
                            selectedCallBack:(SelectedCallBack)selectedCallBack;

@end
