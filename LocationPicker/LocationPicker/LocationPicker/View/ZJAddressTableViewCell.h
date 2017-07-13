//
//  ZJAddressTableViewCell.h
//  LocationPicker
//
//  Created by 郑键 on 2017/7/12.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJAddressModel;

UIKIT_EXTERN NSString * ZJAddressTableViewCellReId;

@interface ZJAddressTableViewCell : UITableViewCell

@property (nonatomic, strong) ZJAddressModel *addressModel;
@property (nonatomic, strong) UIColor *selectedTintColor;
@property (nonatomic, strong) UIImage *selectedImage;

@end
